# frozen_string_literal: true

# manage tags
class TagsController < ApplicationController
  before_action :authenticate_customer!

  # GET /tags
  # before_action: authenticate_customer!
  def index
    @tags = Tag.all
  end

  # GET /tags/new
  # before_action: authenticate_customer!
  def new
    @tag = Tag.new
  end

  # POST /tags
  # @param name [String]
  # before_action: authenticate_customer!
  def create
    byebug
    @tag = current_customer.tags.build(tag_params)
    respond_to do |format|
      if @tag.save
        format.html { redirect_to tags_url, notice: 'Tag was successfully created' }
      else
        format.html { render :new }
      end
    end
  end

  private

  # only allow a list of trusted parameters through.
  def tag_params
    params.require(:tag).permit(:name)
  end
end
