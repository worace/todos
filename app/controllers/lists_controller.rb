class ListsController < ApplicationController
  def index
    @lists = List.active
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(list_params)
      redirect_to list_path(@list)
    else
      render :edit
    end
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    list = List.find(params[:id])
    list.destroy! if list
    redirect_to root_path
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end
end
