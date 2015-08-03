class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.name :last
      t.string :business_email
      t.string :personal_email
      t.string :cell_phone
      t.string :business_phone
      t.string :address
      t.string :department
      t.string :office

      t.timestamps null: false
    end
  end
end
