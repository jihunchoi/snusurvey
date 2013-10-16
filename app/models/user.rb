class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  # student_type: 1 (undergraduate)
  #               2 (master's course)
  #               3 (doctoral course)
  #               9 (exchange student)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :surveys
  has_many :reports

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
