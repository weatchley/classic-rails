class Testmethod < ActiveRecord::Base
  attr_reader :name

  # internal attribute for name
  def name
    name = self.TestMethod
  end
  
  # generate an array of names
  def nameArray
    myset = Testmethod.all
    nameArray = Array.new
    i = 0
    myset.each do |obj|
      nameArray[i] = obj.name
      i += 1
    end
    nameArray
  end
  
end
