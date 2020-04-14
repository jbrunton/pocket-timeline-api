class Rating < ApplicationRecord
  belongs_to :timeline
  belongs_to :user
end
