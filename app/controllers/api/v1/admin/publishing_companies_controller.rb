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

	def show
	end

	def index
		params[:page] ||= 1
		params[:per_page] ||= 10

		@publishing_companies = 
			PublishingCompany
				.filter(by_name: params[:name])
				.paginate(page: params[:page], 
									per_page: params[:per_page])
		
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
