require 'pry'

class UsersController < ApplicationController

    get '/' do
        erb :index, :create_user => :'tweets/tweets'
    end

    get '/signup' do
        if Helpers.is_logged_in?(session)
            redirect '/tweets'
        else
        erb :'/users/create_user'
        end
    end

    post '/signup' do
        # binding.pry
        if Helpers.is_logged_in?(session)
            redirect '/tweets'
        else
            @user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
            if @user.username !="" && @user.username !=nil && @user.password !="" && @user.password != nil && @user.email !="" && @user.email != nil
                #theres another way to write ^this using params.has_value?
                @user.save #save the user to create a primary key / id
                session[:user_id] = @user.id #now that we have access to the id, we can assign it to the session hash
                redirect "/tweets"
             else
               redirect "/signup"
             end
            erb :'/tweets/tweets'
        end
    end

    get '/login' do
        if Helpers.is_logged_in?(session)
            redirect to '/tweets'
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        # binding.pry
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticater(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect '/login'
        end
    end

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
            redirect to '/login'
        else
            redirect to '/'
        end
        redirect to '/login'
    end


end
