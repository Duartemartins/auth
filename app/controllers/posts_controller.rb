class PostsController < ApplicationController
delegate :email, to: :user
  before_action :authorize, only: [:new, :create]

	def index
		@posts = Post.all
	end

	def show
    @post = Post.find(params[:id])
  end

	def new
		@post = Post.new
	end
  def edit
    @post = Post.find(params[:id])
  end

	def update
  @post = Post.find(params[:id])
  if @post.update(post_params)
   flash[:notice] = "Post was updated"
   redirect_to post_path(@post)
  else
   flash[:notice] = "Post was not updated"
   render 'edit'
  end
end

	def destroy
	end

# 	def create

# @post = Post.new(post_params)

# @post.save
# redirect_to @post
#   end
def create
    # Look up User in db by the email address submitted to the login form and
    # convert to lowercase to match email in db in case they had caps lock on:
      @post = Post.new(post_params)
      if current_user
        @post.user_id = current_user.id
      end
    # Verify user exists in db and run has_secure_password's .authenticate() 
    # method to see if the password submitted on the login form was correct: 
    if @post.save
      # Save the user.id in that user's session cookie:
      redirect_to root_path, notice: 'Saved'
    else
      # if email or password incorrect, re-render login page:
      flash.now.alert = "Please try again."
      render :new
    end
  end

  private
    def post_params
      params.require(:post).permit(:title,:body)
    end
end
