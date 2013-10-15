class QuestionsController < ApplicationController
  def create
    @survey = Survey.find(params[:survey_id])
    unless @survey.user == current_user
      redirect_to root_url
      return
    end

    @question = @survey.questions.new(question_params)
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
  end

  private
    def question_params
      params.require(:question).permit(:label, :type, :content, :survey_id)
    end
end
