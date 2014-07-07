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

	def show()
	end

	def get_theaters(zip)		

		@theaters_array = []
		key = ENV["GOOGLE_PLACES_API_KEY"]
		places = JSON.load(RestClient.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=movie+theaters+in+#{@zip}&radius=5000&sensor=true&key=#{key}"))
		
		#@token = places['next_page_token']
		#places2 =  JSON.load(RestClient.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=#{@token}&radius=5000&sensor=true&key=#{key}"))
		
		places['results'].map do |t1|
			@theaters_array.push(:place_id =>t1['place_id'], :name=> t1['name'])
		end

		#places2['results'].map do |t2|
		#	@theaters_array.push(:place_id =>t2['place_id'], :name=> t2['name'])
		#end
	end

end	