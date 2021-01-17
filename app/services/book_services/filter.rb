module BookServices
  class Filter < ApplicationService
    def initialize(class_instance: nil, params:)
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
        BookQueries::FilterByAuthor.call(params: @params)
      when 'Genre'
        BookQueries::FilterByGenre.call(params: @params)
      when 'PublishingCompany'
        BookQueries::FilterByPublishingCompany.call(params: @params)
      else
        BookQueries::Filter.call(params: @params)
      end
    end
  end
end