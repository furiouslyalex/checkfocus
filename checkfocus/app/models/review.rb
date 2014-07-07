class Review < ActiveRecord::Base
	belongs_to :user
	has_one :theater
end
