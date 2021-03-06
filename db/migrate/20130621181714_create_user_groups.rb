class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.belongs_to :container, polymorphic: true
      t.string :name, null: false, default: ''

      t.timestamps
    end

    add_index :user_groups, [:container_type, :container_id]
  end
end
