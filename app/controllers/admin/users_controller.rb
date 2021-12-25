class Admin::UsersController < Admin::BaseController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(5)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    redirect_to admin_users_url, notice: "質問「#{user.name}」を削除しました。"
  end
end
