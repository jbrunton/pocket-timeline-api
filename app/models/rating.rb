class Rating < ApplicationRecord
  validates_presence_of :normalized_score

  belongs_to :timeline
  belongs_to :user

  def self.aggregate(user)
    user.ratings
        .group(:timeline_id)
        .average(:normalized_score)
        .map { |id, score| { timeline_id: id, score: score.to_f } }
  end
end
