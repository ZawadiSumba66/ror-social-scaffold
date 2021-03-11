class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])
    @friendship.confirmed = false
    if @friendship.save
      redirect_to users_path, notice: 'Invitation sent'
    else
      redirect_to users_path, alert: 'Invitation not sent'
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.confirmed = true
    @friendship.save
    @inverse_friendship = Friendship.new(user_id: current_user.id, friend_id: @friendship.user_id, confirmed: true)
    @inverse_friendship.save
    redirect_to users_path, notice: 'Invitation accepted'
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to users_path, notice: 'Friend request rejected'
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
