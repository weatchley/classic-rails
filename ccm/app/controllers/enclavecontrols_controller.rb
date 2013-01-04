class EnclavecontrolsController < ApplicationController
  # GET /enclavecontrols
  # GET /enclavecontrols.xml
  def index
    @enclavecontrols = Enclavecontrol.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @enclavecontrols }
    end
  end

  # GET /enclavecontrols/1
  # GET /enclavecontrols/1.xml
  def show
    @enclavecontrol = Enclavecontrol.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @enclavecontrol }
    end
  end

  # GET /enclavecontrols/new
  # GET /enclavecontrols/new.xml
  def new
    @enclavecontrol = Enclavecontrol.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @enclavecontrol }
    end
  end

  # GET /enclavecontrols/1/edit
  def edit
    @enclavecontrol = Enclavecontrol.find(params[:id])
    temp = Implementationstatus.first
    @implementationstatus = temp.nameArray
    temp = Testmethod.first
    @testmethods = temp.nameArray
    temp = Testresult.first
    @testresults = temp.nameArray
  end

  # POST /enclavecontrols
  # POST /enclavecontrols.xml
  def create
    @enclavecontrol = Enclavecontrol.new(params[:enclavecontrol])

    respond_to do |format|
      if @enclavecontrol.save
        format.html { redirect_to(@enclavecontrol, :notice => 'Enclavecontrol was successfully created.') }
        format.xml  { render :xml => @enclavecontrol, :status => :created, :location => @enclavecontrol }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @enclavecontrol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /enclavecontrols/1
  # PUT /enclavecontrols/1.xml
  def update
    @enclavecontrol = Enclavecontrol.find(params[:id])
    doApplyToAll = params[:applytoall]

    respond_to do |format|
      if @enclavecontrol.update_attributes(params[:enclavecontrol])
        # debug info to log
        #Rails.logger.error "\n" + "enclavecontrols_controller - Got Here 1 - doApplyToAll=#{doApplyToAll}\n"
        if doApplyToAll.to_i == 1 then
          ecTemp = Enclavecontrol.first
          ecTemp.applyToAll(@enclavecontrol.id)
        end
        format.html { redirect_to(@enclavecontrol, :notice => 'Enclavecontrol was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @enclavecontrol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /enclavecontrols/1
  # DELETE /enclavecontrols/1.xml
  def destroy
    @enclavecontrol = Enclavecontrol.find(params[:id])
    @enclavecontrol.destroy

    respond_to do |format|
      format.html { redirect_to(enclavecontrols_url) }
      format.xml  { head :ok }
    end
  end
end
