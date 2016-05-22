class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # GET /messages
  # GET /messages.json
  def index
    @messages = policy_scope(Message.all.order('created_at DESC'))
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    authorize @message
  end

  # GET /messages/new
  def new
    @message = Message.new
    @message.user = User.find(params[:user])
    @message.component = Component.find(params[:component])

    authorize @message
  end

  # GET /messages/new2
  def new2
    @message = Message.new

    authorize @message
  end

  # GET /messages/1/edit
  def edit
    authorize @message
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    authorize @message

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message.component.block.order, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message.component.block.order }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /messages
  # POST /messages.json
  def create2
    @message = Message.new(message_params)

    authorize @message

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_path, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: messages_path }
      else
        format.html { render :new2 }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update

    authorize @message
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    authorize @message
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:user_id, :component_id, :body)
    end
end
