# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  User.destroy_all
  Poll.destroy_all
  Question.destroy_all
  AnswerChoice.destroy_all
  Response.destroy_all

  user1 = User.create!(username: 'andrew')
  user2 = User.create!(username: 'beth')
  user3 = User.create!(username: 'tommy')
  user4 = User.create!(username: 'nicole')

  poll1 = Poll.create!(title: 'Are there answers?', author: user4)
  poll2 = Poll.create!(title: 'Fantasy', author: user3)

  q1 = Question.create!(text: 'What is the best day for yesterday?', poll: poll1)
  q2 = Question.create!(text: 'What is the best sound?', poll: poll1)
  q3 = Question.create!(text: 'Are there enough chips?', poll: poll1)
  q4 = Question.create!(text: 'Is green fire bad?', poll: poll1)

  q5 = Question.create!(text: 'What\'s your favorite team?', poll: poll2)
  q6 = Question.create!(text: 'How many quarterbacks do you want?', poll: poll2)
  q7 = Question.create!(text: 'Fantasy football is most like...', poll: poll2)

  ac1 = AnswerChoice.create!(text: 'Monday', question: q1)
  ac2 = AnswerChoice.create!(text: 'Tomorrow never knows', question: q1)
  ac3 = AnswerChoice.create!(text: 'Today', question: q1)
  ac4 = AnswerChoice.create!(text: 'Saturday', question: q1)

  ac5 = AnswerChoice.create!(text: 'Chirp!', question: q2)
  ac6 = AnswerChoice.create!(text: 'Fire!', question: q2)
  ac7 = AnswerChoice.create!(text: 'Wooooosh!', question: q2)
  ac8 = AnswerChoice.create!(text: 'Snap!!', question: q2)

  ac9 = AnswerChoice.create!(text: 'Yes', question: q3)
  ac10 = AnswerChoice.create!(text: 'No', question: q3)
  ac11 = AnswerChoice.create!(text: 'Never', question: q3)

  ac12 = AnswerChoice.create!(text: 'No', question: q4)
  ac13 = AnswerChoice.create!(text: 'Not bad, but dangerous.', question: q4)
  ac14 = AnswerChoice.create!(text: 'Yes', question: q4)

  ac15 = AnswerChoice.create!(text: 'Steelers', question: q5)
  ac16 = AnswerChoice.create!(text: 'Falcons', question: q5)
  ac17 = AnswerChoice.create!(text: 'All teams', question: q5)

  ac18 = AnswerChoice.create!(text: '2', question: q6)
  ac19 = AnswerChoice.create!(text: '3', question: q6)
  ac20 = AnswerChoice.create!(text: '4', question: q6)

  ac21 = AnswerChoice.create!(text: 'Checkers', question: q7)
  ac22 = AnswerChoice.create!(text: 'Chess', question: q7)
  ac23 = AnswerChoice.create!(text: 'Tag', question: q7)

  r = Response.create!(respondent: user2, answer_choice: ac3)
  r = Response.create!(respondent: user2, answer_choice: ac5)
  r = Response.create!(respondent: user2, answer_choice: ac11)
  r = Response.create!(respondent: user2, answer_choice: ac13)
  r = Response.create!(respondent: user2, answer_choice: ac15)
  r = Response.create!(respondent: user2, answer_choice: ac18)
  r = Response.create!(respondent: user2, answer_choice: ac23)

  r = Response.create!(respondent: user1, answer_choice: ac4)
  r = Response.create!(respondent: user1, answer_choice: ac8)
  r = Response.create!(respondent: user1, answer_choice: ac9)
  r = Response.create!(respondent: user1, answer_choice: ac14)
  r = Response.create!(respondent: user1, answer_choice: ac15)
  r = Response.create!(respondent: user1, answer_choice: ac18)
  r = Response.create!(respondent: user1, answer_choice: ac22)

end