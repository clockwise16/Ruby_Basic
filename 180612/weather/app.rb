require 'sinatra'
require 'eu_central_bank'

get '/' do
    erb :index
end

get '/ex' do
   erb :exchange 
end

get '/convert' do
    @from = params[:from]
    @to = params[:to]
    @amount = params[:amount].to_f #소수점까지 저장
    bank = EuCentralBank.new
    bank.update_rates
    @result = bank.exchange(@amount, @from, @to).to_f
   erb :convert 
end

get '/stock' do
    erb :stock 
end

get '/weather' do
    erb :weather 
end