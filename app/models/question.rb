class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :choices
  self.inheritance_column = nil
end
