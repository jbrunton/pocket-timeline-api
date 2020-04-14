class Rating < ApplicationRecord
  validates_presence_of :normalized_score

  belongs_to :timeline
  belongs_to :user

  scope :active, -> { where(active: true).order(created_at: :desc) }

  def self.aggregate(user)
    user.ratings
        .active
        .group(:timeline_id)
        .average(:normalized_score)
        .map { |id, score| { timeline_id: id, normalized_score: score.to_f } }
  end

  after_create :deactivate_old_entries

  private

  def deactivate_old_entries
    ratings = user.ratings.active.drop(5)
    ratings.each do |rating|
      rating.active = false
      rating.save
    end
  end
end
