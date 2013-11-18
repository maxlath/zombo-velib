require 'rubygems'
require 'bundler/setup'

require "sinatra"
require "sinatra/json"
require "sinatra/reloader"
require "sinatra/contrib"
require "rest_client"
require 'sinatra/base'



get '/' do
	@stations= [
		'12126',
		'43004',
		'31008',
	]
	@threshold= 4
	erb :place
end

helpers do
	def call_api(id)
		@params= {:apikey => '&apiKey=4f0d206f7e65b092e1be6f0908e3259eaa50a195', :contract_name => '?contract=Paris'}
		@requests= {:req_station => "https://api.jcdecaux.com/vls/v1/stations/"}
		RestClient.get @requests[:req_station] + id.to_s + @params[:contract_name] + @params[:apikey]
	end
end