class Fatura
  
  attr_accessor :token, :status, :payment_date, :payment_type, :invoice_amount

  def initialize(token: , status: , payment_date: , payment_type: , invoice_amount: )
    @token = token
    @status = status
    @payment_date = payment_date
    @payment_type = payment_type
    @invoice_amount = invoice_amount
  end

  def self.order(fatura)
    cnab = File.open("data/#{Time.now.strftime("%Y%m%d%H%M%S")}_Boleto_emissao.txt", 'w+')
    invoices = JSON.parse(File.read(fatura), symbolize_names: true).each { |order| 
            new(**order)
            cnab.write(order)
    }
  cnab.close
  end 

  def validates
    invoice_amount = cobranca.invoice_amount.gsub(/[R$,]/, 'R$' => '', ',' => '')
    invoice_amount = '%010d'%invoice_amount
  end
end