require 'spec_helper'
require 'invoice'

describe Fatura do
  it 'Cria um objeto do tipo fatura' do
    invoice = Fatura.new(token: '7c5ae058526ec4964050649e2b526460b1313afe',
                          status: 'Pendente',
                          payment_date: '25/04/2020',
                          return_date: '          ',
                          payment_type: 'Boleto')

    expect(invoice.class).to eq Fatura
    expect(invoice.token).to eq '7c5ae058526ec4964050649e2b526460b1313afe'
    expect(invoice.status).to eq 'Pendente'
    expect(invoice.payment_date).to eq '25/04/2020'
    expect(invoice.return_date).to eq '          '
    expect(invoice.payment_type).to eq 'Boleto'
  end

  it 'Converte 1 json em 1 objeto e salva em txt' do
    invoice = Fatura.to_convert('invoices-iugu/fatura001.json')
    
    expect(File.read('data/data.txt')).to include('b7d933ca217964802cce9abc9a75da96372fbfef')
    expect(File.read('data/data.txt')).to include('Pendente')
    expect(File.read('data/data.txt')).to include('25/04/2020')
    expect(File.read('data/data.txt')).to include('Boleto')
  end
end