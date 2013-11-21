json.array! @questions do |question|
  json.extract! question, :id, :label, :question_number
  json.choices question.choices do |choice|
    json.extract! choice, :id, :label, :next_question_id
  end
end
