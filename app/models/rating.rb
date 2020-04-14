class Rating < ApplicationRecord
  validates_presence_of :normalized_score

  belongs_to :timeline
  belongs_to :user

  default_scope { order(created_at: :desc) }
  scope :active, -> { where(active: true) }

  def self.aggregate(user)
    user.ratings
        .active
        .group(:timeline_id)
        .average(:normalized_score)
  end

  after_create :deactivate_old_entries

  private

  def deactivate_old_entries
    ratings = user.ratings.active.where(timeline: timeline).drop(5)
    ratings.each do |rating|
      rating.active = false
      rating.save
    end
  end
end
