class Genre < ApplicationRecord
  has_many :books
  
  validates_uniqueness_of :name

	scope :by_name, -> (name) {
		where('name like ?', "%#{name}%")
  }
  
  scope :by_alphabetic_order, -> (order) {
    order = order.to_sym

    return unless [:asc, :desc].include? order

    order(name: order)
  }
end
