require 'invoice'
class Payment < Invoice
  
  attr_accessor :token, :status, :due_date, :payment_method, :amount, :return_date

  def initialize(token:, status:, due_date:, payment_method:, amount:, return_date:)
    super(token: token, status: status, due_date: due_date, payment_method: payment_method, amount: amount)
    @return_date = return_date
    @status = status
  end
end