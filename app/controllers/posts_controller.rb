class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]


  # GET /posts
  # GET /posts.json
  def index
      @posts = Post.all.page(params[:page])
      verge_response = HTTParty.get("https://newsapi.org/v1/articles?source=the-verge&sortBy=latest&apiKey=#{ENV['news_api_key']}")
      techradar_response = HTTParty.get("https://newsapi.org/v1/articles?source=techradar&sortBy=latest&apiKey=#{ENV['news_api_key']}")

      @verge_articles = verge_response['articles']
      @techradar_articles = techradar_response['articles']
  end


  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create

    @post = Post.new(post_params)

    if current_user.admin?
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to @post, notice: 'You are not authorized to create a post.'
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if current_user.admin?
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to @post, notice: 'You are not authorized to edit a post.'
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if current_user.admin?
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
    else
      redirect_to @post, notice: 'You are not authorized to delete a post.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :blog_entry, :user_id, :comment_id)
    end
end
