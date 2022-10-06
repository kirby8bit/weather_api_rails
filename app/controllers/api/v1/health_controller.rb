module API
  module V1
    class HealthController < ApplicationController
      def index
        render json: { message: I18n.t(:health) }, status: 200
      end
    end
  end
end
