module Api
  module V1
    class TimeTracksController < ApplicationController
      def index
        render json: { data: current_user.time_tracks.desc_ord.as_json(TimeTrack.render_json_opt) }
      end

      def create
        # let say a sleep period will start with sleep_at and end with wakeup_at
        # if found a record with wakeup_at = nil -> wake up event
        # else go sleep event

        determine_user_event
        if @time_track.save
          render json: { status: :ok }
        else
          render status: :unprocessable_entity, json: {
            status: :unprocessable_entity,
            errors: { message: @time_track.errors }
          }
        end
      end

      private

      def time_track_params
        params.require(:time_track).permit
      end

      def determine_user_event
        @time_track = current_user.time_tracks.not_wakeup.first
        if @time_track
          @time_track.wakeup_at = Time.now
        else
          @time_track = current_user.time_tracks.new(sleep_at: Time.now)
        end
      end
    end
  end
end