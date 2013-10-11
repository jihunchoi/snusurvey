json.array!(@surveys) do |survey|
  json.extract! survey, :title, :description
  json.url survey_url(survey, format: :json)
end
