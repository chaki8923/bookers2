class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    begin
      @user = User.find(params[:id])
      @books = @user.books
      @book = Book.new
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "NOT FOUND CHAT USER USER_ID --->このidのuserいないよ#{params[:id]}<---"
      redirect_to users_path
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end
  
  def edit
    begin
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user), notice: "You can't edit other user's profile."
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "存在しないユーザーを編集できません。"
      redirect_to users_path
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  def search_count
    @user = User.find(params[:id])
    @dat_of_count =  @user.books.where("DATE(created_at) = ?", params[:date]).count
    respond_to do |format|
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
