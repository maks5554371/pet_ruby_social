# frozen_string_literal: true

class PostCardComponent < ViewComponent::Base
  def initialize(post:, current_user:)
    @post = post
    @current_user = current_user
  end

  def user_liked?
    return false unless @current_user

    @post.liked_by?(@current_user)
  end

  def post_like_path
  Rails.application.routes.url_helpers.post_like_path(@post)
end


def post_like_method
  user_liked? ? :delete : :post
end
  def like_button_class
    if user_liked?
       "text-red-500 cursor-pointer"
    else
      "text-gray-500  cursor-pointer"
    end
  end

  def user_commented?
    return false unless @current_user

    @post.comments.exists?(user_id: @current_user.id)
  end
  def post_comment_method
  user_commented? ? :delete : :post
end
end

