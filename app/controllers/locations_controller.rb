class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token

  def purge
    Location.delete_all
    redirect_to locations_path()
  end


  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.csv { send_data @locations.to_csv }
      format.xls { send_data @locations.to_csv(col_sep: "\t") }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location =
      if params.has_key? :location
        Location.new(params[:location])
      elsif params.has_key? :drifter_name
        Location.new(params)
      else
        Location.new()
      end
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :json => @location }
      else
        format.html { render action: 'new' }
        format.json { render :json => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  def drifter
    if params[:val].present?
      @id = params[:id]
      @l0 = Location.find_all_by_drifter_name("Drifter #"+@id.to_s)
    elsif params[:id].present?
      @id = params[:id]
      @specific = true
      @nb=1
      if params[:nb].present?
        @nb=params[:nb]
      end
      @l0 = Location.where("drifter_name = 'Drifter #"+@id.to_s+"'").order(created_at: :desc).limit(@nb.to_i)
      @l1 = Location.where("drifter_name = 'Drifter #"+@id.to_s+"'").order(created_at: :desc).limit(@nb.to_i+100)
    elsif params[:nb].present?
      @specific = false
      @nb = params[:nb]
      @driftersListNumber = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      @l0List = Array[]
      @l1List = Array[]
      @driftersListNumber.each do |i|
        @l0 =Location.where("drifter_name = 'Drifter #"+i.to_s+"'").order(created_at: :desc).limit(@nb.to_i)
        @l0List.push(@l0)
        @l1 =Location.where("drifter_name = 'Drifter #"+i.to_s+"'").order(created_at: :desc).limit(@nb.to_i+30)
        @l1List.push(@l1)
      end
    else
      @specific = false
      @driftersListNumber = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      @l0List = Array[]
      @l1List = Array[]
      @driftersListNumber.each do |i|
        @l0 =Location.where("drifter_name = 'Drifter #"+i.to_s+"'").order(created_at: :desc).limit(1)
        @l0List.push(@l0)
        @l1 =Location.where("drifter_name = 'Drifter #"+i.to_s+"'").order(created_at: :desc).limit(30)
        @l1List.push(@l1)
      end
    end
  end

  def simulation
    @l0 = Location.all
  end

  def menu
    p "in menu"
    if params.to_s.include? "checkbox"
      session[:drifter]=[]
      params.each {|key, value|
      if "#{key}".include? "checkbox"
        #p "#{key}".last(2).to_s
        session[:drifter].push "#{key}".last(1).to_i
      end }
    end
    p session[:drifter]
  end

  def history
    @l0 = Location.all
  end

  def live
    if params[:val].present?
      @id = params[:id]
      @l0 = Location.find_all_by_drifter_name("Drifter #"+@id.to_s)
    elsif params[:id].present?
      @id = params[:id]
      @specific = true
      @l = Location.find_all_by_drifter_name("Drifter #"+@id.to_s)
      @l0 = @l.last
    elsif params[:action] =="live"
      @l0 = Location.first
    else
      @l0 = Location.all
    end
  end

  def import
    if params[:file].blank?
      flash[:alert] = "You have to attach something to Import."
      redirect_to locations_path
      return
    end
    Location.import(params[:file])
    redirect_to locations_path, notice: "Locations imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end
end
