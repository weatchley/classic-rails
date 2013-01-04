class CreateCybercontrols < ActiveRecord::Migration
  def self.up
    create_table :cybercontrols do |t|
      t.Bignum :originalID
      t.string :Revision
      t.bignum :controlNumber
      t.bignum :parentControlKey
      t.string :controlFamilyCode
      t.string :controlName
      t.string :controlType
      t.bignum :enhancement
      t.text :controlDescription
      t.string :impactLevel
      t.string :criticalControl

      t.timestamps
    end
  end

  def self.down
    drop_table :cybercontrols
  end
end
