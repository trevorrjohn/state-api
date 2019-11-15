class Address < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validate :state_is_valid_for_country

  before_validation -> { upcase_and_strip(:state, :country) }

  private

  def state_is_valid_for_country
    return unless state_changed? || country_changed?
    return if state.blank? || country.blank?

    validator = StateValidator.new(state: state, country: country)
    return if validator.valid?

    errors.add(:base, validator.error)
  end

  def upcase_and_strip(*attrs)
    attrs.each do |attr|
      public_send("#{attr}=", public_send(attr)&.upcase&.strip)
    end
  end
end
