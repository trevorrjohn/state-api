class Address < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :country, presence: true

  before_validation -> { upcase_and_strip(:state, :country) }

  private

  def upcase_and_strip(*attrs)
    attrs.each do |attr|
      public_send("#{attr}=", public_send(attr)&.upcase&.strip)
    end
  end
end
