class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :business_email, null: false, :unique => true
      t.string :personal_email, :default => 'N/A'
      t.string :cell_phone, :default => 'N/A'
      t.string :business_phone, :null => false
      t.string :extension, :default => 'N/A'
      t.string :home_phone, default: 'N/A'
      t.string :department, default: 'N/A'
      t.string :office_number, default: 'N/A'
      t.string :location, default: 'N/A'
      t.string :notes

      t.integer :manager_id
      t.boolean :admin, :default => false

      t.string :password_digest
      t.string :salt

      t.timestamps null: false
    end
    add_index :employees, :first_name
    add_index :employees, :last_name
    add_index :employees, :department
    add_index :employees, :business_email
  end
end
