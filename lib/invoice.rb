class Fatura
  
  attr_accessor :token, :status, :payment_date, :payment_type, :invoice_amount

  def initialize(token: , status: , payment_date: , payment_type: , invoice_amount: )
    @token = token
    @status = status
    @payment_date = payment_date
    @payment_type = payment_type
    @invoice_amount = invoice_amount
  end

  def self.to_convert(fatura)
    cobranca = JSON.parse(File.read(fatura))
    cobranca = Fatura.new(token: cobranca['token'],
                          status: cobranca['status'],
                          payment_date: cobranca['payment_date'],
                          payment_type: cobranca['payment_type'],
                          invoice_amount: cobranca['invoice_amount'])

    
    escrita = File.open("data/#{Time.now.strftime("%Y%m%d%H%M%S")}_#{cobranca.payment_type}_emissao.txt", 'w+')
    escrita.write('B' + cobranca.token + cobranca.payment_date + cobranca.payment_type + cobranca.status)
    escrita.close
  end
end