#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base

end

class Barber < ActiveRecord::Base

end


get '/' do
	@barbers = Barber.order "created_at DESC"
	erb :index			
end

get '/visit' do
	@barbers = Barber.order "created_at DESC"
	erb :visit
end

post '/visit' do

	c = Client.new params[:client]
	c.save

erb "SPASIBO!"

	#redirect to "/"

end
