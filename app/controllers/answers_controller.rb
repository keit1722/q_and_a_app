class AnswersController < BaseController
  def create
    @question = Question.find(params[:question_id])
    @answer =
      current_user.answers.build(answer_params.merge(question_id: @question.id))

    if @answer.save
      UserMailer.send_answerd_email(@question, @answer).deliver_now
      redirect_to question_url(@question), notice: '回答を登録しました。'
    else
      render 'questions/show'
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:content)
    end
end
