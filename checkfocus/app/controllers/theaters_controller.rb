require 'rest-client'
require 'json'

class TheatersController < ApplicationController

	skip_before_action :authenticate_user!, only: :index

	def index
	end

	def create
		@zip = params[:zip]
		get_theaters(@zip)
		render "list"
	end

	def list
	end

	def show
	end

	def get_theaters(zip)		

		@theaters_array = []
		key = ENV["GOOGLE_PLACES_API_KEY"]
		places = JSON.load(RestClient.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=movie+theaters+in+#{@zip}&radius=5000&sensor=true&key=#{key}"))

		places['results'].map do |t|
			
			@theaters_array.push(:place_id =>t['place_id'], :name=> t['name'])
		end
	end

end	