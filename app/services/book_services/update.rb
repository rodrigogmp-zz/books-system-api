module BookServices
  class Update < ApplicationService
    class NotValidBookRecord < StandardError; end
  
    def initialize(params:, book:)
      @params, @book = params, book
    end

    def call
      create_instance
    end

    private

    def create_instance
      @book_form = BookForm.new(@params)
      byebug
      if @book_form.valid?
        book = @book.update!(@params)
      else
        raise(NotValidBookRecord, @book_form.errors.full_messages)
      end
    end
  end
end