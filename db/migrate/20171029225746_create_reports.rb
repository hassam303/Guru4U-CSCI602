class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :mentee_id
      t.integer :mentor_id
      t.string  :title
      t.text    :message
      t.boolean :urgent, default: false
      t.timestamps
    end
    add_index :reports, [:mentee_id,:mentor_id]
  end
end
