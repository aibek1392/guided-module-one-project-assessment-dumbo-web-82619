class Contract < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string :time
      t.integer :customer_id
      t.integer :moving_company_id
      t.integer :price
    end 
  end
end