class Report < ActiveRecord::Base
  belongs_to :survey
  belongs_to :user
  has_many :answers
end
