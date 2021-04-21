class Fatura
  
  attr_accessor :token, :status, :payment_date, :return_date, :payment_type

  def initialize(token: , status: , payment_date: , return_date: '          ' , payment_type:  )
    @token = token
    @status = status
    @payment_date = payment_date
    @return_date = return_date
    @payment_type = payment_type
  end

  def self.to_convert(fatura)
    cobranca = JSON.parse(File.read(fatura))
    cobranca = Fatura.new(token: cobranca['token'],
               status: cobranca['status'],
               payment_date: cobranca['payment_date'],
               return_date: cobranca['return_date'],
               payment_type: cobranca['payment_type'])

    escrita = File.open("data/#{Time.now.to_i}_#{cobranca.payment_type}.txt", 'w+')
    escrita.write(cobranca.token + cobranca.status + cobranca.payment_type + cobranca.payment_date)
    escrita.close
  end
end