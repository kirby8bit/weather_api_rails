module API
  module V1
    class WheatherController < ApplicationController
      def historical
        indications = WheatherUpdater.call

        render json: { action: "temperature by 24 hours in Moscow", data: indications  }, status: 200
      end

      def current
        indications = CurrentWheatherUpdater.call
        render json: { action: "current temperature in Moscow", data: indications  }, status: 200
      end

      def min
        indications = Indication.where(id: WheatherUpdater.call.pluck(:id)).order(temperature: :asc).first
        render json: { action: "min temperature by 24 hours in Moscow", data: indications  }, status: 200
      end

      def max
        indications = Indication.where(id: WheatherUpdater.call.pluck(:id)).order(temperature: :desc).first
        render json: { action: "max temperature by 24 hours in Moscow", data: indications  }, status: 200
      end

      def avg
        indications = (WheatherUpdater.call.pluck(:temperature).sum/24).round(2)
        render json: { action: "avg temperature by 24 hours in Moscow", data: indications  }, status: 200
      end

      def by_time
        indications = Indication.find_by(epochTime: actual_params[:epochTime])
        if indications.present?
          render json: { action: " temperature by this time in Moscow", data: indications  }, status: 200
        else
          render json: { message: "temperature by this time is not found" }, status: 404
        end
      end

      private

      def actual_params
        params.permit(:epochTime)
      end
    end
  end
end
