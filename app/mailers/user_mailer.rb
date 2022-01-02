class UserMailer < ApplicationMailer
  def questioned_email(user, question)
    @question = question
    @user = user
    mail(
      from: 'q.and.a.app@exmaple.com',
      to: @user.email,
      subject: '質問が投稿されました',
    )
  end

  def answered_email(user, question, answer)
    @question = question
    @user = user
    @answer = answer
    mail(
      from: 'q.and.a.app@exmaple.com',
      to: @user.email,
      subject: '質問に対する回答が投稿されました',
    )
  end

  def send_questioned_email(question)
    @users = User.all
    @users.each do |user|
      next if user.id == question.user_id
      UserMailer.questioned_email(user, question).deliver_now
    end
  end

  def send_answerd_email(question, answer)
    @users = User.all
    @users.each do |user|
      next if user.id == answer.user_id
      UserMailer.answered_email(user, question, answer).deliver_now
    end
  end
end
