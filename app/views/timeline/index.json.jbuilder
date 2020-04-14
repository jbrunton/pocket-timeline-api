json.array! @timelines do |timeline|
  json.merge! timeline.attributes
  json.merge!(normalized_score: normalized_score_for(timeline))
end
