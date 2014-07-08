class Theater < ActiveRecord::Base
	has_many :reviews

	#validates_uniqueness_of [:google_id,:zipcode], on: :create
end
