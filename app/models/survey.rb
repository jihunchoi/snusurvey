class Survey < ActiveRecord::Base
  has_many :questions
  has_many :reports
  belongs_to :user
end
