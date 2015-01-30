class TopicsController < ApplicationController
  @@posts_per_page = 3

  before_action :answer, only: [:show, :lastpage]

  def show
    params[:page] ||= 1
    @num_pages = (Post.where(topic_id: @topic.id).count + @@posts_per_page - 1) / @@posts_per_page
    if params[:page] == :last
      @page = @num_pages
    else
      @page = params[:page].to_i
      @page = 1 if @page < 1
    end
    @page = @num_pages if @page > @num_pages
    @posts = Post.where(topic_id: @topic.id).order(:created_at).limit(@@posts_per_page).offset((@page - 1) * @@posts_per_page).eager_load(:user)
    @stack = [
      {title: @topic.board.title, url: board_path(@topic.board.id, format: 'html')},
      {title: @topic.title, url: topic_path(@topic.id, format: 'html')}
    ]
  end

  def answer
    @topic = Topic.find(params[:id])
    if request.post? && @user
      begin
        Post.create! content: params[:content], user_id: @user.id, topic_id: @topic.id
        redirect_to topic_lastpage_path(@topic.id, format: 'html')
      rescue
        @errors << t(:generic_error)
      end
    end
  end

  def lastpage
    params[:page] = :last
    show
    render 'show'
  end

  before_action :check_create, only: [:create]

  def create
    @stack = [
      {title: @board.title, url: board_path(@board.id, format: 'html')},
      {title: I18n.t(:new_topic), url: new_topic_path(@board.id, format: 'html')}
    ]
  end

  def check_create
    @board = Board.find(params[:id])
    if request.post? && @user
      Topic.transaction do
        begin
          @errors << 'begin'
          topic = Topic.create! title: params[:title], board_id: @board.id
          @errors << topic.inspect
          post = Post.create! content: params[:content], user_id: @user.id, topic_id: topic.id
          @errors << post.inspect
          redirect_to topic_path(topic.id, format: 'html')
        rescue Exception => e
          @errors << t(:generic_error) << e.inspect
          raise ActiveRecord::Rollback
        end
      end
    end
  end
end
