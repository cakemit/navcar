class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about_us blogs]

  def home
    @user = current_user
  end

  def about_us
  end

  def blogs
  end
end
