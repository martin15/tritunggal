class AddPhoneAndCompanyToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :phone, :string
    add_column :contacts, :company_name, :string
  end
end
