# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $("#report-submit").click ->
    questions = $("#report-questions")
    survey_id = questions.data("survey-id")
    answers = []
    questions.children("li").each ->
      question_id = $(this).data("question-id")
      entries = $(this).children(".entries")
      type = entries.data("question-type")
      if type is 0
        # radio
        choice_id = entries.find("input[type=radio]:checked").eq(0).val()
        answer = {
          question_id: question_id
          choice_id: choice_id
          type: type
        }
        answers.push(answer)
      else if type is 1
        # checkbox
        choice_ids = []
        entries.find("input[type=checkbox]:checked").each ->
          choice_id = $(this).val()
          choice_ids.push(choice_id)
        answer = {
          question_id: question_id
          choice_ids: choice_ids
          type: type
        }
        answers.push(answer)
      else
        # subjective
        content = entries.find("input[type=text]").val()
        answer = {
          question_id: question_id
          content: content
          type: type
        }
        answers.push(answer)
    data = {
      jsonString: JSON.stringify(answers)
      survey_id: survey_id
    }
    $("#jsonString").val(JSON.stringify(answers))
    $("#survey_id").val(survey_id)

$(document).ready ready
$(document).on "page:load", ready

