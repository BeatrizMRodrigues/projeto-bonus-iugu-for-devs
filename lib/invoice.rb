class Fatura
  
  attr_accessor :token, :status, :payment_date, :return_date, :payment_type

  def initialize(token: , status: , payment_date: , return_date: , payment_type:  )
    @token = token
    @status = status
    @payment_date = payment_date
    @return_date = return_date
    @payment_type = payment_type
  end
end