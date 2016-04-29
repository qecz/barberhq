#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true , length: { minimum: 3} 
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base

end


get '/' do
	@barbers = Barber.order "created_at DESC"
	erb :index			
end

get '/visit' do
	@barbers = Barber.order "created_at DESC"
	@c = Client.new
	erb :visit
end

post '/visit' do

	@c = Client.new params[:client]
	if	@c.save
		erb "SPASIBO!"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end
	#redirect to "/"

end

get '/barber/:id' do
  
  @b = Barber.find(params[:id])

  erb :barber

end

get '/bookings' do

	@clients = Client.all
	erb :bookings
end
