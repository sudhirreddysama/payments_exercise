class Payment < ActiveRecord::Base
	belongs_to :loan
	validate :loan_payment, on: :create

	private
	def loan_payment
		loan_amount = Loan.find_by(id: self.loan_id).funded_amount
		paid_amounts = Payment.where(loan_id: self.loan_id).sum(:paid_amount)
		if (paid_amounts + self.paid_amount) > loan_amount
			errors.add(:paid_amount, "paid amount must be less than loan amount!")
		end
	end
end