class ReportsController < ApplicationController
  def new
    @survey = Survey.find_by_id(params[:survey_id])

    unless @survey
      redirect_to '/'
    end

    @questions = @survey.questions.order('question_number ASC')
    @report = Report.new
  end

  def create
    report_params = {
      user_id: current_user.id,
      survey_id: params[:survey_id]
    }
    @report = Report.new(report_params)
    @report.save

    @answers = JSON.parse(params["jsonString"])
    @answers.each do |answer|
      question_id = answer["question_id"]
      type = answer["type"]
      if type == 0
        # radio
        choice_id = answer["choice_id"]
        answer_params = {
          type: type,
          question_id: question_id,
          choice_id: choice_id,
          report_id: @report.id
        }
        Answer.new(answer_params).save
      elsif type == 1
        # checkbox
        answer["choice_ids"].each do |choice_id|
          answer_params = {
            type: type,
            question_id: question_id,
            choice_id: choice_id,
            report_id: @report.id
          }
          Answer.new(answer_params).save
        end
      else
        # subjective
        content = params["content"]
        answer_params = {
          type: type,
          question_id: question_id,
          content: content,
          report_id: @report.id
        }
        Answer.new(answer_params).save
      end
    end
    render 'complete'
  end
end
