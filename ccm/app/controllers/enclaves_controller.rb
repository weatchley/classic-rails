class EnclavesController < ApplicationController
  # GET /enclaves
  # GET /enclaves.xml
  def index
    @enclaves = Enclave.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @enclaves }
    end
  end

  # GET /enclaves/1
  # GET /enclaves/1.xml
  def show
    @enclave = Enclave.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @enclave }
    end
  end

  # GET /enclaves/new
  # GET /enclaves/new.xml
  def new
    @enclave = Enclave.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @enclave }
    end
  end

  # GET /enclaves/1/edit
  def edit
    @enclave = Enclave.find(params[:id])
  end

  # POST /enclaves
  # POST /enclaves.xml
  def create
    @enclave = Enclave.new(params[:enclave])

    respond_to do |format|
      if @enclave.save
        format.html { redirect_to(@enclave, :notice => 'Enclave was successfully created.') }
        format.xml  { render :xml => @enclave, :status => :created, :location => @enclave }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @enclave.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /enclaves/1
  # PUT /enclaves/1.xml
  def update
    @enclave = Enclave.find(params[:id])

    respond_to do |format|
      if @enclave.update_attributes(params[:enclave])
        format.html { redirect_to(@enclave, :notice => 'Enclave was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @enclave.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /enclaves/1
  # DELETE /enclaves/1.xml
  def destroy
    @enclave = Enclave.find(params[:id])
    @enclave.destroy

    respond_to do |format|
      format.html { redirect_to(enclaves_url) }
      format.xml  { head :ok }
    end
  end
end
