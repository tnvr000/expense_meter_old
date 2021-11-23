class PrimaryCategoriesController < ApplicationController
  def categories
    primary_category = PrimaryCategory.find_by(id: params[:id])
    @categories = primary_category.categories.pluck(:name, :id) if primary_category.present?
    respond_to do |format|
      format.json { render(json: (@categories || [])) }
    end
  end
end
