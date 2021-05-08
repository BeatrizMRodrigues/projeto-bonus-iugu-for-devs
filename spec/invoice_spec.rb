# frozen_string_literal: true

require 'spec_helper'
require 'invoice'

describe Invoice do
  it 'Cria um objeto do tipo fatura' do
    invoice = Invoice.new(token: '7c5ae058526ec4964050649e2b526460b1313afe',
                          status: 'Pendente',
                          due_date: '25/04/2020',
                          payment_method: 'Boleto',
                          amount: 'R$ 4500,00')

    expect(invoice.class).to eq Invoice
    expect(invoice.token).to eq '7c5ae058526ec4964050649e2b526460b1313afe'
    expect(invoice.status).to eq 'Pendente'
    expect(invoice.due_date).to eq '25/04/2020'
    expect(invoice.payment_method).to eq 'Boleto'
    expect(invoice.amount).to eq 'R$ 4500,00'
  end

  it 'Converte 1 json em 1 objeto e salva em txt' do
    Invoice.order('invoices-iugu/fatura001.json')
    data_path = "data/#{Time.now.strftime('%Y%m%d%H%M%S')}_Boleto_emissao.txt"
    expect(File.read(data_path)).to include('b7d933ca217964802cce9abc9a75da96372fbfef')
    expect(File.read(data_path)).to include('01')
    expect(File.read(data_path)).to include('20200425')
  end

  it 'Converte json em mais objetos e salva em txt' do
    Invoice.order('invoices-iugu/fatura004.json')
    data_path = "data/#{Time.now.strftime('%Y%m%d%H%M%S')}_Boleto_emissao.txt"
    expect(File.read(data_path)).to include('b7d933ca217964802cce9abc9a75da96372fbfef')
    expect(File.read(data_path)).to include('01')
    expect(File.read(data_path)).to include('20200425')
    expect(File.read(data_path)).to include('b415933ca217964802cce9abc9a75da96372fbfe')
  end

  it 'Converte json em arquivo de emissão' do
    Invoice.order('invoices-iugu/fatura004.json')
    data_path = "data/#{Time.now.strftime('%Y%m%d%H%M%S')}_Boleto_emissao.txt"

    expect(File.read(data_path)).to include('b7d933ca217964802cce9abc9a75da96372fbfef')
    expect(File.read(data_path)).to include('01')
    expect(File.read(data_path)).to include('20200425')
    expect(File.read(data_path)).to include('b415933ca217964802cce9abc9a75da96372fbfe')
    expect(File.read(data_path)).to include('F 000000000035000')
    expect(File.read(data_path)).to include('H 00003')
  end
end
