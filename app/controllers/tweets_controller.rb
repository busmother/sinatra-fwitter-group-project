class TweetsController < ApplicationController

    get '/tweets' do
        if Helpers.is_logged_in?(session)
            @tweets = Tweet.all
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            # binding.pry
            if params[:content].empty?
                redirect 'tweets/new'
            else 
                new_tweet = Tweet.create(content: params[:content],user_id: @user.id)
            end
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @tweet = Tweet.find_by(params[:id])
            # binding.pry
            erb :'tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @tweet = Tweet.find_by(params[:id])
            erb :'tweets/edit_tweet'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @tweet = Tweet.find_by(params[:id])
            @tweet.content = params[:content]
            @tweet.save
            erb :'tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @tweet = Tweet.find_by(params[:id])
            @tweet.delete
        else
            redirect '/login'
        end
    end


end
