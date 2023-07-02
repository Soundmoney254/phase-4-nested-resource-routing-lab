class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def show
    @user = User.find_by(id: params[:id])
    render json: user_with_items(@user)
  end

  def index
    @users = User.all
    render json: @users
  end

  private

  def user_with_items(user)
    {
      id: user.id,
      username: user.username,
      city: user.city,
      items: user.items.map do |item|
        {
          id: item.id,
          name: item.name,
          description: item.description,
          price: item.price
        }
      end
    }
  end

  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end
end
