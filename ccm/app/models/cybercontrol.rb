class Cybercontrol < ActiveRecord::Base
  has_many :enclavecontrols
  
  # internal attribute for concatinated name/number
  def controlNameNumber
    cntrlName = self.controlFamilyCode + " #{self.controlNumber}" + ((self.enhancement != nil) ? "(#{self.enhancement})" : '')
    cntrlName
  end
  
  # internal attribute for current controlName
  def controlFamilyName
    cntrlFcName = ""
    if self.enhancement == nil then
      cntrlFcName = self.controlName
    else
      cfc = Cybercontrol.where("enhancement is null and controlFamilyCode = '#{self.controlFamilyCode}' and controlNumber = #{self.controlNumber}").first
      cntrlFcName = cfc.controlName
    end
    cntrlFcName
  end
  
  # internal attribute for the set of control family names
  def controlFamilySet
    conf = Configvalue.where(:name => :controlrevision).first
    controlRev = conf.ivalue
    cntrlFam = Cybercontrol.where("enhancement is null and controlNumber = 1 and Revision = #{controlRev}")
    cntrlFam
  end
  
  # internal attribute for the set of root controls
  def controlSet
    cntrl = Cybercontrol.where("enhancement is null")
    cntrl
  end
end
