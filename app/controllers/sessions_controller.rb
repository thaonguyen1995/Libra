class SessionsController < Devise::SessionsController
  def create
    @user ||= User.find_by email: params[:user][:email]
    if @user&.valid_password? params[:user][:password]
      sign_in @user
      session[:user_id] = @user.id
      token = cookies[:_reactjs_rails7_session]

      return render json: { ok: true, msg: 'Login success', token: }, status: 200
    end
    render json: { ok: false, msg: 'Unauthorized user' }, status: 401
  end
end
