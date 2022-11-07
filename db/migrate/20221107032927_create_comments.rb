class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      
      t.integer :users_id
      t.integer :foods_id
      t.text :comment, null: false

      t.timestamps
    end
  end
end
