class TweetsController < ApplicationController
    def index
      @tweets = Tweet.all.order(created_at: :desc)
      render 'tweets/index' 
    end

    def index_by_user
      user = User.find_by(username: params[:username])
      @tweets = user.tweets.all
      if @tweets
        render 'tweets/index'
      else
          render json: { tweets: [] }
      end
    end

    def create
        token = cookies.signed[:twitter_session_token]
        session = Session.find_by(token: token)
    
        if session
          user = session.user
          @tweet = user.tweets.new(tweet_params)
    
          if @tweet.save
            render json: {
                tweet: {
                    username: @tweet.user.username,
                    message: @tweet.message
                }
            }
          else
            render json: { success: false }
          end
        else
          render json: { success: false }
        end
    end

    def destroy
      token = cookies.signed[:twitter_session_token]
      session = Session.find_by(token: token)
    
      if session
        @tweet = Tweet.find_by(id: params[:id])
    
        if @tweet and @tweet.destroy
          render json: { success: true }
        else
          render json: { success: false }
        end
      else
          render json: { success: false }
      end
        
    end

    private

      def tweet_params
        params.require(:tweet).permit(:message, :username)
      end
end
