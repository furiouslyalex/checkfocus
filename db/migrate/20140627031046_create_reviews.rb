class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :theater_id
      t.integer :user_id
      t.integer :rating
      t.string :review_text

      t.timestamps
    end
  end
end
