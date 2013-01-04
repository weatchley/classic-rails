#
# A model to contain all the info necessary to render a metrics partial.
# This model is dynamically generated with no table in the database
#
class Metric
  # define data elements/atributes
  attr_reader :id, :cagtested, :cagopen, :cagpartial, :cagdue, :caglate, :cagnotscheduled, :cagauto, :cagtotal,  :cagcyclemonth, :cagcycleduration,
  :mabtested, :mabopen, :mabpartial, :mabdue, :mablate, :mabnotscheduled, :mabauto, :mabtotal, :mabcyclemonth, :mabcycleduration,
  :atoDate, :atoYear

  # dynamicly generate data when requested
  def initialize

    # request configuration information
    conf = Configvalue.where(:name => :atodate).first
    @atoDate = conf.dvalue
    @atoYear = 0
    conf = Configvalue.where(:name => :controlrevision).first
    @controlRev = conf.ivalue
  
    # set initial values
    @id = 1 # 1 is used just for convenience
    @cagtested = 1 # 1 is used just for test
    @cagopen = 1 # 1 is used just for test
    @cagpartial = 1 # 1 is used just for test
    @cagdue = 1 # 1 is used just for test
    @caglate = 1 # 1 is used just for test
    @cagnotscheduled = 1 # 1 is used just for test
    @cagauto = 1 # 1 is used just for test
    @cagtotal = 1 # 1 is used just for test
    @cagcyclemonth = 1 # 1 is used just for test
    @cagcycleduration = 12 #
    @mabtested = 1 # 1 is used just for test
    @mabopen = 1 # 1 is used just for test
    @mabpartial = 1 # 1 is used just for test
    @mabdue = 1 # 1 is used just for test
    @mablate = 1 # 1 is used just for test
    @mabnotscheduled = 1 # 1 is used just for test
    @mabauto = 1 # 1 is used just for test
    @mabtotal = 1 # 1 is used just for test
    @mabcyclemonth = 1 # 1 is used just for test
    @mabcycleduration = 48 #
    
    # get sql connection
    sql = ActiveRecord::Base.connection();
    
    # Process DB specific code
    if ActiveRecord::Base::connection.is_a?(ActiveRecord::ConnectionAdapters::SQLServerAdapter)
    
      # get setup values
      tempDate = sql.select_value("SELECT DATEDIFF(day, '#{@atoDate.year}-#{@atoDate.month}-#{@atoDate.day}', GETDATE())")
      tempYear = tempDate.to_i / 365
      @atoYear = tempYear.to_i + 1
      @mabcyclemonth = (tempDate.to_i / 30.415).to_i
      @cagcyclemonth = (@mabcyclemonth.to_i % 12) + 1
      enclaveYear = sql.select_value("SELECT MAX(enclaveYear) FROM enclavequarters")
      enclaveQuarter = sql.select_value("SELECT MAX(enclaveQuarter) FROM enclavequarters WHERE enclaveYear=#{enclaveYear}")
      eqList = "0"
      eqSet = Enclavequarter.where("enclaveYear=#{enclaveYear} AND enclaveQuarter=#{enclaveQuarter}")
      enclaveCount= eqSet.length
      eqSet.each do |eq|
        eqList += ", #{eq.id}"
      end
      #Rails.logger.error "\n" + "metric.initialize - Got Here 1 - tempDate: #{tempDate}, tempYear: #{tempYear}, atoYear: #{@atoYear}, mabcyclemonth: #{@mabcyclemonth}, cagcyclemonth: #{@cagcyclemonth}, enclaveYear: #{enclaveYear}, enclaveQuarter: #{enclaveQuarter}, enclaveCount: #{enclaveCount}, eqList: #{eqList}\n"
     
      # create base sql statements for lookup
      cagSQLFragment = " FROM enclavecontrols ec, cybercontrols cc WHERE ec.cybercontrol_id=cc.id AND cc.criticalControl=1 AND ec.enclavequarter_id IN (#{eqList}) AND ec.RMF=0 AND cc.Revision=#{@controlRev} "
      cagSQLFragment += "AND ec.created_at > DATEADD(year, #{(@atoYear - 1)}, '#{@atoDate.year}-#{@atoDate.month}-#{@atoDate.day}') "
      mabSQLFragment = " FROM enclavecontrols ec, cybercontrols cc WHERE ec.cybercontrol_id=cc.id AND cc.criticalControl=0 AND ec.enclavequarter_id IN (#{eqList}) AND ec.RMF=0 AND cc.Revision=#{@controlRev} "
      if @atoYear == 4 then
        mabSQLFragment += "AND ec.created_at > DATEADD(year, #{(@atoYear - 1)}, '#{@atoDate.year}-#{@atoDate.month}-#{@atoDate.day}') "
      end
      
      # get list of controls that have a scheduled date
      cagccwithsheduledlist = "0"
      cagccwithsheduled = sql.select_values("SELECT cc.id " + cagSQLFragment + " AND ec.plannedTestDate IS NOT NULL")
      cagccwithsheduled.each do |id|
        cagccwithsheduledlist += ", #{id}"
      end
      mabccwithsheduledlist = "0"
      mabccwithsheduled = sql.select_values("SELECT cc.id " + mabSQLFragment + " AND ec.plannedTestDate IS NOT NULL")
      mabccwithsheduled.each do |id|
        mabccwithsheduledlist += ", #{id}"
      end

      
      # finalize sql statements and get initial metrics
      @cagtested = sql.select_value("SELECT count(*) " + cagSQLFragment + " AND ec.actualTestDate IS NOT NULL")
      @mabtested = sql.select_value("SELECT count(*) " + mabSQLFragment + " AND ec.actualTestDate IS NOT NULL")
      @cagopen = sql.select_value("SELECT count(*) " + cagSQLFragment + " AND ec.SSPImplementationStatus != 'Implemented' AND ec.SSPImplementationStatus != 'Not Applicable'")
      @mabopen = sql.select_value("SELECT count(*) " + mabSQLFragment + " AND ec.SSPImplementationStatus != 'Implemented' AND ec.SSPImplementationStatus != 'Not Applicable'")
      @cagpartial = sql.select_value("SELECT count(*) " + cagSQLFragment + " AND ec.SSPImplementationStatus = 'Partially Implemented'")
      @mabpartial = sql.select_value("SELECT count(*) " + mabSQLFragment + " AND ec.SSPImplementationStatus = 'Partially Implemented'")
      @cagdue = sql.select_value("SELECT count(*) " + cagSQLFragment + " AND ec.actualTestDate IS NULL AND ec.plannedTestDate < DATEADD(day, 30, GETDATE()) AND ec.plannedTestDate >= GETDATE()")
      @mabdue = sql.select_value("SELECT count(*) " + mabSQLFragment + " AND ec.actualTestDate IS NULL AND ec.plannedTestDate < DATEADD(day, 60, GETDATE()) AND ec.plannedTestDate >= GETDATE()")
      @caglate = sql.select_value("SELECT count(*) " + cagSQLFragment + " AND ec.actualTestDate IS NULL AND ec.plannedTestDate < GETDATE()")
      @mablate = sql.select_value("SELECT count(*) " + mabSQLFragment + " AND ec.actualTestDate IS NULL AND ec.plannedTestDate < GETDATE()")
      #@cagnotscheduled = sql.select_value("SELECT count(*) " + cagSQLFragment + " AND ec.plannedTestDate IS NULL")
      #@mabnotscheduled = sql.select_value("SELECT count(*) " + mabSQLFragment + " AND ec.plannedTestDate IS NULL")
      #@cagscheduled = sql.select_value("SELECT count(*) " + cagSQLFragment + " AND ec.plannedTestDate IS NOT NULL")
      #@mabscheduled = sql.select_value("SELECT count(*) " + mabSQLFragment + " AND ec.plannedTestDate IS NOT NULL")
      @cagscheduled = sql.select_value("SELECT count(*) FROM cybercontrols WHERE id in (#{cagccwithsheduledlist})")
      @mabscheduled = sql.select_value("SELECT count(*) FROM cybercontrols WHERE id in (#{mabccwithsheduledlist})")
      @cagauto = sql.select_value("SELECT count(*) " + cagSQLFragment + " AND ec.testMethod = 'Automatic'")
      @mabauto = sql.select_value("SELECT count(*) " + mabSQLFragment + " AND ec.testMethod = 'Automatic'")
      @cagtotal = sql.select_value("SELECT count(*) " + cagSQLFragment)
      @mabtotal = sql.select_value("SELECT count(*) " + mabSQLFragment)
      
    else

      # get setup values
      tempDate, dummy = sql.execute("SELECT DATEDIFF(SYSDATE(), '#{@atoDate.year}-#{@atoDate.month}-#{@atoDate.day}'), 0").fetch_row
      tempYear = tempDate.to_i / 365
      @atoYear = tempYear.to_i + 1
      @mabcyclemonth = (tempDate.to_i / 30.415).to_i
      @cagcyclemonth = @mabcyclemonth.to_i % 12
      enclaveYear, dummy = sql.execute("SELECT MAX(enclaveYear) FROM enclavequarters").fetch_row
      enclaveQuarter, dummy = sql.execute("SELECT MAX(enclaveQuarter) FROM enclavequarters WHERE enclaveYear=#{enclaveYear}").fetch_row
      eqList = "0"
      eqSet = Enclavequarter.where("enclaveYear=#{enclaveYear} AND enclaveQuarter=#{enclaveQuarter}")
      enclaveCount= eqSet.length
      eqSet.each do |eq|
        eqList += ", #{eq.id}"
      end
     
      # create base sql statements for lookup
      cagSQLFragment = " FROM enclavecontrols ec, cybercontrols cc WHERE ec.cybercontrol_id=cc.id AND cc.criticalControl=1 AND ec.enclavequarter_id IN (#{eqList}) AND ec.RMF=0 AND cc.Revision=#{@controlRev} "
      cagSQLFragment += "AND ec.created_at > ADDDATE('#{@atoDate.year}-#{@atoDate.month}-#{@atoDate.day}', INTERVAL #{(@atoYear - 1)} YEAR) "
      mabSQLFragment = " FROM enclavecontrols ec, cybercontrols cc WHERE ec.cybercontrol_id=cc.id AND cc.criticalControl=0 AND ec.enclavequarter_id IN (#{eqList}) AND ec.RMF=0 AND cc.Revision=#{@controlRev} "
      if @atoYear == 4 then
        mabSQLFragment += "AND ec.created_at > ADDDATE('#{@atoDate.year}-#{@atoDate.month}-#{@atoDate.day}', INTERVAL #{(@atoYear - 1)} YEAR) "
      end
      
      # get list of controls that have a scheduled date
      cagccwithsheduledlist = "0"
      cagccwithsheduled = sql.select_values("SELECT cc.id " + cagSQLFragment + " AND ec.plannedTestDate IS NOT NULL")
      cagccwithsheduled.each do |id|
        cagccwithsheduledlist += ", #{id}"
      end
      mabccwithsheduledlist = "0"
      mabccwithsheduled = sql.select_values("SELECT cc.id " + mabSQLFragment + " AND ec.plannedTestDate IS NOT NULL")
      mabccwithsheduled.each do |id|
        mabccwithsheduledlist += ", #{id}"
      end

      
      # finalize sql statements and get initial metrics
      @cagtested, dummy = sql.execute("SELECT count(*), 0 " + cagSQLFragment + " AND ec.actualTestDate IS NOT NULL").fetch_row
      @mabtested, dummy = sql.execute("SELECT count(*), 0 " + mabSQLFragment + " AND ec.actualTestDate IS NOT NULL").fetch_row
      @cagopen, dummy = sql.execute("SELECT count(*), 0 " + cagSQLFragment + " AND ec.SSPImplementationStatus != 'Implemented' AND ec.SSPImplementationStatus != 'Not Applicable'").fetch_row
      @mabopen, dummy = sql.execute("SELECT count(*), 0 " + mabSQLFragment + " AND ec.SSPImplementationStatus != 'Implemented' AND ec.SSPImplementationStatus != 'Not Applicable'").fetch_row
      @cagpartial, dummy = sql.execute("SELECT count(*), 0 " + cagSQLFragment + " AND ec.SSPImplementationStatus = 'Partially Implemented'").fetch_row
      @mabpartial, dummy = sql.execute("SELECT count(*), 0 " + mabSQLFragment + " AND ec.SSPImplementationStatus = 'Partially Implemented'").fetch_row
      @cagdue, dummy = sql.execute("SELECT count(*), 0 " + cagSQLFragment + " AND ec.actualTestDate IS NULL AND ec.plannedTestDate < ADDDATE(SYSDATE(), 30) AND ec.plannedTestDate >= SYSDATE()").fetch_row
      @mabdue, dummy = sql.execute("SELECT count(*), 0 " + mabSQLFragment + " AND ec.actualTestDate IS NULL AND ec.plannedTestDate < ADDDATE(SYSDATE(), 60) AND ec.plannedTestDate >= SYSDATE()").fetch_row
      @caglate , dummy = sql.execute("SELECT count(*), 0 " + cagSQLFragment + " AND ec.actualTestDate IS NULL AND ec.plannedTestDate < SYSDATE()").fetch_row
      @mablate , dummy = sql.execute("SELECT count(*), 0 " + mabSQLFragment + " AND ec.actualTestDate IS NULL AND ec.plannedTestDate < SYSDATE()").fetch_row
      #@cagnotscheduled, dummy = sql.execute("SELECT count(*), 0 " + cagSQLFragment + " AND ec.plannedTestDate IS NULL").fetch_row
      #@mabnotscheduled, dummy = sql.execute("SELECT count(*), 0 " + mabSQLFragment + " AND ec.plannedTestDate IS NULL").fetch_row
      #@cagscheduled, dummy = sql.execute("SELECT count(*), 0 " + cagSQLFragment + " AND ec.plannedTestDate IS NOT NULL").fetch_row
      #@mabscheduled, dummy = sql.execute("SELECT count(*), 0 " + mabSQLFragment + " AND ec.plannedTestDate IS NOT NULL").fetch_row
      @cagscheduled = sql.select_value("SELECT count(*) FROM cybercontrols WHERE id in (#{cagccwithsheduledlist})")
      @mabscheduled = sql.select_value("SELECT count(*) FROM cybercontrols WHERE id in (#{mabccwithsheduledlist})")
      @cagauto, dummy = sql.execute("SELECT count(*), 0 " + cagSQLFragment + " AND ec.testMethod = 'Automatic'").fetch_row
      @mabauto, dummy = sql.execute("SELECT count(*), 0 " + mabSQLFragment + " AND ec.testMethod = 'Automatic'").fetch_row
      @cagtotal, dummy = sql.execute("SELECT count(*), 0 " + cagSQLFragment).fetch_row
      @mabtotal, dummy = sql.execute("SELECT count(*), 0 " + mabSQLFragment).fetch_row
    
    end
    
    # finalize metrics
    @cagtested = @cagtested.to_i / enclaveCount
    @mabtested = @mabtested.to_i / enclaveCount
    @cagauto = @cagauto.to_i / enclaveCount
    @mabauto = @mabauto.to_i / enclaveCount
    @cagtotal = @cagtotal.to_i / enclaveCount
    @mabtotal = @mabtotal.to_i / enclaveCount
    @cagopen = @cagopen.to_i / enclaveCount
    @mabopen = @mabopen.to_i / enclaveCount
    @cagpartial = @cagpartial.to_i / enclaveCount
    @mabpartial = @mabpartial.to_i / enclaveCount
    #@cagdue = @cagdue.to_i / enclaveCount
    @cagdue = @cagdue.to_i
    #@mabdue = @mabdue.to_i / enclaveCount
    @mabdue = @mabdue.to_i
    #@caglate = @caglate.to_i / enclaveCount
    @caglate = @caglate.to_i
    #@mablate = @mablate.to_i / enclaveCount
    @mablate = @mablate.to_i
    #@cagnotscheduled = @cagnotscheduled.to_i / enclaveCount
    #@mabnotscheduled = @mabnotscheduled.to_i / enclaveCount
    @cagnotscheduled = @cagtotal - @cagauto - @cagscheduled.to_i
    @mabnotscheduled = @mabtotal - @mabauto - @mabscheduled.to_i

  end
  
end

