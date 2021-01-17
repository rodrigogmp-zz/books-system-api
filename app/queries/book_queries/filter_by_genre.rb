module BookQueries
  class FilterByGenre < BaseQuery
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
      .where(genre_id: @params[:id])
      .paginate(page: @params[:page], 
                per_page: @params[:per_page])
      .includes(:genre)
    end
  end
end