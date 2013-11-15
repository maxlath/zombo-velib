require "sinatra"
require "sinatra/json"
require "sinatra/reloader"
require "sinatra/contrib"
require "rest_client"

class Station < Sinatra::Base

	@@params= {:apikey => '&apiKey=4f0d206f7e65b092e1be6f0908e3259eaa50a195', :contract_name => '?contract=Paris'}

	@@requests= {:req_station => "https://api.jcdecaux.com/vls/v1/stations/"}

	def initialize id
		result= call_api(id)
		@name= result["name"]
		@place_dispo = result["available_bike_stands"]
		@velo_dispo = result["available_bikes"]
	end

	def call_api id
		json= RestClient.get @@requests[:req_station].to_s + id.to_s + @@params[:contract_name].to_s + @@params[:apikey].to_s
		result= JSON.parse(json)
	end
end

vincennes= Station.new('43004')
montreuil= Station.new('31008')
charenton= Station.new('12126')

get '/?' do
	@vincennes= vincennes
	@montreuil= Station.new('31008')
	@charenton= Station.new('12126')
	erb :stations
end



# def newrequest_for_stations stations
# 	stations.each do |station|
# 		puts station.value
# 	end
# 	# request = :jcdrequest + 
# 	# json = RestClient.get
# end


# __END__


# @@index

# <!DOCTYPE html>
# <html>
# <head>
# 	<title>Zombo Velib</title>
# </head>
# <body>
# 	<h1>Zombo Velib</h1>
# 	<%= "Hello World" %>
# 	<!-- <%= vincennes.@name.to_s %> -->
# </body>
# </html>