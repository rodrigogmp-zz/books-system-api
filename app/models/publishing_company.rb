class PublishingCompany < ApplicationRecord
	has_many :books

	validates_uniqueness_of :name

	scope :by_name, -> (name) {
		where('name like ?', "%#{name}%")
	}
end
