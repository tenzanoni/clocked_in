require 'rails_helper'

describe Api::V1::TimeTracksController, type: :controller do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:time_track_sleep) { create(:time_track, user: user1, sleep_at: Time.now) }

  describe 'Show time tracks' do
    it 'list time track (0 record)' do
      get :index, params: { assign_user_id: user2.id }
      expect(JSON.parse(response.body)['data'].size).to eq 0
    end

    it 'list time track (1 record)' do
      get :index, params: { assign_user_id: user1.id }
      expect(JSON.parse(response.body)['data'].size).to eq 1
    end
  end

  describe 'Log time track' do
    it 'go to bed' do
      post :create, params: { assign_user_id: user2.id }
      expect(user2.time_tracks.size).to eq 1
      expect(user2.time_tracks.last.wakeup_at).to be nil
      expect(user2.time_tracks.last.sleep_at).not_to be nil
    end


    it 'wakeup' do
      time_track = user2.time_tracks.create(sleep_at: Time.now)
      post :create, params: { assign_user_id: user2.id }
      time_track.reload
      expect(user2.time_tracks.size).to eq 1
      expect(time_track.wakeup_at).not_to be nil
      expect(time_track.sleep_at).not_to be nil
    end
  end
end
