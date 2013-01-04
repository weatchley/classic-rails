class ConfigvaluesController < ApplicationController
  # GET /configvalues
  # GET /configvalues.xml
  def index
    @configvalues = Configvalue.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @configvalues }
    end
  end

  # GET /configvalues/1
  # GET /configvalues/1.xml
  def show
    @configvalue = Configvalue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @configvalue }
    end
  end

  # GET /configvalues/new
  # GET /configvalues/new.xml
  def new
    @configvalue = Configvalue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @configvalue }
    end
  end

  # GET /configvalues/1/edit
  def edit
    @configvalue = Configvalue.find(params[:id])
  end

  # POST /configvalues
  # POST /configvalues.xml
  def create
    @configvalue = Configvalue.new(params[:configvalue])

    respond_to do |format|
      if @configvalue.save
        format.html { redirect_to(@configvalue, :notice => 'Configvalue was successfully created.') }
        format.xml  { render :xml => @configvalue, :status => :created, :location => @configvalue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @configvalue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /configvalues/1
  # PUT /configvalues/1.xml
  def update
    @configvalue = Configvalue.find(params[:id])

    respond_to do |format|
      if @configvalue.update_attributes(params[:configvalue])
        format.html { redirect_to(@configvalue, :notice => 'Configvalue was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @configvalue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /configvalues/1
  # DELETE /configvalues/1.xml
  def destroy
    @configvalue = Configvalue.find(params[:id])
    @configvalue.destroy

    respond_to do |format|
      format.html { redirect_to(configvalues_url) }
      format.xml  { head :ok }
    end
  end
end
