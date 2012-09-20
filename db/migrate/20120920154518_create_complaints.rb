class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.text :comment

      t.timestamps
    end
  end
end
