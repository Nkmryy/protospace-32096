class PrototypesController < ApplicationController
  before_action :authenticate_user!, only:[:edit, :new]
  before_action :move_to_index, only: [:edit]

  def index
    @prototype = Prototype.includes(:user)
  end

  def new
    if user_signed_in?
      @prototype = Prototype.new
    else
      render 
    end
  end

  def create
    prototype = Prototype.create(prototype_params)
    if prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    if prototype.save
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.delete
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept,:image).merge(user_id: current_user.id)
  end

  def move_to_index
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype[:user_id]
      redirect_to action: :index
    end
  end
end
