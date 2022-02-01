class SessionsController < Devise::SessionsController
    respond_to :json
    private
  def respond_with(resource, _opts = {})
      success
    end
  def respond_to_on_destroy
      head :ok
  end
  def success
    render json: {message: "Success", user: current_user}, status: :ok
  end
  
end
