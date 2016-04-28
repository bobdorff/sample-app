class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(emal: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # log em in
    else
      flash[:danger] = 'Incorrect email or password. Please try again.'
      render 'new'
    end
  end

  def destroy
  end
end
