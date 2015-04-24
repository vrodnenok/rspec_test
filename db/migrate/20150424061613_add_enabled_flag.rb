class AddEnabledFlag < ActiveRecord::Migration
  def change
    add_column :contacts, :enabled, :boolean
  end
end
