class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about_us blogs]

  def home
  end

  def about_us
  end

  def blogs
  end
end
