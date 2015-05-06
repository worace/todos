class ArchivedListsController < ApplicationController
  def index
    @lists = List.archived
  end

  def create
    list = List.find(params[:list_id])
    if list
      list.archive!
    end
    redirect_to lists_path
  end
end
