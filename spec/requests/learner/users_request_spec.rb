require 'rails_helper'

RSpec.describe "Learner::Users", type: :request do

  describe "GET /top" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/learner/users/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/learner/users/edit"
      expect(response).to have_http_status(:success)
    end
  end

end

new_learner_user_session GET      /learner/users/sign_in(.:format)                                                         learner/users/sessions#new
learner_user_facebook_omniauth_authorize GET|POST /learner/users/auth/facebook(.:format)                                                   learner/users/omniauth_callbacks#passthru
 learner_user_facebook_omniauth_callback GET|POST /learner/users/auth/facebook/callback(.:format)                                          learner/users/omniauth_callbacks#facebook
learner_user_google_oauth2_omniauth_authorize GET|POST /learner/users/auth/google_oauth2(.:format)                                              learner/users/omniauth_callbacks#passthru
learner_user_google_oauth2_omniauth_callback GET|POST /learner/users/auth/google_oauth2/callback(.:format)                                     learner/users/omniauth_callbacks#google_oauth2
               new_learner_user_password GET      /learner/users/password/new(.:format)                                                    learner/users/passwords#new
              edit_learner_user_password GET      /learner/users/password/edit(.:format)                                                   learner/users/passwords#edit
        cancel_learner_user_registration GET      /learner/users/cancel(.:format)                                                          learner/users/registrations#cancel
           new_learner_user_registration GET      /learner/users/sign_up(.:format)                                                         learner/users/registrations#new
          edit_learner_user_registration GET      /learner/users/edit(.:format)                                                            learner/users/registrations#edit
                         learner_welcome GET      /learner/users/welcome(.:format)                                                         learner/users#welcome
                       edit_learner_user GET      /learner/users/:id/edit(.:format)                                                        learner/users#edit
                            learner_user GET      /learner/users/:id(.:format)                                                             learner/users#show