module API
  module V1
    class WheatherController < ApplicationController
      def historical
        indications = WheatherUpdater.call
        render json: { action: I18n.t(:historical), data: indications  }, status: 200
      end

      def current
        indications = CurrentWheatherUpdater.call
        render json: { action: I18n.t(:current), data: indications  }, status: 200
      end

      def min
        indications = Indication.where(id: WheatherUpdater.call.pluck(:id)).order(temperature: :asc).first
        render json: { action: I18n.t(:min), data: indications  }, status: 200
      end

      def max
        indications = Indication.where(id: WheatherUpdater.call.pluck(:id)).order(temperature: :desc).first
        render json: { action: I18n.t(:max), data: indications  }, status: 200
      end

      def avg
        indications = (WheatherUpdater.call.pluck(:temperature).sum/24).round(2)
        render json: { action: I18n.t(:avg), data: indications  }, status: 200
      end

      def by_time
        indications = Indication.find_by(epochTime: actual_params[:epochTime])
        if indications.present?
          render json: { action: I18n.t(:byTime), data: indications  }, status: 200
        else
          render json: {message: I18n.t(:notFound)}, status: 404
        end
      end

      private

      def actual_params
        params.permit(:epochTime)
      end
    end
  end
end
