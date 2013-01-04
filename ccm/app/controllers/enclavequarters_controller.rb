class EnclavequartersController < ApplicationController
  # GET /enclavequarters
  # GET /enclavequarters.xml
  def index
    @enclavequarters = Enclavequarter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @enclavequarters }
    end
  end

  # GET /enclavequarters/1
  # GET /enclavequarters/1.xml
  def show
    @enclavequarter = Enclavequarter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @enclavequarter }
    end
  end

  # GET /enclavequarters/new
  # GET /enclavequarters/new.xml
  def new
    @enclavequarter = Enclavequarter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @enclavequarter }
    end
  end

  # GET /enclavequarters/1/edit
  def edit
    @enclavequarter = Enclavequarter.find(params[:id])
  end

  # POST /enclavequarters
  # POST /enclavequarters.xml
  def create
    @enclavequarter = Enclavequarter.new(params[:enclavequarter])

    respond_to do |format|
      if @enclavequarter.save
        format.html { redirect_to(@enclavequarter, :notice => 'Enclavequarter was successfully created.') }
        format.xml  { render :xml => @enclavequarter, :status => :created, :location => @enclavequarter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @enclavequarter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /enclavequarters/1
  # PUT /enclavequarters/1.xml
  def update
    @enclavequarter = Enclavequarter.find(params[:id])

    respond_to do |format|
      if @enclavequarter.update_attributes(params[:enclavequarter])
        format.html { redirect_to(@enclavequarter, :notice => 'Enclavequarter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @enclavequarter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /enclavequarters/1
  # DELETE /enclavequarters/1.xml
  def destroy
    @enclavequarter = Enclavequarter.find(params[:id])
    @enclavequarter.destroy

    respond_to do |format|
      format.html { redirect_to(enclavequarters_url) }
      format.xml  { head :ok }
    end
  end
end
