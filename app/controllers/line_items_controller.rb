class LineItemsController < ApplicationController
  include CurrentCart
  skip_before_action :authorize, only: :create
  before_action :set_cart, only: [:create, :update]
  before_action :set_line_item, only: [:show, :edit, :destroy]
  


  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create

    session[:counter] = 0
    
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_index_url }
        # for ajax requests
        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update

    product = Product.find(params[:product_id])
    @line_item = @cart.reduce_product(product)

    respond_to do |format|
      if @line_item != "destroyed"
        if @line_item.update(line_item_params)
          format.html { redirect_to store_index_url }
          format.js { @current_item = @line_item }
          format.json { render :show, status: :ok, location: @line_item }
        else
          format.html { render :edit }
          format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to store_index_url, notice: "Line item was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      # cart_url(@line_item.cart)
      format.html { redirect_to store_index_url, notice: 'Line item was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end
end
