class Card < ActiveRecord::Baserequire "active_merchant/billing/rails"

  attr_accessor :credit_card_number
  validates :credit_card_number, presence: true
  validates :company, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  validate :valid_card

  def credit_card
    ActiveMerchant::Billing::CreditCard.new(
      number:              credit_card_number,
    )
  end

  def valid_card
    if !credit_card.valid?
      errors.add(:base, "The credit card information you provided is not valid.  Please double check the information you provided and then try again.")
      false
    else
      true
    end
  end

  def process
    if valid_card
      response = GATEWAY.authorize(amount * 100, credit_card)
      if response.success?
        transaction = GATEWAY.capture(amount * 100, response.authorization)
        if !transaction.success?
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
