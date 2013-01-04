class CreateEnclavecontrols < ActiveRecord::Migration
  def self.up
    create_table :enclavecontrols do |t|
      t.bignum :enclave_id
      t.bignum :enclaveYear
      t.bignum :cybercontrol_id
      t.string :RMF
      t.string :SSPImplementationStatus
      t.text :SSPImplementationDescription
      t.string :implementingDocumentationOrArticfacts
      t.string :deviationIdentifier
      t.string :testMethod
      t.string :testProcedure
      t.date :plannedTestDate
      t.string :scheduledTestYear
      t.date :actualTestDate
      t.string :testResult
      t.text :testResultDescription
      t.string :assessorName
      t.string :cAndADoc
      t.string :controlReference
      t.bignum :enclavequarter_id

      t.timestamps
    end
  end

  def self.down
    drop_table :enclavecontrols
  end
end
