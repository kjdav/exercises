class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.belongs_to :attachable, polymorphic:true, null: false
      t.integer :number, null: false
      t.string :asset, null: false, default: ''
      t.string :local_name, null: false, default: ''
      t.text :caption, null: false, default: ''
      t.text :alt, null: false, default: ''

      t.timestamps
    end

    add_index :attachments, [:attachable_type, :attachable_id, :local_name], unique: true, name: "index_a_on_a_type_and_a_id_and_l_name"
    add_index :attachments, [:attachable_type, :attachable_id, :number], unique: true, name: "index_a_on_a_type_and_a_id_and_number"
    add_index :attachments, [:attachable_type, :number]
  end
end
