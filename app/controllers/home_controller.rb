class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end
end

