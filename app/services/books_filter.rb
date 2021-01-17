class BooksFilter < ApplicationService
  def initialize(class_instance: nil, params:)
    @class_instance = class_instance
    @class = class_instance.class.to_s
    @params = params
  end

  def call
    query_books_by_class
  end

  private
  
  def query_books_by_class
    case @class
    when 'Author'
      query_author_books
    when 'Genre'
      query_genre_books
    when 'PublishingCompany'
      query_publishing_company_books
    else
      query_books
    end
  end

  def query_books
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

  def query_author_books
    Book
      .filter(by_title: @params[:title],
              by_description: @params[:description],
              by_title_or_description: @params[:title_or_description],
              by_genre: @params[:genre],
              by_author: @params[:author],
              by_publishing_company: @params[:publishing_company],
              by_alphabetic_order: @params[:order])
      .where(author_id: @class_instance.id)
      .paginate(page: @params[:page], 
                per_page: @params[:per_page])
      .includes(:author)
  end

  def query_genre_books
    Book
      .filter(by_title: @params[:title],
              by_description: @params[:description],
              by_title_or_description: @params[:title_or_description],
              by_genre: @params[:genre],
              by_author: @params[:author],
              by_publishing_company: @params[:publishing_company],
              by_alphabetic_order: @params[:order])
      .where(genre_id: @class_instance.id)
      .paginate(page: @params[:page], 
                per_page: @params[:per_page])
      .includes(:genre)
  end

  def query_publishing_company_books
    Book
      .filter(by_title: @params[:title],
              by_description: @params[:description],
              by_title_or_description: @params[:title_or_description],
              by_genre: @params[:genre],
              by_author: @params[:author],
              by_publishing_company: @params[:publishing_company],
              by_alphabetic_order: @params[:order])
      .where(publishing_company_id: @class_instance.id)
      .paginate(page: @params[:page], per_page: params[:per_page])
      .includes(:publishing_company)
  end
end