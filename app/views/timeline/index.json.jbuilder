json.array! @timelines do |timeline|
  json.merge! timeline.attributes
  json.merge!(ratings: ratings_for(timeline))
  json.merge!(categories: timeline.categories)
end
