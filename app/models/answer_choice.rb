# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint           not null, primary key
#  text        :text             not null
#  question_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class AnswerChoice < ApplicationRecord
  validates :text, presence: true
  after_destroy :log_destroy_action

  belongs_to :question,
  class_name: :Question,
  foreign_key: :question_id,
  primary_key: :id

  has_many :responses,
  class_name: :Response,
  foreign_key: :answer_choice_id,
  primary_key: :id,
  dependent: :destroy

  def log_destroy_action
    puts 'Answer choice destroyed'
  end
end
