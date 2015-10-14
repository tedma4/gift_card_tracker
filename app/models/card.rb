class Card < ActiveRecord::Base
  require "active_merchant/billing/rails"

  attr_accessor :credit_card_number

  validates :credit_card_number, presence: true
  validates :company, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  validate :valid_card

  def credit_card
    ActiveMerchant::Billing::CreditCard.new(
    		first_name: company,
    		last_name: company,
    		month: 1,
    		year: 2025, 
    		verification_value: 123,
        brand: 'bogus',
        number: credit_card_number
    )
  end

  def valid_card
    if !credit_card.valid?
      errors.add(:base, "The bogus credit card you added doesn't fly. #{credit_card.errors}")
      false
    else
      true
    end
  end

  def process
    if valid_card
      response = GATEWAY.refund(amount * 100, credit_card)
      if response.success?
        transaction = GATEWAY.capture(amount * 100, response.authorization)
        unless transaction.success?
          errors.add(:base, "The credit card you provided was declined.  Please double check your information and try again.") and return
          false
        end
        update_columns({authorization_code: transaction.authorization, success: true})
        true
      else
        errors.add(:base, "The credit card you provided was declined.  Please double check your information and try again.") and return
        false
      end
    end
  end
end
