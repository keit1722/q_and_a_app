class QuestionsController < BaseController
  def index
    @q = Question.ransack(params[:q])
    if params[:solved] == 'true'
      @q.solved_eq = true
    elsif params[:solved] == 'false'
      @q.solved_eq = false
    end

    @questions =
      @q
        .result(distinct: true)
        .order(created_at: :desc)
        .page(params[:page])
        .per(5)

    @users = User.includes(:questions)
    render 'admin/questions/index'
  end

  def show
    @question = Question.find(params[:id])
    @user = @question.user
    @answer = @user.answers.build
  end

  def new
    @question = Question.new
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])

    if @question.update(question_params)
      redirect_to questions_url,
                  notice: "質問「#{@question.title}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    question = current_user.questions.find(params[:id])
    question.destroy!
    redirect_to questions_url,
                notice: "質問「#{question.title}」を削除しました。"
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      UserMailer.send_questioned_email(@question).deliver_now
      redirect_to @question,
                  notice: "質問「#{@question.title}」を登録しました。"
    else
      render :new
    end
  end

  private

    def question_params
      params.require(:question).permit(:title, :content, :solved)
    end
end
