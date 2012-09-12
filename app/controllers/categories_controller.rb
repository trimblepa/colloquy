class CategoriesController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    logger.debug 'asdfasdfasdfasdfasdfasdfas'
    logger.debug params.inspect
    @items = Category.where colloquy_id: params['colloquy_id']

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Category.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Category.new(params[:category])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Category was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Category.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:category])
        format.html { redirect_to @item, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Category.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
end
