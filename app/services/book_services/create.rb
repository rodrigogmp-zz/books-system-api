module BookServices
  class Create < ApplicationService
    class NotValidBookRecord < StandardError; end
  
    def initialize(params:)
      @params = params
    end

    def call
      create_instance
    end

    private

    def create_instance
      @book_form = BookForm.new(@params)
      
      if @book_form.valid?
        book = Book.new(@params)
        book.save!
      else
        raise(NotValidBookRecord, @book_form.errors.full_messages)
      end
    end
  end
end