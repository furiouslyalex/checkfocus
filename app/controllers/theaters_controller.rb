require 'rest-client'
require 'json'

class TheatersController < ApplicationController

	skip_before_action :authenticate_user!, only: :index
	#before_filter :load_review

	def index
	end

	def new
	end

	def create
		@zip = params[:zip]
		get_theaters(@zip)
		@theaters = Theater.where("zipcode = ?", @zip)
		render "list"
	end

	def list

	end

	def show
		@theater = Theater.find(params[:id])
		@reviews = Review.where(:theater_id => params[:id])
		@user = User.find(1)
	end

	def load_resource
      	@theater = Theater.find(params[:id])
    end   

	def get_theaters(zip)		

		@theaters_array = []
		key = ENV["GOOGLE_PLACES_API_KEY"]
		places = JSON.load(RestClient.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=movie+theaters+in+#{@zip}&radius=5000&sensor=true&key=#{key}"))
		
		#@token = places['next_page_token']
		#places2 =  JSON.load(RestClient.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=#{@token}&radius=5000&sensor=true&key=#{key}"))
		
		places['results'].map do |t1|
			#@theaters_array.push(:place_id =>t1['place_id'], :name=> t1['name'])
			tr = Theater.new
			tr.name = t1['name']
			tr.google_id = t1['place_id']
			tr.zipcode = @zip
			tr.save
		end

		#places2['results'].map do |t2|
		#	@theaters_array.push(:place_id =>t2['place_id'], :name=> t2['name'])
		#end
	end

end	