# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :authored_polls,
  class_name: :Poll,
  foreign_key: :user_id,
  primary_key: :id

  has_many :responses,
  class_name: :Response,
  foreign_key: :user_id,
  primary_key: :id

  def completed_polls
    self.class.find_by_sql(<<-SQL).pluck(:title)
      SELECT polls.title
      FROM polls
      INNER JOIN questions ON questions.poll_id = polls.id
      LEFT OUTER JOIN answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN responses
        ON answer_choices.id = responses.answer_choice_id
        AND responses.user_id = #{id}
      GROUP BY polls.id
      HAVING COUNT(DISTINCT questions.id) = COUNT(DISTINCT responses.id);
    SQL
  end

  def uncompleted_polls
    self.class.find_by_sql(<<-SQL).pluck(:title)
      SELECT polls.title
      FROM polls
      INNER JOIN questions ON questions.poll_id = polls.id
      LEFT OUTER JOIN answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN responses
        ON answer_choices.id = responses.answer_choice_id
        AND responses.user_id = #{id}
      GROUP BY polls.id
      HAVING COUNT(DISTINCT questions.id) <> COUNT(DISTINCT responses.id);
    SQL
  end


end
