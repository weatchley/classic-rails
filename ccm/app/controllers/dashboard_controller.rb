class DashboardController < ApplicationController
  # setup values required for displaying the ccm dashboard
  def show
    cctemp = Cybercontrol.first
    @contrFams = cctemp.controlFamilySet
    @cfam = (params[:fcode] != nil) ? params[:fcode] : "AC"
    @contrls = Cybercontrol.where(:controlFamilyCode => @cfam)
    @cid = (params[:id] != nil) ? params[:id] : "0"
    @cc = (@cid != "0") ? Cybercontrol.find(params[:id].to_i) : nil
    @enControls = (@cid != "0") ? Enclavecontrol.where("cybercontrol_id = ?", @cc.id) : nil
    @ecqid = (params[:encntrq] != nil) ? params[:encntrq] : "0"
    @ecq = (@ecqid != "0") ? Enclavecontrol.find(params[:encntrq].to_i) : nil
    @metricValues = Metric.new

  end

  # run the populate script for new enclave/quarter/year
  def populate
    @enclavequarter = Enclavequarter.new
    @populatestatus = @enclavequarter.populate(params[:year], params[:quarter])
  end

  # import data from ms excel file for the enclave controls table
  def processexcelfile
    @ft = Filetool.new
    @ft.processEnclaveControlsFile(params[:filepath])
  end

  # generate the apendix A spreadsheet for output
  def generateappendixa
    @ft = Filetool.new
    date = DateTime.now
    @fileName = "Appendix-A-#{date.year}#{date.month}#{date.day}-#{date.hour}#{date.min}.xls"
    @filePath = "#{FileUtils.pwd()}\\public\\ssout\\" + @fileName
    @filePathOut = "/ssout/#{@fileName}"
    @ft.generateAppendixA(@filePath)
  end

  # setup values required for the tools display/menu
  def tools
    # get list of excel files in the upload dir
    @fileList1 = Dir.glob("#{FileUtils.pwd()}/upload/*.xls")
    @fileList = Array.new
    i = 0
    # create file array for use in select
    @fileList1.each do |filepath|
      fileStart= filepath =~ /\/[\w\s\%\.]*$/
      fileStart += 1
      filepath2 = filepath[fileStart..filepath.length]
      @fileList[i] = filepath2
      i += 1
    end
  end


end
