class Expense < ApplicationRecord
  belongs_to :customer
  belongs_to :group, optional: true
  belongs_to :category
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # add given tags to current expense.
  # @param tags [Tag]
  # @return nil
  def add_tags(tags)
    tags.each do |tag|
      self.tags << tag
    end
  end

  # delete given tags from current expense
  # @param tags [Tag]
  # @return nil
  def delete_tags(tags)
    tags.each do |tag|
      self.tags.delete(tag)
    end
  end

  # add and delete tags from current expense
  # @param given_tags [Tag]
  # @return nil
  def manage_tags(given_tags)
    # compare existing tags and given tags. delete from existing tags that is not in given tag and delete
    # from given tags that is in the existing tag. then add remaining given tags to existing tag
    existing_tag_ids = tags.pluck(:id)
    given_tag_ids = given_tags.map(&:id)
    tags_to_be_deleted = Tag.where(id: existing_tag_ids - given_tag_ids)
    tags_to_be_added = given_tags.select do |given_tag|
      (given_tag_ids - existing_tag_ids).include?(given_tag.id)
    end
    add_tags(tags_to_be_added)
    delete_tags(tags_to_be_deleted)
  end

  # return primary category of current expense
  # @return primary_category [PrimaryCategory]
  def primary_category
    category.primary_category
  end

  def category_description
    "#{primary_category.name}/#{category.name}"
  end
end
