class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
        user = User.from_omniauth(request.env["omniauth.auth"])
        if user.persisted?
            render json: "Nice it rendered", status: :ok
        else
            render json: { error: "Error" }, status: :unprocessable_entity
        end
    end

end
