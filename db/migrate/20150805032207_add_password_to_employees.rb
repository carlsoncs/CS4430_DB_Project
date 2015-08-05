class AddPasswordToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :password_digest, :string
    add_column :employees, :salt, :string
  end
end
