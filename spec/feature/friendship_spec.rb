require 'rails_helper'
RSpec.configure do |c|
    c.use_transactional_examples = false
    c.order = 'defined'
  end

RSpec.feature 'Friendships' do

  scenario 'when logged in user sends a friend request to another user' do
    @user = User.create(name: 'user1', email: 'user1@gmail.com', password: '123456')
    @user = User.create(name: 'user2', email: 'user2@gmail.com', password: '123457')
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user1@gmail.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Invite'
    expect(page).to have_content 'Invitation sent'
  end
  scenario 'when logged in user rejects a friend request' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user2@gmail.com'
    fill_in 'user_password', with: '123457'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Reject'
    expect(page).to have_content 'Friend request rejected'
  end
  scenario 'when logged in user accepts a friend request' do
    @friend = Friendship.create(user_id: 1, friend_id: 2, confirmed: false)
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user2@gmail.com'
    fill_in 'user_password', with: '123457'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Accept'
    expect(page).to have_content 'Invitation accepted'
  end
end
