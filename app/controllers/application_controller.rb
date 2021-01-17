class ApplicationController < ActionController::API
	rescue_from ActiveRecord::RecordNotFound do |e|
		render json: { error: e.message }, status: :not_found
	end

	rescue_from ActiveRecord::RecordInvalid do |e| 
		render json: { error: e.message }, status: :unprocessable_entity
	end

	rescue_from ActionController::ParameterMissing do |e|
		render json: { error: e.message }, status: :bad_request
	end
end
