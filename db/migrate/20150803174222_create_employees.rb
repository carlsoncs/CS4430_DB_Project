class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name, null: false, limit: 30
      t.string :last_name, null: false, limit: 30
      t.string :business_email, null: false, :unique => true, limit: 70
      t.string :personal_email, :default => 'N/A', limit: 70
      t.string :cell_phone, :default => 'N/A', limit: 14
      t.string :business_phone, :null => false, limit: 14
      t.string :phone_extension, :default => 'N/A', limit: 5
      t.string :home_phone, default: 'N/A'
      t.string :department, default: 'N/A'
      t.string :office_number, default: 'N/A'
      t.string :extension, default: 'N/A'
      t.string :location, default: 'N/A'
      t.string :notes

      t.timestamps null: false
    end
    add_index :employees, :first_name
    add_index :employees, :last_name
    add_index :employees, :department
  end
end