class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource) #サインイン後の画面遷移先
  end
  
  def after_sign_out_path_for(resource) #サインアウト後の画面遷移
  end
  
end
