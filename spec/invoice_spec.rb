require 'spec_helper'
require 'invoice'

describe Fatura do
  it 'Cria um objeto do tipo fatura' do
    invoice = Fatura.new(token: '7c5ae058526ec4964050649e2b526460b1313afe',
                          status: 'Pendente',
                          payment_date: '25/04/2020',
                          payment_type: 'Boleto',
                          invoice_amount: 'R$ 4500,00')

    expect(invoice.class).to eq Fatura
    expect(invoice.token).to eq '7c5ae058526ec4964050649e2b526460b1313afe'
    expect(invoice.status).to eq 'Pendente'
    expect(invoice.payment_date).to eq '25/04/2020'
    expect(invoice.payment_type).to eq 'Boleto'
    expect(invoice.invoice_amount).to eq 'R$ 4500,00'
  end

  it 'Converte 1 json em 1 objeto e salva em txt' do
    invoice = Fatura.to_convert('invoices-iugu/fatura001.json')
    
    expect(File.read("data/#{Time.now.strftime("%Y%m%d%H%M%S")}_Boleto_emissao.txt")).to include('b7d933ca217964802cce9abc9a75da96372fbfef')
    expect(File.read("data/#{Time.now.strftime("%Y%m%d%H%M%S")}_Boleto_emissao.txt")).to include('Pendente')
    expect(File.read("data/#{Time.now.strftime("%Y%m%d%H%M%S")}_Boleto_emissao.txt")).to include('25/04/2020')
    expect(File.read("data/#{Time.now.strftime("%Y%m%d%H%M%S")}_Boleto_emissao.txt")).to include('Boleto')
  end

  it 'Converte 1 json em 1 objeto e salva em txt' do
    invoice = Fatura.to_convert('invoices-iugu/fatura003.json')
    
    expect(File.read("data/#{Time.now.strftime("%Y%m%d%H%M%S")}_Pix_emissao.txt")).to include('a7baa680f588afa01406d236f93a602008baa3f7')
    expect(File.read("data/#{Time.now.strftime("%Y%m%d%H%M%S")}_Pix_emissao.txt")).to include('Pendente')
    expect(File.read("data/#{Time.now.strftime("%Y%m%d%H%M%S")}_Pix_emissao.txt")).to include('25/04/2020')
    expect(File.read("data/#{Time.now.strftime("%Y%m%d%H%M%S")}_Pix_emissao.txt")).to include('Pix')
  end
end