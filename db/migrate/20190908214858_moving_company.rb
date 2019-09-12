class MovingCompany < ActiveRecord::Migration[5.2]
  def change
    create_table :moving_companies do |t|
      t.string :name
      t.string :location
      t.integer :quantity
    end 
  end
end