class TweetsController < ApplicationController

    get '/tweets' do
        if Helpers.is_logged_in?(session)
            @tweets = Tweet.all
            # @user = Helpers.current_user
            erb :'tweets/tweets'
        else
            erb :'users/login'
        end
    end

end
