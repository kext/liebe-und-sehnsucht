class UsersController < ApplicationController
  skip_before_action :check_user, only: [:login, :register]

  before_action :check_login, only: [:login]

  def login
    @stack = [title: I18n.t(:login), url: login_path(format: 'html')]
  end

  def check_login
    if session[:user_id]
      redirect_to root_path
    elsif request.post?
      u = User.where(name: params[:name]).first
      if u && u.authenticate(params[:password])
        reset_session
        session[:user_id] = u.id
        redirect_to root_path
      else
        @errors << t(:login_failed)
      end
    end
  end

  def logout
    reset_session
    redirect_to login_path
  end

  before_action :check_register, only: [:register]

  def register
    @stack = [title: I18n.t(:register), url: register_path(format: 'html')]
  end

  def check_register
    if session[:user_id]
      redirect_to root_path
    elsif request.post?
      u = User.new
      u.name = params[:name]
      u.email = params[:email]
      u.password = params[:password]
      u.password_confirmation = params[:password_confirmation]
      begin
        u.save!
        reset_session
        session[:user_id] = u.id
        redirect_to root_path
      rescue
        @errors << t(:registration_failed)
      end
    end
  end

  def show
    @show_user = User.find(params[:id])
    @stack = [title: @show_user.name, url: user_path(@show_user.id, format: 'html')]
  end
end
