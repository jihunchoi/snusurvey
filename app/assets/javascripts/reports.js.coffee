# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

answeredQuestions = Array()
questions = Array()
currentQuestion = 1
keyFiring = false
switching = false

$.getJSON '/surveys' + location.pathname, (data) ->
  questions = data

  $.each questions, (index, question) ->
    markup = '<div class="panel panel-default"><div class="panel-heading"><h3 class="panel-title">' + question["label"] + '</h3></div><div class="panel-body"><ol>'
    $.each question["choices"], (answerIndex, answer) ->
      markup += '<li><label><input class="radio" type="radio" name="question_'+index+'" data-question-number="'+index+'" value="'+answerIndex+'">'+answer["label"]+'</label></li>'
    markup += '</ol></div><div class="panel-footer"><a href="#" class="prev_question_link">뒤로</div></div>'
    $("#container").append(markup)

  $(window).resize ->
    $(".panel").css
      position: 'absolute'
      left: ($(window).width() - $(".panel").outerWidth()) / 2
      top: ($(window).height() - $(".panel").outerHeight()) / 2

  showQuestion(0)

showQuestion = (questionNumber) ->
  question = $(".container").children().eq(questionNumber)
  questionData = questions[questionNumber]
  question.show()
  question.find("li").each ->
    $(this).css('color', 'black')
  console.log questionData
  if questionData["selectedIndex"] isnt undefined
    question.find("li").eq(questionData["selectedIndex"]).css('color', 'red')
  question.css
    position: 'absolute'
    left: ($(window).width() - question.outerWidth()) / 2
    top: ($(window).height() - question.outerHeight()) / 2

hideQuestion = (questionNumber) ->
  question = $(".container").children().eq(questionNumber)
  question.hide()

switchQuestion = (oldQuestionNumber, newQuestionNumber) ->
  switching = true
  answeredQuestions.push(oldQuestionNumber)
  currentQuestion = newQuestionNumber
  hideQuestion(oldQuestionNumber)
  if newQuestionNumber >= questions.length
    console.log "end"
  showQuestion(newQuestionNumber)
  switching = false

selectAnswer = (questionNumber, answerIndex) ->
  questionData = questions[questionNumber]
  questionData["selectedIndex"] = answerIndex
  nextQuestionNumber = questionData.choices[answerIndex].next_question_id - 1
  switchQuestion(questionNumber, nextQuestionNumber)

$(document).on "click", "input[type=radio]", ->
  console.log questions[0]
  answerIndex = $(this).val()
  questionNumber = $(this).data('question-number')
  selectAnswer(questionNumber, answerIndex)

$(document).on "keydown", "body", (e) ->
  if !keyFiring and !switching
    keyFiring = true
    key = e.which;
    if key is 37
      $(".container").children().eq(currentQuestion-1).find(".prev_questions_link").click()
    else if key - 48 > 0 and key - 48 < 10
      $(".container").children().eq(currentQuestion-1).find("input[type=radio]").eq(key-48-1).click()
    else if key - 96 > 0 and key - 96 < 10
      $(".container").children().eq(currentQuestion-1).find("input[type=radio]").eq(key-96-1).click()

$(document).on "keyup", "body", (e) ->
  keyFiring = false

$(document).on "click", ".prev_questions_link", (e) ->
  e.preventDefault()
  if answeredQuestions.length == 0
    return
  prevQuestion = answeredQuestions.pop()
  switchQuestion(currentQuestion, prevQuestion)
  answeredQuestions.pop()

ready = =>
  
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

