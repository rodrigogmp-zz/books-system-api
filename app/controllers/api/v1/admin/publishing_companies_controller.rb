class Api::V1::Admin::PublishingCompaniesController < ApplicationController
	before_action :authenticate_admin!
	before_action :set_publishing_company, except: [:index, :create]

	def create
		@publishing_company = PublishingCompany.create(publishing_company_params)
		if @publishing_company.errors.any?
			return render json: { errors: @publishing_company.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		unless @publishing_company.update(publishing_company_params)
			return render json: { errors: @publishing_company.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		@publishing_company.destroy
	end

	private

	def publishing_company_params
		params.require(:name)
		params.permit(:name)
	end

	def set_publishing_company
		@publishing_company = PublishingCompany.find(params[:id])
	end
end
