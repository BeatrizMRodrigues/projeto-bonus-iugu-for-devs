class Invoice
  
  attr_accessor :token, :status, :due_date, :payment_method, :amount

  def initialize(token: , status: , due_date: , payment_method: , amount: )
    @token = token
    @status = status
    @due_date = due_date
    @payment_method = payment_method
    @amount = amount
  end

  def self.order(fatura)
    data = File.open("data/#{Time.now.strftime("%Y%m%d%H%M%S")}_Boleto_emissao.txt", 'w+')
    JSON.parse(File.read(fatura), symbolize_names: true).each { |order| 
            new(**order)
            data.write('B' + order[:token] + due_date(order) + order[:payment_method] + order[:status] + amount_validates(order) + "\n")
    }
    data.close
  end 

  def self.amount_validates(order)
    amount = order[:amount].to_s
    amount = amount.gsub(/[R$,]/, 'R$' => '', ',' => '')
    amount = '%010d'%amount
  end

  def self.due_date(order)
    due_date = order[:due_date].to_date.strftime("%Y%m%d")
  end

  def self.status
  end
end