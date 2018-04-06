class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string  :name
      t.string  :cwid
      t.string  :email
      t.string  :phone
      t.string  :company
      t.string  :role
      t.string  :advisor
      t.string  :advisor_email
      t.integer :mentor_id

      t.timestamps
    end
    add_index :students, [:cwid,:email], unique: true
    add_index :students, :mentor_id
  end
end
