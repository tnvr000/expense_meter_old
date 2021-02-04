class Membership < ApplicationRecord
  belongs_to :customer
  belongs_to :group
end
