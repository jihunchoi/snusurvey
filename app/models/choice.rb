class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :answers
  has_one :next_question, class_name: 'Question', foreign_key: 'parent_choice_id'
end
