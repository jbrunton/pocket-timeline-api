class Timeline < ApplicationRecord
  has_many :events
  has_many :categories
end
