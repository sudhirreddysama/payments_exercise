class LoansController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
  	loans = []
  	Loan.all.each do |loan|
  		payments = loan.payments
  		balance = loan.funded_amount - payments.sum(:paid_amount)
  		loans << {id: loan.id, funded_amount: loan.funded_amount, outstanding_balance: balance, payments: payments}
  	end
    render json: loans
  end

  def show
  	loan = Loan.find(params[:id])
  	payments = loan.payments
  	balance = loan.funded_amount - payments.sum(:paid_amount)
    render json: {id: loan.id, funded_amount: loan.funded_amount, outstanding_balance: balance, payments: payments}
  end
end
