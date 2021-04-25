class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
    	t.integer :loan_id
    	t.decimal :paid_amount, precision: 8, scale: 2
    	t.datetime :payment_date
    end
  end
end
