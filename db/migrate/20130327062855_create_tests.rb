class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :data

      t.timestamps
    end
  end
end
