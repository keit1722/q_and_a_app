class UsersController < BaseController
  skip_before_action :login_required, only: %i[new create]
  before_action :correct_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render 'new'
    end
  end

  def edit; end

  def show
    @user = User.find(params[:id])
  end

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(5)
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  private

    def user_params
      params
        .require(:user)
        .permit(:name, :email, :password, :password_confirmation, :admin, :image)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to users_url unless @user == current_user
    end
end
