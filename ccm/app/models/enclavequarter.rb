class Enclavequarter < ActiveRecord::Base
  belongs_to :enclave
  has_many :enclavecontrols
  
  # determine if there is any matching data in eclave controls
  def hasData
    sql = ActiveRecord::Base.connection();
    #dataCount, dummy = sql.execute("SELECT count(*), 0 FROM enclavecontrols WHERE enclavequarter_id = #{self.id}").fetch_row
    dataCount = sql.select_value("SELECT count(*) FROM enclavecontrols WHERE enclavequarter_id = #{self.id}")
    if dataCount.to_i > 0 then
      hasData = true
    else
      hasData = false
    end
    #hasData = dataCount
    hasData
  end

  # internal attribute for current year
  def currentYear
    value = nil
    sql = ActiveRecord::Base.connection();
    #value, dummy = sql.execute("SELECT MAX(enclaveYear), 0 FROM enclavequarters").fetch_row
    value = sql.select_value("SELECT MAX(enclaveYear) FROM enclavequarters")
    value
  end

  # internal attribute for current quarter
  def currentQuarter
    value = nil
    sql = ActiveRecord::Base.connection();
    #value, dummy = sql.execute("SELECT MAX(enclaveQuarter), 0 FROM enclavequarters WHERE enclaveYear = #{self.currentYear}").fetch_row
    value = sql.select_value("SELECT MAX(enclaveQuarter) FROM enclavequarters WHERE enclaveYear = #{self.currentYear}")
    value
  end
  
  # internal attribute for the name of the quarter
  def quarterName
    qtrName = ""
    case self.enclaveQuarter
      when 1
        qtrName = "First"
      when 2
        qtrName = "Second"
      when 3
        qtrName = "Third"
      when 4
        qtrName = "Fourth"
      end
    qtrName
  end
  
  # insert data into enclavecontrols for a new quarter/year
  def populate(year, quarter)

    # make connection to db
    sql = ActiveRecord::Base.connection();

    # Process DB specific code
    sysdateFunction = "SYSDATE()"
    if ActiveRecord::Base::connection.is_a?(ActiveRecord::ConnectionAdapters::SQLServerAdapter)
      sysdateFunction = "GETDATE()"
    end
    
    # test if year/quarter already exists
    #count, dummy = sql.execute("SELECT COUNT(*), 0 FROM enclavequarters WHERE enclaveYear=#{year} AND enclaveQuarter=#{quarter}").fetch_row
    count = sql.select_value("SELECT COUNT(*) FROM enclavequarters WHERE enclaveYear=#{year} AND enclaveQuarter=#{quarter}")
    count = ((count != nil) ? count : 0)
    
    status = "Failed"
    if (count.to_i == 0) then

      # make sure that all enclavecontrol records have the quarter set
      #count = sql.execute("UPDATE enclavecontrols ec SET ec.enclavequarter=(SELECT enclaveQuarter FROM enclavequarters eq WHERE eq.id = ec.enclavequarter_id)")
      count = sql.execute("UPDATE enclavecontrols SET enclavequarter=(SELECT enclaveQuarter FROM enclavequarters eq WHERE eq.id = enclavequarter_id)")

      # get setup values
      #oldYear, dummy = sql.execute("SELECT MAX(enclaveYear), 0 FROM enclavequarters").fetch_row
      oldYear = sql.select_value("SELECT MAX(enclaveYear) FROM enclavequarters")
      #oldQuarter, dummy = sql.execute("SELECT MAX(enclaveQuarter), 0 FROM enclavequarters WHERE enclaveYear = #{oldYear}").fetch_row
      oldQuarter = sql.select_value("SELECT MAX(enclaveQuarter) FROM enclavequarters WHERE enclaveYear = #{oldYear}")
      #sysDate, dummy = sql.execute("SELECT SYSDATE()").fetch_row
      sysDate = sql.select_value("SELECT #{sysdateFunction}")
      conf = Configvalue.where(:name => :controlrevision).first
      controlRev = conf.ivalue

      # populate enclavecontrols for quarter/year with matching data from the previous quarter/year (only populate for active enclaves)
      enclvs = Enclave.where("active = 1")
      enclvs.each do |enc|
        
        #count = sql.execute("INSERT INTO enclavequarters (enclave_id, enclaveQuarter, enclaveYear, created_at, updated_at) VALUES (#{enc.id}, #{quarter}, #{year}, '#{sysDate}', '#{sysDate}')")
        #count = sql.execute("INSERT INTO enclavequarters (enclave_id, enclaveQuarter, enclaveYear, created_at, updated_at) VALUES (#{enc.id}, #{quarter}, #{year}, #{sysdateFunction}, #{sysdateFunction})")
        count = sql.execute("INSERT INTO enclavequarters (enclave_id, enclaveQuarter, enclaveYear) VALUES (#{enc.id}, #{quarter}, #{year})")
        count = sql.execute("UPDATE enclavequarters SET created_at=#{sysdateFunction} WHERE created_at IS NULL")
        count = sql.execute("UPDATE enclavequarters SET updated_at=#{sysdateFunction} WHERE updated_at IS NULL")
        #eqid, dummy = sql.execute("SELECT id FROM enclavequarters WHERE enclaveQuarter = #{quarter} AND enclaveYear = #{year} AND enclave_id = #{enc.id}").fetch_row
        eqid = sql.select_value("SELECT id FROM enclavequarters WHERE enclaveQuarter = #{quarter} AND enclaveYear = #{year} AND enclave_id = #{enc.id}")
        sqlstring = "INSERT INTO enclavecontrols (enclave_id, enclaveYear, cybercontrol_id, enclavequarter_id, enclaveQuarter, RMF, SSPImplementationStatus, SSPImplementationDescription, "
        sqlstring += "implementingDocumentationOrArticfacts, deviationIdentifier, testMethod, testProcedure, plannedTestDate, scheduledTestYear, actualTestDate, testResult, testResultDescription, "
        sqlstring += "assessorName, cAndADoc, controlReference, created_at, updated_at) SELECT #{enc.id}, #{year}, cybercontrol_id, #{eqid}, #{quarter}, RMF, SSPImplementationStatus, SSPImplementationDescription, "
        sqlstring += "implementingDocumentationOrArticfacts, deviationIdentifier, testMethod, testProcedure, plannedTestDate, scheduledTestYear, actualTestDate, testResult, testResultDescription, "
        #sqlstring += "assessorName, cAndADoc, controlReference, '#{sysDate}', '#{sysDate}' FROM enclavecontrols WHERE enclave_id = #{enc.id} AND enclaveYear = #{oldYear} AND enclaveQuarter = #{oldQuarter} "
        sqlstring += "assessorName, cAndADoc, controlReference, #{sysdateFunction}, #{sysdateFunction} FROM enclavecontrols WHERE enclave_id = #{enc.id} AND enclaveYear = #{oldYear} AND enclaveQuarter = #{oldQuarter} "
        count = sql.execute(sqlstring)
      end
    
      # Populate enclavecontrols for any new enclaves with matching data from the first enclave for the quarter/year
      enclvs = Enclave.where("active = 1 AND id NOT IN (SELECT enclave_id FROM enclavecontrols WHERE enclaveYear = #{oldYear} AND enclaveQuarter = #{oldQuarter})")
      enclvs.each do |enc|
        # get the id of the first enclave with the new quarter/year
        #myid, dummy = sql.execute("SELECT MIN(enclave_id), 0 FROM enclavecontrols WHERE enclaveYear = #{year} AND enclaveQuarter = #{quarter}").fetch_row
        myid = sql.select_value("SELECT MIN(enclave_id) FROM enclavecontrols WHERE enclaveYear = #{year} AND enclaveQuarter = #{quarter}")
        # insert records for new enclave
        sqlstring = "INSERT INTO enclavecontrols (enclave_id, enclaveYear, cybercontrol_id, enclavequarter_id, enclaveQuarter, RMF, SSPImplementationStatus, SSPImplementationDescription, "
        sqlstring += "implementingDocumentationOrArticfacts, deviationIdentifier, testMethod, testProcedure, plannedTestDate, scheduledTestYear, actualTestDate, testResult, testResultDescription, "
        sqlstring += "assessorName, cAndADoc, controlReference, created_at, updated_at) SELECT #{enc.id}, #{year}, cybercontrol_id, enclavequarter_id, #{quarter}, RMF, SSPImplementationStatus, SSPImplementationDescription, "
        sqlstring += "implementingDocumentationOrArticfacts, deviationIdentifier, testMethod, testProcedure, plannedTestDate, scheduledTestYear, actualTestDate, testResult, testResultDescription, "
        #sqlstring += "assessorName, cAndADoc, controlReference, '#{sysDate}', '#{sysDate}' FROM enclavecontrols WHERE enclave_id = #{myid} AND enclaveYear = #{year} AND enclaveQuarter = #{quarter} "
        sqlstring += "assessorName, cAndADoc, controlReference, #{sysdateFunction}, #{sysdateFunction} FROM enclavecontrols WHERE enclave_id = #{myid} AND enclaveYear = #{year} AND enclaveQuarter = #{quarter} "
        count = sql.execute(sqlstring)
      end
      status = "Finished - Adding Quarter/Year (#{quarter}/#{year})."
    else
      status = "Failed - Quarter/Year (#{quarter}/#{year}) already exists!"
    end
    
    status
    
  end
  
end
