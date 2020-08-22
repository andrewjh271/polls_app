# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :text             not null
#  poll_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  validates :text, presence: true

  belongs_to :poll,
  class_name: :Poll,
  foreign_key: :poll_id,
  primary_key: :id

  has_many :answer_choices,
  class_name: :AnswerChoice,
  foreign_key: :question_id,
  primary_key: :id,
  dependent: :destroy

  has_many :responses,
  through: :answer_choices,
  source: :responses

  def results_n_plus_one
    result_hash = {}
    answer_choices.each do |ans|
      result_hash[ans.text] = ans.responses.count
    end
    result_hash
  end

  def results_includes
    result_hash = {}
    answers = answer_choices.includes(:responses)
    answers.each do |ans|
      result_hash[ans.text] = ans.responses.length
    end
    result_hash
  end

  def results_sql
    result_hash = {}
    self.class.find_by_sql(<<-SQL).map { |ans| result_hash[ans.answer] = ans.num_responses }
      SELECT
        answer_choices.text AS answer,
        COUNT(responses.id) AS num_responses
      FROM answer_choices
      LEFT JOIN responses ON answer_choices.id = responses.answer_choice_id
      WHERE answer_choices.question_id = #{id}
      GROUP BY answer_choices.id;
    SQL
    result_hash
  end

  def results
    answer_choices
      .select('text, COUNT(responses.id) AS num')
      .left_outer_joins(:responses)
      .group(:id)
      .each_with_object({}) { |ans, hash| hash[ans.text] = ans.num }
  end
end
