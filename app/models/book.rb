class Book < ApplicationRecord
  mount_uploader :image, BookImageUploader

  belongs_to :publishing_company
  belongs_to :author
  belongs_to :genre

  validates_uniqueness_of :title

	scope :by_title, -> (title) {
		where('title like ?', "%#{title}%")
	}
end
