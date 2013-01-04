class Enclavecontrol < ActiveRecord::Base
  belongs_to :cybercontrol
  belongs_to :enclave
  belongs_to :enclavequarter

  # internal attribute for id of the implementation status
  def implementationStatusID
    temp = Implementationstatus.where("name = ?", self.SSPImplementationStatus)
    statusID = temp.first.id
    statusID
  end
  
  # internal attribute for id of the test method
  def testMethodID
    temp = Testmethod.where("name = ?", self.testMethod)
    methodID = temp.first.id
    methodID
  end
  
  # internal attribute for id of the test results
  def testResultID
    temp = Testresult.where("name = ?", self.testResult)
    resultID = temp.first.id
    resultID
  end
  
  # internal attribute for set of current enclavecontrols
  def currentSet
    eq = Enclavequarter.first
    year = eq.currentYear
    quarter = eq.currentQuarter
    temp = Enclavecontrol.where("enclaveYear = #{year} AND enclaveQuarter = #{quarter}")
    temp
  end
  
  # apply update to all enclaves with same quarter, year, and control
  def applyToAll(id)
    # debug info to log
    #Rails.logger.error "\n" + "enclavecontrol.applyToAll - Got Here 1 - id=#{id}\n"
    
    # get source record
    ec = Enclavecontrol.find(id)
    
    #
    ecSet = Enclavecontrol.where("cybercontrol_id=#{ec.cybercontrol_id} AND enclaveYear=#{ec.enclaveYear} AND enclaveQuarter=#{ec.enclaveQuarter} AND id<>#{id}")
    
    ecSet.each do |item|
      item.RMF = ec.RMF
      item.SSPImplementationStatus = ec.SSPImplementationStatus
      item.SSPImplementationDescription = ec.SSPImplementationDescription
      item.implementingDocumentationOrArticfacts = ec.implementingDocumentationOrArticfacts
      item.deviationIdentifier = ec.deviationIdentifier
      item.testMethod = ec.testMethod
      item.testProcedure = ec.testProcedure
      item.plannedTestDate = ec.plannedTestDate
      item.scheduledTestYear = ec.scheduledTestYear
      item.actualTestDate = ec.actualTestDate
      item.testResult = ec.testResult
      item.testResultDescription = ec.testResultDescription
      item.assessorName = ec.assessorName
      item.cAndADoc = ec.cAndADoc
      item.controlReference = ec.controlReference
      item.save
      
    end
    
    1
    
  end

end
