module API
  module V1
    class WheatherController < ApplicationController
      def historical
        indications = Indication.last(24)
        render json: { action: I18n.t(:historical), data: json_indications(indications) }, status: 200

      end

      def current
        indications = CurrentWheatherUpdater.call
        render json: { action: I18n.t(:current), data: json_indications(indications) }, status: 200
      end

      def min
        indications = Indication.where(id: Indication.last(24).pluck(:id)).order(temperature: :asc).first
        render json: { action: I18n.t(:min), data: json_indications(indications)  }, status: 200
      end

      def max
        indications = Indication.where(id: Indication.last(24).pluck(:id)).order(temperature: :desc).first
        render json: { action: I18n.t(:max), data: json_indications(indications)  }, status: 200
      end

      def avg
        indications = (Indication.last(24).pluck(:temperature).sum/24).round(2)
        render json: { action: I18n.t(:avg), data: json_indications(indications)  }, status: 200
      end

      def by_time
        indications = Indication.find_by(epochTime: actual_params[:epochTime])
        if indications.present?
          render json: { action: I18n.t(:byTime), data: json_indications(indications)  }, status: 200
        else
          render json: {message: I18n.t(:notFound)}, status: 404
        end
      end

      private

      def actual_params
        params.permit(:epochTime)
      end

      def json_indications(indications)
        indications.as_json(only: [:temperature, :unit, :epochTime])
      end
    end
  end
end
