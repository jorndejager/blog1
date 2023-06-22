class BlogPostsController < ApplicationController
    before_action :authenticate_user!, except:[:index, :show, :like, :unlike, :debug ]
    before_action :set_blog_post, except: [:index, :new, :create, :debug]


    def like
    @blog_post = BlogPost.find(params[:id])

    if session[:liked_blog_posts]&.include?(@blog_post.id)
      flash[:alert] = 'You have already liked this blog post.'
    else
      @blog_post.increment!(:likes)
      session[:liked_blog_posts] ||= []
      session[:liked_blog_posts] << @blog_post.id

      flash[:notice] = 'Blog post liked.'
    end

    redirect_to @blog_post
  end

  def unlike
    @blog_post = BlogPost.find(params[:id])

    if session[:liked_blog_posts]&.include?(@blog_post.id)
      @blog_post.decrement!(:likes)
      session[:liked_blog_posts].delete(@blog_post.id)

      flash[:notice] = 'Blog post unliked.'
    else
      flash[:alert] = 'You have not liked this blog post.'
    end

    redirect_to @blog_post
  end


    #def like
     #   @blog_post.increment!(:likes)
      #  redirect_to @blog_post
   # end

   # def unlike
    #    @blog_post.decrement!(:likes)
     #   redirect_to @blog_post
    #end



    def index
        @blog_posts = BlogPost.all
    end

    def show
    end

    def new
        @blog_post= BlogPost.new
    end

    def create
        @blog_post = BlogPost.new(blog_post_params)
        if @blog_post.save
            redirect_to @blog_post
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end


    def update
        if @blog_post.update(blog_post_params)
            redirect_to @blog_post
        else
            render :edit, status: :unprocessable_entity

        end
    end


def destroy
    @blog_post.destroy
    redirect_to root_path
end


    private


    def blog_post_params
        params.require( :blog_post).permit(:title, :body)
    end

    def set_blog_post
        @blog_post = BlogPost.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end

    #def authenticate_user!
     #   redirect_to new_user_session_path, alert: "you must be signed in to continue." unless user_signed_in?
    #end

end
