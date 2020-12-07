class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about_us blogs]
  before_action :set_user

  def home
    @user = current_user
  end

  def about_us
  end

  def blogs
  end

  private

  def set_user
    @user = current_user
  end
end
