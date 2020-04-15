class Category < ApplicationRecord
  belongs_to :timeline
  has_and_belongs_to_many :events
end
