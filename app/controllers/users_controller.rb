#!/bin/env ruby
# encoding: utf-8
class UsersController < ApplicationController
  before_action :authenticate_user!, :auth_needed?

  def auth_new
  end

  def auth
    memberkey_digest = params[:memberkey_digest]
    college = params[:college]
    department = params[:department]
    student_type = params[:student_type]
    auth_token = params[:auth_token]
    auth_token_to_validate = Digest::SHA256.hexdigest(college + department + memberkey_digest + student_type + ENV['MYSNU_AUTH_SALT'])

    unless auth_token == auth_token_to_validate
      redirect_to auth_new_path, alert: "인증 오류: 비정상적인 접근이 의심됩니다."
      return
    end

    if User.find_by(memberkey_digest: memberkey_digest)
      redirect_to auth_new_path, alert: "인증 오류: 이미 인증된 마이스누 계정입니다."
      return
    end

    current_user.update_columns(
      {
        college: college,
        department: department,
        memberkey_digest: memberkey_digest,
        student_type: student_type,
        confirmed: true,
        confirmed_at: Time.now
      }
    )
    redirect_to surveys_path, notice: "인증되었습니다."
  end

  private
    def auth_needed?
      if current_user.confirmed?
        redirect_to surveys_path, notice: "이미 인증되었습니다."
        return
      end
    end
end
