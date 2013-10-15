class ReportsController < ApplicationController
  def new
    @survey = Survey.find_by_id(params[:survey_id])

    unless @survey
      redirect_to '/'
    end

    @questions = @survey.questions.order('order_weight ASC')
    
  end
end
