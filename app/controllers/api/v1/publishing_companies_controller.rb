class Api::V1::PublishingCompaniesController < ApplicationController
  before_action :set_publishing_company, except: :index

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
	
	def books
		params[:page] ||= 1
		params[:per_page] ||= 10

		@books =	Book
                .filter(by_title: params[:name],
                        by_genre: params[:genre],
                        by_publishing_company: params[:publishing_company],
                        by_alphabetic_order: params[:order])
                .where(publishing_company_id: @publishing_company.id)
                .paginate(page: params[:page], 
                          per_page: params[:per_page])
	end
  
  private

  def set_publishing_company
    @publishing_company = PublishingCompany.find(params[:id])
  end
end
