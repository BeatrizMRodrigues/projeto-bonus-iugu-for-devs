class Fatura
  
  attr_accessor :token, :status, :due_date, :payment_method, :amount

  def initialize(token: , status: , due_date: , payment_method: , amount: )
    @token = token
    @status = status
    @due_date = due_date
    @payment_method = payment_method
    @amount = amount
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
    amount = cobranca.amount.gsub(/[R$,]/, 'R$' => '', ',' => '')
    amount = '%010d'%amount
  end
end