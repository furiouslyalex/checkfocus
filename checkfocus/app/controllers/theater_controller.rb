require 'rest-client'
require 'json'

class TheaterController < ApplicationController

	skip_before_action :authenticate_user!, only: :index

	def index
	end

	def new
		@zip = params[:zip]

		@list = []
		places = JSON.load(RestClient.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=movie+theaters+in+#{@zip}&radius=5000&sensor=true&key="ENV["GOOGLE_PLACES_API_KEY"]))

		places['results'].map do |t|
			attributes = {name: t['name']}
	
			@list.push(attributes[:name])
		end
	end

	def list
	end

end	