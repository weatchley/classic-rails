class CreateEnclaves < ActiveRecord::Migration
  def self.up
    create_table :enclaves do |t|
      t.string :Name
      t.string :long_name
      t.Bignum :sort_order
      t.timestamp :created_at
      t.timestamp :updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :enclaves
  end
end
