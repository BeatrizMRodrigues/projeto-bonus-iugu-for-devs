# frozen_string_literal: true

class Invoice

  attr_reader :token, :status, :due_date, :payment_method, :amount

  def initialize(token:, status:, due_date:, payment_method:, amount:)
    @token = token
    @status = status
    @due_date = due_date
    @payment_method = payment_method
    @amount = amount
  end

  def self.order(fatura)
    data = File.open("data/#{Time.now.strftime('%Y%m%d%H%M%S')}_Boleto_emissao.txt", 'w+')
    data.write("H 00000 \n")
    body(data, fatura)
    data.close
  end

  def self.body(data, fatura)
    invoice_sum = 0
    amount_sum = 0
    JSON.parse(File.read(fatura), symbolize_names: true).each do |order|
      new(**order)
      data.write("B #{order[:token]} #{due_date(order)} #{amount_validates(order)} #{status(order)}  \n")
      invoice_sum += 1
      amount_sum += amount_validates(order).to_i
    end
    footer(data, amount_sum)
    header(data, invoice_sum)
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

  def self.header(data, invoice_sum)
    invoice_sum = '%05d' % invoice_sum
    data.seek(0, IO::SEEK_SET)
    data.write("H #{invoice_sum} \n")
  end

  def self.footer(data, amount_sum)
    amount_sum = '%015d' % amount_sum
    data.write("F #{amount_sum}")
  end
end