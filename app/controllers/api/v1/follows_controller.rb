module Api
  module V1
    class FollowsController < ApplicationController
      include TimeTrackUtils
      before_action :set_user_follow, only: [:unfollow, :time_tracks]
      def follow
        user_follow = current_user.user_follows.new(follow_params)
        if user_follow.save
          render json: { status: :ok }
        else
          render status: :unprocessable_entity, json: {
            status: :unprocessable_entity,
            errors: { message: user_follow.errors }
          }
        end
      end

      def unfollow
        if @user_follow&.destroy
          render json: { status: :ok }
        else
          render status: :unprocessable_entity, json: {
            status: :unprocessable_entity,
            errors: { message: @user_follow.errors }
          }
        end
      end

      def time_tracks
        time_tracks = @user_follow.follower.time_tracks.last_week
        render json: {
          data: sort_by_sleep_hour(time_tracks.as_json(TimeTrack.render_json_opt))
        }
      end

      private

      def follow_params
        params.require(:user_follow).permit(UserFollow::EXPOSE_ATTRIBUTE)
      end

      def set_user_follow
        @user_follow = current_user.user_follows.find(params[:follow_id])
      end
    end
  end
end