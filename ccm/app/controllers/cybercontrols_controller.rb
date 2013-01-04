class CybercontrolsController < ApplicationController
  # GET /cybercontrols
  # GET /cybercontrols.xml
  def index
    @cybercontrols = Cybercontrol.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cybercontrols }
    end
  end

  def indextest
    cc = Cybercontrol.first
    @cybercontrols = cc.controlFamilySet

    respond_to do |format|
      format.html # indextest.html.erb
      format.xml  { render :xml => @cybercontrols }
    end
  end

  # GET /cybercontrols/1
  # GET /cybercontrols/1.xml
  def show
    @cybercontrol = Cybercontrol.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cybercontrol }
    end
  end

  # GET /cybercontrols/new
  # GET /cybercontrols/new.xml
  def new
    @cybercontrol = Cybercontrol.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cybercontrol }
    end
  end

  # GET /cybercontrols/1/edit
  def edit
    @cybercontrol = Cybercontrol.find(params[:id])
  end

  # POST /cybercontrols
  # POST /cybercontrols.xml
  def create
    @cybercontrol = Cybercontrol.new(params[:cybercontrol])

    respond_to do |format|
      if @cybercontrol.save
        format.html { redirect_to(@cybercontrol, :notice => 'Cybercontrol was successfully created.') }
        format.xml  { render :xml => @cybercontrol, :status => :created, :location => @cybercontrol }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cybercontrol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cybercontrols/1
  # PUT /cybercontrols/1.xml
  def update
    @cybercontrol = Cybercontrol.find(params[:id])

    respond_to do |format|
      if @cybercontrol.update_attributes(params[:cybercontrol])
        format.html { redirect_to(@cybercontrol, :notice => 'Cybercontrol was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cybercontrol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cybercontrols/1
  # DELETE /cybercontrols/1.xml
  def destroy
    @cybercontrol = Cybercontrol.find(params[:id])
    @cybercontrol.destroy

    respond_to do |format|
      format.html { redirect_to(cybercontrols_url) }
      format.xml  { head :ok }
    end
  end
end
