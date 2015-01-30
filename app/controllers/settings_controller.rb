class SettingsController < ApplicationController
  before_action :change_settings

  def settings
    @stack = [title: I18n.t(:settings), url: settings_path]
  end

  def change_settings
    if request.post?
      if params[:do] == 'change_password'
        change_password
      end
    end
  end

  def change_password
    if @user && @user.authenticate(params[:old_password])
      begin
        @user.password = params[:password]
        @user.password_confirmation = params[:password_confirmation]
        @user.save!
        @infos << t(:password_changed)
      rescue
        @errors << t(:generic_error)
      end
    else
      @errors << t(:generic_error)
    end
  end
end
