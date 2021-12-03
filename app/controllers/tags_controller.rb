# frozen_string_literal: true

# manage tags
class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end
end
