class Admin::BaseController < ApplicationController
  before_action :check_admin

  private

    def check_admin
      unless current_user&.admin?
        redirect_to questions_url, notice: '権限がありません'
      end
    end
end
