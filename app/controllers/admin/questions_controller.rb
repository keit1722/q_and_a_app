class Admin::QuestionsController < Admin::BaseController
  def index
    @q = Question.ransack(params[:q])
    ordered = @q.result(distinct: true).order(created_at: :desc)
    @questions =
      if params[:solved] == 'true'
        ordered.where(solved: true).page(params[:page]).per(5)
      elsif params[:solved] == 'false'
        ordered.where(solved: false).page(params[:page]).per(5)
      else
        ordered.page(params[:page]).per(5)
      end
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy!
    redirect_to admin_questions_url,
                notice: "質問「#{question.title}」を削除しました。"
  end
end
