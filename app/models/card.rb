class Card < ActiveRecord::Base
  require "active_merchant/billing/rails"

  attr_accessor :credit_card_number, :add_credit, :remove_credit

  validates :credit_card_number, presence: true, on: :create
  validates :company, presence: true
  validates :amount, numericality: { greater_than: 0 }

  validate :valid_card, on: :create
  # validates :add_credit, numericality: { greater_than: 0 }, on: :update, allow_blank: true
  # validates :remove_credit, numericality: { greater_than: 0 }, on: :update, allow_blank: true

  def credit_card
  	@card = ActiveMerchant::Billing::CreditCard.new(
    		first_name: 'Tom',
    		last_name: 'Tom',
    		month: '1',
    		year: '2025',
        brand: 'visa',
        number: credit_card_number,
    		verification_value: '123',
    )
  end

  def valid_card
    unless credit_card.valid?
      errors.add(:base, "The bogus credit card you added doesn't fly.")
    end
  end

  def add_credit=(value)
    self.update_attribute(:amount, self.amount + value.to_i)
  end

  def remove_credit=(value)
    if  self.amount > value.to_i
      self.update_attribute(:amount, self.amount - value.to_i)
    else
      errors.add(:base, "The credit card you provided was declined.  Please double check your information and try again.") and return
    end
  end

end
