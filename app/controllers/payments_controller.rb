class PaymentsController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end
  def index
  	render json: Payment.where(loan_id: params[:loan_id])
  end
  def create
  	payment = Payment.new(payments_params)
  	payment.payment_date = Time.now
  	if payment.save
  		render json: {status: 201, message: "Your request processed sucssfully!"}
  	else
    	render json: {error: payment.errors.messages, status: 404}
    end
  end

  def show
    render json: Payment.find(params[:id])
  end

  private
  def payments_params
  	params.require(:payment).permit(:paid_amount, :loan_id)
  end
end