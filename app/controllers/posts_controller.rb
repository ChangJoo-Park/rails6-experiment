# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post_with_comments, only: [:show]
  before_action :set_post, only: %i[edit update destroy publish unpublish]
  before_action :authenticate_user!, except: %i[index show publish unpublish]

  # GET /posts
  # GET /posts.json
  def index
    @has_tag = params[:tag].present?
    if @has_tag
      @posts = Post.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 6)
      @title = "태그: #{params[:tag]}"
    else
      @posts = Post.feeds.paginate(page: params[:page], per_page: 6)
      @title = "글목록"
    end
    @tags = Tag.all.limit(10)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = Post.find(params[:id]).user
  end

  # GET /posts/new
  def new
    @post = Post.new(user: current_user)
    @post.tag_list = params[:tag] if params[:tag]
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def publish
    @post.published = true
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { redirect_to @post }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def unpublish
    @post.published = false
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { redirect_to @post }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post_with_comments
    # TODO: Move to model
    @post = Post.includes(comments: [user: [user_profile: :avatar_attachment]]).find(params[:id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :content, :published, :tag_list, :tag, { tag_ids: [] }, :tag_ids, :cover)
  end
end
