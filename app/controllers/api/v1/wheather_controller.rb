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
    end
  end
end
