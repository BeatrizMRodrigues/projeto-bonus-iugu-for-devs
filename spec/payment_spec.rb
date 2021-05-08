require 'spec_helper'
require 'payment'
require 'invoice'

describe Payment do
  it 'Cria um objeto do tipo pagamento' do
    invoice = Invoice.new(token: '7c5ae058526ec4964050649e2b526460b1313afe',
                          status: 'Pendente',
                          due_date: '25/04/2020',
                          payment_method: 'Boleto',
                          amount: 'R$ 4500,00')

    payment = Payment.new(token:invoice.token, 
                          due_date: invoice.due_date,
                          payment_method: invoice.payment_method,
                          amount: invoice.amount,
                          return_date: Time.now.strftime('%Y%m%d%H%M%S'), 
                          status:'05')

    expect(payment.class).to eq Payment
    expect(payment.token).to eq '7c5ae058526ec4964050649e2b526460b1313afe'
    expect(payment.due_date).to eq '25/04/2020'
    expect(payment.payment_method).to eq 'Boleto'
    expect(payment.amount).to eq 'R$ 4500,00'
    expect(payment.status).to eq '05'
  end
end