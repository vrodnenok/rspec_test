class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :sex
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :email
      t.boolean :is_broker
      t.boolean :is_charterer
      t.boolean :is_owner
      t.string :region
      t.integer :size
      t.text :comment

      t.timestamps null: false
    end
  end
end
