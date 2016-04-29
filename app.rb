#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, :presence => { :message => "Name cannot be blank" }
	validates :phone, :presence => { :message => "Phone cannot be blank" }
	validates :datestamp, :presence => { :message => "Date cannot be blank" }
	validates :color, :presence => { :message => "Color cannot be blank" }
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
