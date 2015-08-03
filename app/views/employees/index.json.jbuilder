json.array!(@employees) do |employee|
  json.extract! employee, :id, :first_name, :last, :business_email, :personal_email, :cell_phone, :business_phone, :address, :department, :office
  json.url employee_url(employee, format: :json)
end
