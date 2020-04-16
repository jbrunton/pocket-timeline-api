class CategoriesController < ApplicationController
  def show
    category = Category.includes(:events).find(params[:id])
    render json: category.to_json(include: [:events])
  end
end
