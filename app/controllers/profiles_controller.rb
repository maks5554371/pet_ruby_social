class ProfilesController < ApplicationController
  def index
  end

   def show
    # Если передан ID - показываем чужой профиль, иначе свой
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
      redirect_to new_user_session_path, alert: "Войдите чтобы посмотреть профиль" unless current_user
    end

    @posts = @user.posts.order(created_at: :desc)
    @is_own_profile = current_user == @user
  end

  def edit
  end

  def update
  end
end
