class Api::V1::PublishingCompaniesController < ApplicationController
  before_action :set_publishing_company, only: :show

  def show
	end

	def index
		params[:page] ||= 1
		params[:per_page] ||= 10

		@publishing_companies = 
			PublishingCompany
				.filter(by_name: params[:name],
								by_alphabetic_order: params[:order])
				.paginate(page: params[:page], 
									per_page: params[:per_page])
		
  end
  
  private

  def set_publishing_company
    @publishing_company = PublishingCompany.find(params[:id])
  end
end
