class Enclave < ActiveRecord::Base
  has_many :enclavequarters
  has_many :enclavecontrols

  # internal attribute for finding if the enclave is in use
  def inUse

    # initial value
    result = false
    # make connection to db
    sql = ActiveRecord::Base.connection();
    
    # test if in use
    #count, dummy = sql.execute("SELECT COUNT(*), 0 FROM enclavequarters WHERE enclave_id=#{self.id}").fetch_row
    count = sql.select_value("SELECT COUNT(*) FROM enclavequarters WHERE enclave_id=#{self.id}")
    result = (count.to_i > 0) ? true : false
    
    result

  end

end
