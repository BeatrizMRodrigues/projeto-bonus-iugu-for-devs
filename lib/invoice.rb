# frozen_string_literal: true

class Invoice

  attr_accessor :token, :status, :due_date, :payment_method, :amount

  def initialize(token:, status:, due_date:, payment_method:, amount:)
    @token = token
    @status = status
    @due_date = due_date
    @payment_method = payment_method
    @amount = amount
  end

  def self.order(fatura)
    data = File.open("data/#{Time.now.strftime('%Y%m%d%H%M%S')}_Boleto_emissao.txt", 'w+')
    JSON.parse(File.read(fatura), symbolize_names: true).each do |order|
      new(**order)
      data.write("B #{order[:token]} #{due_date(order)} #{amount_validates(order)} #{status(order)}  \n")
    end
    data.close
  end

  def self.amount_validates(order)
    amount = order[:amount].to_s
    amount = amount.gsub(/[R$,]/, 'R$' => '', ',' => '')
    '%010d' % amount
  end

  def self.due_date(order)
    order[:due_date].to_date.strftime('%Y%m%d')
  end

  def self.status(order)
    order[:status] = '01' if order[:status] == 'Pendente' || order[:status] == 'Pending'
  end
end
