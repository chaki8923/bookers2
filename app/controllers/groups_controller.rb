class GroupsController < ApplicationController
  def new
    @group = Group.new
    @book = Book.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  def show
    
    @group = Group.find(params[:id])
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
