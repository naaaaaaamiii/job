class RelationshipsController < ApplicationController
   def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    #redirect_to request.referer #非同期通信化のためコメントアウト
   end
   
   def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
    #redirect_to request.referer #非同期通信化のためコメントアウト
   end
end
