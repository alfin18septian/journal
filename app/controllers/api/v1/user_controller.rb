class Api::V1::UserController < ApplicationController
    include ActionController::HttpAuthentication::Token

    before_action :authenticate_user
    before_action :set_user, only: [ :show, :update, :destroy ]
    rescue_from ActiveRecord::RecordNotFound, with: :notFound
    
    def index
        @users = User.all
        render json: {
            result: true, 
            users: @users.map do |user|
                {
                    id: user.id,
                    full_name: "#{user.first_name} #{user.last_name}",
                    username: user.username,
                    email: user.email,
                    phone: user.phone,
                    role: role_name(user),
                }
            end
        }, status: :ok
    end
    
    def show
        render json: { 
            result: true, 
            user: {
                id: @user.id,
                full_name: "#{@user.first_name} #{@user.last_name}",
                username: @user.username,
                email: @user.email,
                phone: @user.phone,
                role: role_name(@user),
            }
        }, status: :ok
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render json: { 
                result: true,
                massage: "success", 
                value: {
                    id: @user.id,
                    full_name: "#{@user.first_name} #{@user.last_name}",
                    username: @user.username,
                    email: @user.email,
                    phone: @user.phone,
                    role: role_name(@user),
                } 
            }, status: :ok
        else
            render json: { result: false, massage: @user.errors }, status: :unprocessable_entity
        end
    end

    def update
        if @user.update(user_params)
            render json: { 
                result: true, 
                message: "Update Success", 
                value: {
                    id: @user.id,
                    full_name: "#{@user.first_name} #{@user.last_name}",
                    username: @user.username,
                    email: @user.email,
                    phone: @user.phone,
                    role: role_name(@user),
                }
            }, status: :ok
        else 
            render json: { result: false, message: @user.errors}
        end
    end
    
    def destroy
        if @user.destroy
            render json: { result: true, message: "Delete Success" }, status: :ok
        else
            render json: { result: false, message: @user.errors }
        end
    end
    
    private
    
    def authenticate_user
        token, _option = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        User.find(user_id)
        rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
            render json: {result: false, message: e}, status: :unauthorized
    end
    
    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.permit(:first_name, :last_name, :username, :phone, :email, :role, :password, :password_confirmation)
    end

    def notFound
        render json: {
            result: false,
            message: "Data Not Found"
        }, status: :not_found
    end

    def role_name(user)
        (user.role == "1") ? 'Administrator' : (user.role == "1") ? 'Contributor' : 'Public'
    end
end
