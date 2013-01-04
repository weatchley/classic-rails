class Implementationstatus < ActiveRecord::Base
  attr_reader :name

  # internal attribute for name
  def name
    name = self.ImplementationStatus
  end
  
  # generate an array of names
  def nameArray
    myset = Implementationstatus.all
    nameArray = Array.new
    i = 0
    myset.each do |obj|
      nameArray[i] = obj.name
      i += 1
    end
    nameArray
  end
  
end
