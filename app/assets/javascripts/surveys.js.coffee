# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# ready = ->
#   $("#questionType").change ->
#     $(".question").each ->
#       $(this).hide()
#     type = $(this).children("option:selected").attr("class")
#     $("#"+type).show()

#   $("#addRadioButton").click ->
#     cnt = $("#radioButtons").children().length
#     label = $("#radioButtonChoiceLabel").val()
#     if label.trim() is ""
#       alert "문항 내용을 입력해 주세요"
#       return false
#     $("#radioButtonChoiceLabel").val("")
#     markup = '<p><input type="radio" disabled><input type="hidden" value="'+label+'" name="radioButtons['+cnt+']"> '+label+'</p>'
#     $("#radioButtons").append(markup)
#     return false

#   $("#addCheckBox").click ->
#     cnt = $("#checkBoxes").children().length
#     label = $("#checkBoxChoiceLabel").val()
#     if label.trim() is ""
#       alert "문항 내용을 입력해 주세요"
#       return false
#     $("#checkBoxChoiceLabel").val("")
#     markup = '<p><input type="checkbox" disabled><input type="hidden" value="'+label+'" name="checkBoxes['+cnt+']"> '+label+'</p>'
#     $("#checkBoxes").append(markup)
#     return false

#   $("#edit-questions").sortable
#     placeholder: "sortable-placeholder"
#     start: (event, ui) ->
#       $(ui.item).parent().find('.sortable-placeholder').height($(ui.item).height())
#     update: (event, ui) ->
#       question = $(ui.item)
#       prevQuestion = question.prev()
#       nextQuestion = question.next()
#       data = {
#         prev_id: prevQuestion.data('question-id')
#         next_id: nextQuestion.data('question-id')
#         _method: 'patch'
#       }
#       url = '/questions/' + question.data('question-id')
#       $.ajax
#         method: 'post'
#         url: url
#         data: data
#         error: ->
#           alert "오류가 발생했습니다. 새로고침 후 다시 시도해 주세요"

#   $(".entries > label.radio-label").click ->
#     selectedLabel = $(".label-selected")
#     choiceId = $(this).data('choice-id')
#     if selectedLabel.is $(this)
#       $(this).removeClass('label-selected')
#       $('.parent_choice_id').each ->
#         $(this).removeAttr('value')
#     else
#       selectedLabel.removeClass('label-selected')
#       $(this).addClass('label-selected')
#       $('.parent_choice_id').each ->
#         $(this).val(choiceId)

#   $("#edit-questions").disableSelection()

ready = ->
  $("#addQuestion").click ->
    count = $('.questions').children().length
    markup = '<div class="question" data-question-id="'+(count+1)+'">'
    markup += '<div class="question-label">'
    markup += (count+1) + '. <input type="text" name="questions['+(count+1)+'][label]">'
    markup += '</div>'
    markup += '<a role="button" class="btn btn-default addChoice">보기 추가하기</a>'
    markup += '<a role="button" class="btn btn-default deleteChoice">보기 삭제하기</a>'
    markup += '<a role="button" class="btn btn-default deleteQuestion">질문 삭제하기</a>'
    markup += '<div class="choices">'
    markup += '<div class="choice">'
    markup += '1. <input type="text" name="questions['+(count+1)+'][choices][1][label]">'
    markup += '<input type="text" name="questions['+(count+1)+'][choices][1][next_question_id]">'
    markup += '</div>'
    markup += '</div>'
    $('.questions').append(markup)

$(document).on "click", ".addChoice", ->
  question = $(this).parent()
  question_id = question.data('question-id')
  choices = question.children('.choices')
  count = choices.children().length
  markup = '<div class="choice">'
  markup += (count+1) + '. <input type="text" name="questions['+question_id+'][choices]['+(count+1)+'][label]">'
  markup += '<input type="text" name="questions['+question_id+'][choices]['+(count+1)+'][next_question_id]">'
  markup += '</div>'
  choices.append(markup)

$(document).on "click", ".deleteChoice", ->
  question = $(this).parent()
  choices = question.children('.choices')
  count = choices.children().length
  if count is 1
    alert "최소 1개의 보기가 있어야 합니다."
  else
    choice = choices.children().last()
    choice.remove()

$(document).on "click", ".deleteQuestion", ->
  question = $(this).parent()
  questions = question.parent()
  count = questions.children().length
  if count is 1
    alert "최소 1개의 질문이 있어야 합니다."
  else
    question.remove()

$(document).ready ready
$(document).on "page:load", ready
