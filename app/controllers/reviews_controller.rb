class ReviewsController < ApplicationController

	before_action :authenticate_user!

	def show
	end

	def new
		#@review = Review.new(:theater_id => params[:theater_id])
		#@theater_id = params[:theater_id]	
		theater = Theater.find(params[:theater_id])
    	#2nd you build a new one
    	@review = theater.reviews.build
	end

	def create
	  #@theater = Theater.find params[:theater_id]
	  #@user_id = current_user
	  #@review = Review.create(review_params.merge(:user_id => @user_id, :theater_id => @theater_id))
	  #@review.theater = @theater
	  
	  theater = Theater.find(params[:theater_id])
    	#2nd you create the comment with arguments in params[:comment]
      @review = theater.reviews.create(review_params)

	  if @review.save
	    redirect_to @review
	  else 
	    render 'edit'
	  end
   end

	def edit
	end


	private
 
    def load_resource
      @review = Review.find(params[:id])
    end   
 
    def review_params
      params.require(:review).permit(:rating, :review_text).merge(theater_id: params[:theater_id])
    end

end