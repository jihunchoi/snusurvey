class Report < ActiveRecord::Base
  belongs_to :survey
  belongs_to :user
  has_many :question_radios
  has_many :question_checkboxes
  has_many :question_subjectives
end
