class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :choices
  has_many :answers
  self.inheritance_column = nil
end
