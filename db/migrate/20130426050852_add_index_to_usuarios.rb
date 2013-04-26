class AddIndexToUsuarios < ActiveRecord::Migration
  def change
    add_index :usuarios, :facebook_uid, :unique => true
  end
end
