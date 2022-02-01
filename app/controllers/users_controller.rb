class UsersController < ApplicationController


    def create
        user = User.create(permit_params)
        if user.valid?
          session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

    def show
        user = User.find_by(id: params[:id])
        if user&.authenticate(params[:password])
          render json: user
        else
          render json: {error: "Wrong username/password"}, status: :unauthorized
        end
    end

    private
    
    def permit_params
        params.permit(:username, :password, :id)
    end
end
