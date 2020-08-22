# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Response < ApplicationRecord
  validate :not_duplicate_response, unless: -> { answer_choice.nil? }
  validate :no_author_response, unless: -> { answer_choice.nil? }

  after_destroy :log_destroy_action

  belongs_to :respondent,
  class_name: :User,
  foreign_key: :user_id,
  primary_key: :id

  belongs_to :answer_choice,
  class_name: :AnswerChoice,
  foreign_key: :answer_choice_id,
  primary_key: :id

  has_one :question,
  through: :answer_choice,
  source: :question

  has_one :poll,
  through: :question,
  source: :poll

  def log_destroy_action
    puts "#{self} destroyed."
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:base] << 'User has already answered this question.'
    end
  end

  def no_author_response
    # also one query
    if poll.user_id == user_id
      errors[:base] << 'No author response 1: Author cannot respond to their own poll.'
    end
  end

  def no_author_response2
    # one query
    author_id = Poll
      .joins(:questions)
      .joins('INNER JOIN answer_choices ON answer_choices.question_id = questions.id')
      .find_by(answer_choices: { id: answer_choice_id })
      .user_id
    if author_id == user_id
      errors[:base] << 'No author response 2: Author cannot respond to their own poll.'
    end
  end

  def sibling_responses
    question.responses.where.not(id: id)
  end

  def respondent_already_answered?
    sibling_responses.pluck(:user_id).include?(user_id)
  end
end
