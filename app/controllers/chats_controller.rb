class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = Chat.new(chat_params)
    @chat.sender = current_user
    @user = current_user
    @chats = Chat.between(current_user.id, params[:user_id])
    if @chat.save
      redirect_to chat_path(@chat.receiver)
    else
      render 'index'
    end
  end
  
  def show
    begin
      @chat = Chat.new
      @user = current_user
      @receiver_id = params[:id]
      @other =  User.find(@receiver_id)
      @chats = Chat.between(current_user.id, params[:id]).order(created_at: :asc)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "NOT FOUND CHAT ROOM"
      redirect_to users_path
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :receiver_id, :sender_id)
  end
end
