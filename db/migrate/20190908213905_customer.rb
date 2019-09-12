class Customer < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :size
      t.string :location
    end 
  end
end
      