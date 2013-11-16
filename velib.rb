require 'rubygems'
require 'bundler/setup'

require "sinatra"
require "sinatra/json"
require "sinatra/reloader"
require "sinatra/contrib"
require "rest_client"
require 'sinatra/base'

helpers do
	def call_api(id)
		@params= {:apikey => '&apiKey=4f0d206f7e65b092e1be6f0908e3259eaa50a195', :contract_name => '?contract=Paris'}
		@requests= {:req_station => "https://api.jcdecaux.com/vls/v1/stations/"}
		RestClient.get @requests[:req_station] + id.to_s + @params[:contract_name] + @params[:apikey]
	end

	def duration
		ud    = self / 1000
		now   = Time.now.to_i
	    secs  = ud - now
	    mins  = secs / 60
	    hours = mins / 60
	    days  = hours / 24

	    if days > 0
	      "#{days} days and #{hours % 24} hours"
	    elsif hours > 0
	      "#{hours} hours and #{mins % 60} minutes"
	    elsif mins > 0
	      "#{mins} minutes and #{secs % 60} seconds"
	    elsif secs >= 0
	      "#{secs} seconds"
	    end
	  end

	def to_pretty
    a = Time.now.to_i-self.to_i

    case a
      when 0 then 'just now'
      when 1 then 'a second ago'
      when 2..59 then a.to_s+' seconds ago' 
      when 60..119 then 'a minute ago' #120 = 2 minutes
      when 120..3540 then (a/60).to_i.to_s+' minutes ago'
      when 3541..7100 then 'an hour ago' # 3600 = 1 hour
      when 7101..82800 then ((a+99)/3600).to_i.to_s+' hours ago' 
      when 82801..172000 then 'a day ago' # 86400 = 1 day
      when 172001..518400 then ((a+800)/(60*60*24)).to_i.to_s+' days ago'
      when 518400..1036800 then 'a week ago'
      else ((a+180000)/(60*60*24*7)).to_i.to_s+' weeks ago'
    end
  end
end


get '/' do
	@stations= [
		'12126',
		'43004',
		'31008',
	]
	@threshold= 4
	erb :place
end



