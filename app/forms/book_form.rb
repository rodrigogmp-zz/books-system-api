class BookForm
  include ActiveModel::Model
  # include ActiveModel::Validator

  attr_accessor :title, :description, :image,
                :publishing_company_id, :author_id,
                :genre_id

                # include ApplicationRecord::validates_uniqueness_of:
  validates_presence_of :title, :description, :author_id,
                        :genre_id, :publishing_company_id, on: :create

  # validates_uniqueness_of :title
  include ApplicationRecord::validates_uniqueness_of, attributes: :title
end