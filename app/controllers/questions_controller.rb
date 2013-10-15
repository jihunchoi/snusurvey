class QuestionsController < ApplicationController
  def create
    @survey = Survey.find(params[:question][:survey_id])
    unless @survey.user == current_user
      redirect_to root_url
      return
    end

    @question = Question.new(question_params)
    @question.order_weight = @survey.questions.maximum('order_weight').to_f + 1
    @question.save
    if @question.type == 0
      # radio
      params[:radioButtons].each do |k,v|
        c = @question.choices.new(label: v)
        c.save
      end
    elsif @question.type == 1
      # checkbox
      params[:checkBoxes].each do |k,v|
        c = @question.choices.new(label: v)
        c.save
      end
    end
    
    redirect_to edit_survey_path(@survey)
  end

  def destroy
  end

  def update
    prev_question = Question.find(params[:prev_id]) if params[:prev_id].present?
    next_question = Question.find(params[:next_id]) if params[:next_id].present?

    prev_weight = prev_question.order_weight if prev_question
    next_weight = next_question.order_weight if next_question

    unless prev_weight
      prev_weight = next_weight.to_f - 1;
    end
    unless next_weight
      next_weight = prev_weight.to_f + 1;
    end

    new_weight = (prev_weight + next_weight) / 2
    question = Question.find(params[:id])
    question.update_attribute(:order_weight, new_weight)

    render nothing: true
  end

  private
    def question_params
      params.require(:question).permit(:label, :type, :content, :survey_id)
    end
end
