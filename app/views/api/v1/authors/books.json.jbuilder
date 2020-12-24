json.books @books, partial: '/api/v1/books/book', as: :book

json.total_amount @books.total_entries