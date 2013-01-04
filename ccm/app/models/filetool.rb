#
# A model to process file information.
#
class Filetool
  attr_reader :id, :status

  def initialize

    @id = 1 # 1 is used just for convenience
    @status = false # initial status is set to false
    
  end
  
  #import data from the cyber controls spreadsheet (apendix a)
  def processEnclaveControlsFile(filePath)
    # setup
    sql = ActiveRecord::Base.connection();
    fileName = "#{FileUtils.pwd()}/upload/#{filePath}.xls"
    fileName = fileName.gsub(/\//, '\\')
    
    # set up two pointers for spreadsheet to work on different tabs
    s = Excel.new(fileName)
    s2 = Excel.new(fileName)
    s.default_sheet = s.sheets[1]
    s2.default_sheet = s2.sheets[4]
    
    # process each record in spreadsheet
    8.upto(s.last_row) do |line|
      # get line of info from spreadsheet
      line2 = line + 1
      #baseControlNumber = s.cell(line, 'A')
      baseControlNumber = s2.cell(line2, 'F')
      #controlName = s.cell(line, 'B')
      controlName = s2.cell(line2, 'G')
      cagControla = s.cell(line, 'E')
      cagControl = s2.cell(line2, 'K')
      implementationStatus = s.cell(line, 'F')
      implementationDescription = s.cell(line, 'G')
      testMethod = s.cell(line, 'H')
      poam = s.cell(line, 'I')
      
      # debug info to log
      #Rails.logger.error "\n" + "#{line}-a: #{baseControlNumber}, b: #{controlName}, c: #{cagControl}, d: #{implementationStatus}, e: #{implementationDescription}, f: #{testMethod}\n"
      
      if baseControlNumber != nil then #Skip empty lines
        # determin cybercontrol referenced
        controlFamily = ''
        controlNumber = 0
        enhancement = nil
        parts = baseControlNumber.split(/-/)
        controlFamily = parts[0]
        controlNumber = parts[1]
        if (/^\([0-9]*\)$/ =~ controlName) then
          enhancement = controlName.gsub(/\(/,'')
          enhancement = enhancement.gsub(/\)/, '')
        end
        
        # get matching cyber control
        cc = nil
        if enhancement != nil then
          cc = Cybercontrol.where(:controlFamilyCode => controlFamily, :controlNumber => controlNumber, :enhancement => enhancement).first
        else
          cc = Cybercontrol.where("controlFamilyCode=? AND controlNumber=? AND enhancement IS NULL", controlFamily, controlNumber).first
        end
        
        # Post data to enclave controls table
        #sqlcode = "UPDATE enclavecontrols SET SSPImplementationStatus=?, SSPImplementationDescription=?, testMethod=?" + ((cagControl='RMF') ? ", RMF=1" : "") + " WHERE cybercontrol_id=#{cc.id}"
        #status = sql.execute(sqlcode, implementationStatus, implementationDescription, )
        ecSet = Enclavecontrol.where(:cybercontrol_id => cc.id)
        ecSet.each do |ec|
          ec.SSPImplementationStatus = implementationStatus
          ec.SSPImplementationDescription = implementationDescription
          ec.testMethod = testMethod
          if (cagControla=="RMF") then
            ec.RMF = 1
          else
            ec.RMF = 0
          end
          ec.save
        end
      end
      
    end
  end
  
  # generate the cyber controls appendix a spreadsheet
  def generateAppendixA(filePath)
    
    # create new Excel workbook
    workbook = WriteExcel.new(filePath)
    
    # add worksheet(s)
    ws = workbook.add_worksheet
    
    # create formats
    format1 = workbook.add_format
    format1.set_bold
    format1.set_color('white')
    format1.set_align('center')
    format1.set_bg_color('navy')
    format1.set_text_wrap(1)
    
    format2 = workbook.add_format(:valign => 'top', :bold => 0, :text_wrap => 1)
    format3 = workbook.add_format(:valign => 'top', :bold => 0, :text_wrap => 1, :align => 'center')
    
    ws.set_column('A:C', 10)
    ws.set_column('B:B', 15)
    ws.set_column('C:C', 10)
    ws.set_column('D:D', 60)
    ws.set_column('E:E', 10)
    ws.set_column('F:F', 20)
    ws.set_column('G:G', 60)
    ws.set_column('H:H', 20)
    ws.set_column('I:I', 50)
    
    
    # get data
    temp = Enclavecontrol.first
    ecSet = temp.currentSet
    
    # initialize values
    line = 0
    
    # create header row(s)
    conf = Configvalue.where(:name => :systemname).first
    ws.write(line, 0, "System Name: #{conf.value}")
    ws.write(line, 5, "Uncontrolled Copy")
    line += 1
    conf = Configvalue.where(:name => :acronym).first
    ws.write(line, 0, "Acronym: #{conf.value}")
    ws.write(line, 5, "Refer to database for latest information")
    line += 1
    
    line += 1
    ws.write(line, 0, "800-53 Control Number", format1) # cell Ax
    ws.write(line, 1, "800-53 Control Name", format1) # cell Bx
    ws.write(line, 2, "800-53 Impact Level", format1) # cell Cx
    ws.write(line, 3, "800-53 Control Description", format1) # cell Dx
    ws.write(line, 4, "CAG Control", format1) # cell Ex
    ws.write(line, 5, "SSP-provided Implementation Status", format1) # cell Fx
    ws.write(line, 6, "SSP-provided Implementation Description", format1) # cell Gx
    ws.write(line, 7, "Test Method", format1) # cell Hx
    ws.write(line, 8, "New or Current Plan of Action & Milestones\nWeakness or Deviation Identifier\n(if applicable)", format1) # cell Ix
    
    ws.freeze_panes(line+1, 4)
    # process each input row, only use first enclave since all enclaves should be the same.
    testEnclave = Enclave.where("active = 1").first.id
    ecSet.each do |ec|
      if (ec.enclave_id == testEnclave) then
        line += 1
        ws.write(line, 0, ec.cybercontrol.controlNameNumber, format3) # cell Ax
        ws.write(line, 1, ec.cybercontrol.controlName, format2) # cell Bx
        ws.write(line, 2, ec.cybercontrol.impactLevel, format3) # cell Cx
        ws.write(line, 3, fixQuotes(ec.cybercontrol.controlDescription), format2) # cell Dx
        ws.write(line, 4, (((ec.RMF) ? "RMF" : ((ec.cybercontrol.criticalControl) ? "Yes" : "No"))), format3) # cell Ex
        ws.write(line, 5, ec.SSPImplementationStatus, format3) # cell Fx
        ws.write(line, 6, fixQuotes(ec.SSPImplementationDescription), format2) # cell Gx
        ws.write(line, 7, ec.testMethod, format3) # cell Hx
        ws.write(line, 8, "n/a", format2) # cell Ix
      end
      
    end
    
    # write to file
    workbook.close
    
    # delete old files not generated today
    date = DateTime.now
    todaystr = "#{date.year}#{date.month}#{date.day}"
    len = todaystr.length
    @fileList1 = Dir.glob("#{FileUtils.pwd()}/public/ssout/Appendix-A-*.xls")
    # test files in dir for old
    @fileList1.each do |filepath|
      loc = filepath.index("Appendix-A-") + 11
      teststr = filepath[loc,len]
      if (teststr != todaystr) then
          File.delete(filepath)
      end
    end
    
    
  end
  
  
  # fix microsoft curly quotes
  def fixQuotes(text)
    if (text != nil) then
      text = text.gsub("\342\200\230", "'")
      text = text.gsub("\342\200\231", "'")
      text = text.gsub("\342\200\234", '"')
      text = text.gsub("\342\200\235", '"')
    end
    result = text
    result
  end
  
end

