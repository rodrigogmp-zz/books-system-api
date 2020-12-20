class Book < ApplicationRecord
  mount_uploader :image, BookImageUploader

  belongs_to :publishing_company
  belongs_to :author
  belongs_to :genre

  validates_uniqueness_of :title

	scope :by_title, -> (title) {
		where('title like ?', "%#{title}%")
  }
  
  scope :by_alphabetic_order, -> (order) {
    order = order.to_sym

    return unless [:asc, :desc].include? order

    order(title: order)
  }
end
