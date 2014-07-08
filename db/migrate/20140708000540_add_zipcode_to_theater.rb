class AddZipcodeToTheater < ActiveRecord::Migration
  def change
    add_column :theaters, :zipcode, :integer
  end
end
