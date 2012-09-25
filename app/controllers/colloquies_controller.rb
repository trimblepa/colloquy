class ColloquiesController < ApplicationController
  def index
    @colloquies = Colloquy.all
    respond_to do |format|
      format.html
      format.json { render json: @colloquies }
    end
  end

  def show
    @colloquy = Colloquy.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @colloquy }
    end
  end

  def new
    @item = Colloquy.new
    respond_to do |format|
      format.html
      format.json { render json: @item }
    end
  end

  def edit
    @colloquy = Colloquy.find(params[:id])
  end

  def create
    @item = Colloquy.new(params[:colloquy])
    @item.seats = 0
    respond_to do |format|
      if @item.save
        format.html { redirect_to edit_colloquy_path(@item) }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @colloquy = Colloquy.find(params[:id])
    respond_to do |format|
      if @colloquy.update_attributes(params[:colloquy])
        format.html { redirect_to @colloquy, notice: 'Colloquy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @colloquy.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @colloquy = Colloquy.find(params[:id])
    @colloquy.destroy
    respond_to do |format|
      format.html { redirect_to colloquies_url }
      format.json { head :no_content }
    end
  end
end
