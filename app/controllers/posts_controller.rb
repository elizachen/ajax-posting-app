class PostsController < ApplicationController
 before_action :authenticate_user!, :only => [:create, :destroy]

  def index
      # @posts = Post.order("id DESC").all    # 新贴文放前面
    @posts = Post.order("id DESC").limit(30)

    if params[:max_id]
      @posts = @posts.where( "id < ?", params[:max_id])
    end

    respond_to do |format|
      format.html  # 如果客户端要求 HTML，则回传 index.html.erb
      format.js    # 如果客户端要求 JavaScript，回传 index.js.erb
    end

  end

   def create
     @post = Post.new(post_params)
     @post.user = current_user
     @post.save

    #  redirect_to posts_path
   end

   def destroy
     @post = current_user.posts.find(params[:id]) # 只能删除自己的贴文
     @post.destroy

    #  redirect_to posts_path
    # render :js => "alert('ok');"
    render :json => { :id => @post.id }
   end

  def like
    @post = Post.find(params[:id])
    unless @post.find_like(current_user)  # 如果已经按讚过了，就略过不再新增
      Like.create( :user => current_user, :post => @post)
    end

    # redirect_to posts_path
  end

  def unlike
    @post = Post.find(params[:id])
    like = @post.find_like(current_user)
    like.destroy

    # redirect_to posts_path
    render "like"
  end

  def collect
    @post = Post.find(params[:id])
    unless @post.find_collection(current_user)  # 如果已经按讚过了，就略过不再新增
      Collection.create( :user => current_user, :post => @post)
    end

    # redirect_to posts_path
  end

  def uncollect
    @post = Post.find(params[:id])
    collect = @post.find_collection(current_user)
    collect.destroy

    # redirect_to posts_path
    render "collect"
  end



   protected

   def post_params
     params.require(:post).permit(:content)
    end

end
