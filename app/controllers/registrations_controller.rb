class RegistrationsController < Devise::RegistrationsController
    respond_to :json
    private
    def respond_with(resource, _opts = {})
      return success if resource.save  
      failure
    end
    def success
      render json: "User Successfully Created", status: :created
    end
    def failure
      render json: {errors: resource.errors}, status: :unprocessable_entity
    end
end
