require 'rails_helper'

RSpec.feature 'Friendships' do
  before(:each) do
    @user = User.create(name: 'user4', email: 'user4@gmail.com', password: '123456')
  end
  before(:each) do
    @user = User.create(name: 'user5', email: 'user5@gmail.com', password: '123457')
  end
  scenario 'when logged in user rejects a friend request' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user4@gmail.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    click_on 'user4'
    click_on 'Reject'
    expect(page).to have_content 'Friend request rejected'
  end
  scenario 'when logged in user accepts a friend request' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user4@gmail.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    click_on 'user4'
    click_on 'Accept'
    expect(page).to have_content 'Invitation accepted'
  end
end
