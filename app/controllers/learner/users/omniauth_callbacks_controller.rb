# frozen_string_literal: true

class Learner::Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

# SNSコールバック
  def google_oauth2
    callback_for(:google)
  end
  def facebook
    callback_for(:facebook)
  end

  def callback_for(provider)
    @omniauth = request.env['omniauth.auth']
    info = User.find_oauth(@omniauth)
    @user = info[:user]
    
  # 既存の場合
    if @user.persisted? 
      sign_in @user #@@@@@@@@@@@@@@@@@@@@@@
      if @user.language.blank?
        redirect_to learner_welcome_path
      else
        redirect_to learner_root_path
      end
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else 

# 初めて使用の場合
  # User保存
      register = User.create(name: @user.name,
                            email: @user.email,
                            password: Devise.friendly_token[0,20] )
  # SnsCredential保存
      sns = SnsCredential.new(provider: info[:sns].provider,
                              uid: info[:sns].uid,)
      sns.user_id = register.id
      sns.save
      sign_in register
      redirect_to learner_welcome_path #@@@@@@@@@@@@@@@@@@@@@@
    end
  end

  def failure
    redirect_to root_path and return
  end
end