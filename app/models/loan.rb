class Loan < ActiveRecord::Base
	has_many :payments
end
