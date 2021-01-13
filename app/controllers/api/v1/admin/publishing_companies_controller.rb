class Api::V1::Admin::PublishingCompaniesController < Api::V1::Admin::BaseController
	before_action :set_publishing_company, except: [:index, :create]

	def create
		@publishing_company = PublishingCompany.create!(publishing_company_params)
	end

	def update
		@publishing_company.update!(publishing_company_params)
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
