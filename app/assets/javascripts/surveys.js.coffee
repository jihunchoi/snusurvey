# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $("#questionType").change ->
    $(".question").each ->
      $(this).hide()
    type = $(this).children("option:selected").attr("class")
    $("#"+type).show()

  $("#addRadioButton").click ->
    cnt = $("#radioButtons").children().length
    label = $("#radioButtonChoiceLabel").val()
    if label.trim() is ""
      alert "문항 내용을 입력해 주세요"
      return false
    $("#radioButtonChoiceLabel").val("")
    markup = '<p><input type="radio" disabled><input type="hidden" value="'+label+'" name="radioButtons['+cnt+']"> '+label+'</p>'
    $("#radioButtons").append(markup)
    return false

  $("#addCheckBox").click ->
    cnt = $("#checkBoxes").children().length
    label = $("#checkBoxChoiceLabel").val()
    if label.trim() is ""
      alert "문항 내용을 입력해 주세요"
      return false
    $("#checkBoxChoiceLabel").val("")
    markup = '<p><input type="checkbox" disabled><input type="hidden" value="'+label+'" name="checkBoxes['+cnt+']"> '+label+'</p>'
    $("#checkBoxes").append(markup)
    return false

  $("#questions").sortable
    placeholder: "sortable-placeholder"
    start: (event, ui) ->
      $(ui.item).parent().find('.sortable-placeholder').height($(ui.item).height())
    update: (event, ui) ->
      question = $(ui.item)
      prevQuestion = question.prev()
      nextQuestion = question.next()
      data = {
        prev_id: prevQuestion.data('question-id')
        next_id: nextQuestion.data('question-id')
        _method: 'patch'
      }
      url = '/questions/' + question.data('question-id')
      $.ajax
        method: 'post'
        url: url
        data: data
        success: ->
          console.log "success"
        error: ->
          console.log "error"


  $("#edit-questions").disableSelection()

$(document).ready ready
$(document).on "page:load", ready
