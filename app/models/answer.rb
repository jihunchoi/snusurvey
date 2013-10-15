class Answer < ActiveRecord::Base
  belongs_to :report
  belongs_to :question
  belongs_to :choice
  self.inheritance_column = nil
end
