class Admin::SessionsController < Admin::BaseController
  skip_before_action :login_required
  skip_before_action :check_admin

  def new; end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password]) && user.admin
      session[:user_id] = user.id
      redirect_to admin_questions_url, notice: 'ログインしました。'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to admin_login_url, notice: 'ログアウトしました。'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :admin)
  end
end
