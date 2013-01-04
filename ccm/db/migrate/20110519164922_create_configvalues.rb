class CreateConfigvalues < ActiveRecord::Migration
  def self.up
    create_table :configvalues do |t|
      t.string :name
      t.string :value
      t.bignum :ivalue
      t.date :dvalue
      t.timestamp :created_at
      t.timestamp :updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :configvalues
  end
end
