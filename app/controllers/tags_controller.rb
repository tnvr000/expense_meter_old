# frozen_string_literal: true

# manage tags
class TagsController < ApplicationController
  before_action :authenticate_customer!

  # GET /tags
  # before_action :authenticate_customer!
  def index
    @tags = Tag.all
  end

  # GET /tags/new
  # before_action :authenticate_customer!
  def new
    @tag = Tag.new
  end

  # POST /tags
  # @param name [String]
  # before_action :authenticate_customer!
  def create
    @tag = current_customer.tags.build(tag_params)
    respond_to do |format|
      if @tag.save
        format.html { redirect_to tags_url, notice: t('tags.created') }
      else
        format.html { render :new }
      end
    end
  end

  # GET /tags/:id/edit
  # @param id [String]
  # before_action :authenticate_customer!
  def edit
    @tag = current_customer.tags.find_by id: params[:id]
  end

  # PATCH /tags/:id
  # PUT /tags/:id
  # @param name [String]
  # before_action :authenticate_customer!
  def update
    @tag = current_customer.tags.find_by id: params[:id]
    respond_to do |format|
      if @tag.update tag_params
        format.html { redirect_to tags_path, notice: t('tags.updated') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tags/:id
  # @param id [String]
  # before_action :authenticate_customer!
  def destroy
    @tag = current_customer.tags.find_by id: params[:id]
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: t('tags.deleted') }
    end
  end

  private

  # only allow a list of trusted parameters through.
  def tag_params
    params.require(:tag).permit(:name)
  end
end
