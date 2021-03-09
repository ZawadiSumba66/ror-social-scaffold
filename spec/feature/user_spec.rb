require 'rails_helper'

RSpec.feature 'Users' do
    before(:each) do
      @user = User.create(name: 'user4', email: 'user4@gmail.com', password: '123456')
    end
    scenario 'when a user signs in' do
      visit '/users/sign_in'
      fill_in 'user_email', with: 'user4@gmail.com'
      fill_in 'user_password', with: '123456'
      click_on 'Log in'
      expect(page).to have_content 'Signed in successfully'
    end
    scenario 'when a user logs out' do
      visit '/users/sign_in'
      fill_in 'user_email', with: 'user4@gmail.com'
      fill_in 'user_password', with: '123456'
      click_on 'Log in'
      click_on 'Sign out'
      expect(current_path).to eql('/users/sign_in')
    end
  end
  