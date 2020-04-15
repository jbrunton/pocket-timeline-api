json.array! @timelines do |timeline|
  json.merge! timeline.attributes

  json.categories timeline.categories do |category|
    json.merge! category.attributes
    json.merge!(ratings: ratings_for(category))
  end
end
