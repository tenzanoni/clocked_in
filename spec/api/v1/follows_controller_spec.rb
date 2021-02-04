require 'rails_helper'

describe Api::V1::FollowsController, type: :controller do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:time_track1) { create(:time_track, user: user2) }
  let!(:time_track2) { create(:time_track, user: user2) }

  describe 'follow user' do
    describe 'Successful cases' do
      it 'follow user' do
        expect(user1.user_follows.size).to eq 0
        post :follow, params: { user_follow: { followed_user_id: user2.id } }
        user1.user_follows.reload
        expect(user1.user_follows.size).to eq 1
      end
    end

    describe 'Failed cases' do
      it 'follow user twice' do
        user1.user_follows.create(followed_user_id: user2.id)
        expect(user1.user_follows.size).to eq 1

        post :follow, params: { user_follow: { followed_user_id: user2.id } }
        user1.user_follows.reload
        expect(user1.user_follows.size).to eq 1
        expect(response.code).to eq '422'
      end

      it 'follow unknown user' do
        post :follow, params: { user_follow: { followed_user_id: nil } }
        user1.user_follows.reload
        expect(user1.user_follows.size).to eq 0
        expect(response.code).to eq '422'
      end
    end
  end

  describe 'unfollow user' do
    before do
      @user_follow = UserFollow.create(user_id: user1.id, followed_user_id: user2.id)
    end
    describe 'Successful cases' do
      it 'unfollow user' do
        expect(user1.user_follows.size).to eq 1
        delete :unfollow, params: { follow_id: @user_follow.id }
        user1.user_follows.reload
        expect(user1.user_follows.size).to eq 0
      end
    end

    describe 'Failed cases' do
      it 'unfollow user twice' do
        expect(user1.user_follows.size).to eq 1
        delete :unfollow, params: { follow_id: @user_follow.id }
        delete :unfollow, params: { follow_id: @user_follow.id }
        user1.user_follows.reload
        expect(user1.user_follows.size).to eq 0
        expect(response.code).to eq '404'
      end

      it 'unfollow unknown relationship' do
        unknow_follow = UserFollow.create(user_id: user2.id, followed_user_id: user1.id)
        delete :unfollow, params: { follow_id: unknow_follow.id }
        expect(response.code).to eq '404'
      end
    end
  end

  describe 'view following`s time track' do
    before do
      @user_follow = UserFollow.create(user_id: user1.id, followed_user_id: user2.id)
    end
    describe 'Successful cases' do
      it 'View following track times' do
        get :time_tracks, params: { follow_id: @user_follow.id }
        expect(response.code).to eq '200'
        expect(JSON.parse(response.body)['data'].size).to eq 2
      end

      it 'View following track times (only past week)' do
        user2.time_tracks.create(sleep_at: Time.now)
        expect(user2.time_tracks.size).to eq 3

        get :time_tracks, params: { follow_id: @user_follow.id }
        expect(response.code).to eq '200'
        expect(JSON.parse(response.body)['data'].size).to eq 2
      end

      it 'Order track times by sleep hours' do
        user2.time_tracks.create(sleep_at: 7.days.ago, wakeup_at: 7.days.ago + 72.hours, created_at: 7.days.ago)
        get :time_tracks, params: { follow_id: @user_follow.id }
        expect(response.code).to eq '200'
        expect(JSON.parse(response.body)['data'].size).to eq 3
        expect(JSON.parse(response.body)['data'].last['sleep_hours']).to eq 72
      end
    end

    describe 'Failed cases' do
      it 'View track time of unknown relationship' do
        unknown_follow = UserFollow.create(user_id: user2.id, followed_user_id: user1.id)
        get :time_tracks, params: { follow_id: unknown_follow.id }
        expect(response.code).to eq '404'
      end
    end
  end
end
