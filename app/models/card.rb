class Card < ActiveRecord::Base
  require "active_merchant/billing/rails"

  attr_accessor :add_credit, :remove_credit

  validates :cc_num, presence: true, on: :create
  validates :company, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  validate  :valid_card, on: :create
  validate :add_credit, on: :update
  validate  :remove_credit, on: :update

  def credit_card
  	@card = ActiveMerchant::Billing::CreditCard.new(
    		first_name: 'Tom',
    		last_name: 'Tom',
    		month: '1',
    		year: '2025',
        brand: 'visa',
        number: cc_num,
    		verification_value: '123',
    )
  end

  def last_four
    self.cc_num.gsub(/(\d+)(\d{4})/, "\\1").gsub(/\d/, "x") + self.cc_num.gsub(/\d+(\d{4})/, "\\1")
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
    if  self.amount >= value.to_i
      self.update_attribute(:amount, self.amount - value.to_i)
    else
      errors.add :base, "Sorry, You only have #{self.amount} credits left. You need to add some more credits before you can do that."
    end
  end
end