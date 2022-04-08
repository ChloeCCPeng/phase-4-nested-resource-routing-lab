class ItemsController < ApplicationController
  #returns a 404 response if the user is not found
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #returns an array of all items belonging to a user
  def show
      item = Item.find(params[:id])
      render json: item, include: :user
  end

  #creates a new item belonging to a user
  #returns the newly created item
  def create
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  #returns the item with the matching id
  #returns a 404 response if the item is not found
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    #returns an array of all items with user info
    render json: items, include: :user
  end

  private

  def render_not_found_response
    render json: { error: "Item not found" }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price)
  end

end
