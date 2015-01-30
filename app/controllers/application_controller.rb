class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_user

  def initialize
    super
    @errors = []
    @infos = []
  end

  def check_user
    @user = session[:user_id] && User.find(session[:user_id])
    redirect_to login_path(format: 'html') unless @user
  end
end
