class CreateEnclavequarters < ActiveRecord::Migration
  def self.up
    create_table :enclavequarters do |t|
      t.bignum :enclave_id
      t.bignum :enclaveQuarter
      t.bignum :enclaveYear
      t.timestamp :created_at
      t.timestamp :updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :enclavequarters
  end
end
