#!/bin/env ruby
# encoding: utf-8
class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  # GET /surveys
  # GET /surveys.json
  def index
    unless current_user.confirmed?
      redirect_to auth_new_path
      return
    end
    @surveys = current_user.surveys.all
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
    unless auth_privilege
      redirect_to surveys_url, notice: '권한이 없습니다.'
      return
    end

    unless @survey.editable?
      redirect_to surveys_url, notice: '진행 중인 설문은 수정할 수 없습니다.'
      return
    end

    @questions = @survey.questions.order('order_weight ASC')
    @question = @questions.new
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)
    @survey.user = current_user
    @survey.editable = true

    respond_to do |format|
      if @survey.save
        format.html { redirect_to edit_survey_path(@survey), notice: 'Survey was successfully created.' }
        format.json { render action: 'show', status: :created, location: @survey }
      else
        format.html { render action: 'new' }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    unless auth_privilege
      redirect_to surveys_url, notice: '권한이 없습니다.'
      return
    end

    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:title, :description)
    end

    def auth_privilege
      @survey.user == current_user
    end
end
