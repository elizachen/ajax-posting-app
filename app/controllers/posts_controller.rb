class PostsController < ApplicationController
  def index
      @posts = Post.order("id DESC").all    # 新贴文放前面
  end
end
