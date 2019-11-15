class Address < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :country, presence: true
end
