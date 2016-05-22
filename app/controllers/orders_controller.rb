class OrdersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized
  before_action :set_order, only: [:show, :edit, :update, :destroy, :approve]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    authorize Order
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    render layout: 'order'
    authorize @order
  end

  # GET /orders/new
  def new
    @order = Order.new
    @users = User.all

    authorize @order
  end

  # GET /orders/1/edit
  def edit
    authorize @order
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    authorize @order


    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    authorize @order

    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def approve
    authorize @order

    respond_to do |format|
      if @order.update_attribute(:approved, true)
        format.html { redirect_to @order, notice: 'Parabéns você agora possui uma solução viva com a CRAOSX' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    authorize @order

    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:code, :enable, :starting_at, :ending_at, :order_type, :user_id,
        blocks_attributes: [:id, :name, :description, :_destroy, components_attributes: [:id,
          :title, :head, :description, :footer, :price, :_destroy, items_attributes: [:id, :title,
            :subtitle, :description, :price, :_destroy]] ])
    end
end
