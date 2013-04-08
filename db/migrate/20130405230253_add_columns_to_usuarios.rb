class AddColumnsToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :facebook_uid, :string
  end
end
