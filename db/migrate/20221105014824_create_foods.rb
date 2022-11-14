class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :user_id
      t.timestamps
    end
    add_column :foods, :address, :string
    add_column :foods, :latitude, :float
    add_column :foods, :longitude, :float
  end
end
