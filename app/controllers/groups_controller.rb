class GroupsController < ApplicationController
  def new
    @group = Group.new
    @book = Book.new
  end

  def edit
    begin
      @group = Group.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "YOU CAN NOT EDIT THIS BOOK ---->このidの投稿ないよ#{params[:id]}<----"
      redirect_to groups_path
    end
  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  def show
    begin
      @group = Group.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "NOT FOUND CHAT GROUP GROUP_ID ---->このidのgroupないよ#{params[:id]}<----"
      redirect_to groups_path
    end
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.image.attach(params[:group][:image]) if params[:group][:image].present?
    # 他の処理

    if @group.save
       redirect_to groups_path, notice: "You have created group successfully."
    else
      render 'new'
    end
  end
  
  def update
    @group = Group.find(params[:id])
    @group.image.attach(params[:group][:image]) if params[:group][:image].present?
    # 他の処理

    if @group.update(group_params)
       redirect_to groups_path, notice: "You have updated group successfully."
    else
      render 'new'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @groups = Group.all
    if @group.delete
      redirect_to groups_path, notice: "You have delete group successfully."
    else
       render 'index'
    end
  end



  private

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id, :imagecd )
  end
end
