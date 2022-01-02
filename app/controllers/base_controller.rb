class BaseController < ApplicationController
  before_action :check_regular_user

  private

    def check_regular_user
      if current_user&.admin?
        redirect_to admin_questions_url, notice: '権限がありません'
      end
    end
end
