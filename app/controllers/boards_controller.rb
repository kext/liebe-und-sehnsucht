class BoardsController < ApplicationController
  def index
    @boards = Board.all.order(:title)
      .eager_load(:last_post)
      .eager_load(:last_post => :user)
      .eager_load(:last_post => :topic)
    @stack = [title: I18n.t(:board_overview), url: root_path]
  end

  def show
    @board = Board.find(params[:id])
    @topics = Topic.where(board_id: @board.id)
      .order(:last_post_at => :desc)
      .eager_load(:last_post_user)
      .eager_load(:first_post_user)
    @stack = [title: @board.title, url: board_path(@board.id, format: 'html')]
  end
end
