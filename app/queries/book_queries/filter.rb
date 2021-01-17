module BookQueries
  class Filter < BaseQuery
    def call
      filter
    end

    private

    def filter
      Book
        .filter(by_title: @params[:title],
                by_description: @params[:description],
                by_title_or_description: @params[:title_or_description],
                by_genre: @params[:genre],
                by_author: @params[:author],
                by_publishing_company: @params[:publishing_company],
                by_alphabetic_order: @params[:order])
        .paginate(page: @params[:page], 
                  per_page: @params[:per_page])
        .includes(:author, :publishing_company, :genre)
    end
  end
end