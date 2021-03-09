require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe 'User', type: :model do
  it 'is valid with a name,email and password' do
    user = User.new(name: 'Rose', email: 'rosesumba2@gmail.com', password: 'sertot')
    expect(user).to be_valid
  end
  it 'is invalid with a password of less than 6 characters' do
    user = User.create(name: 'Rose', email: 'rose3@gmail.com', password: 'serto')
    expect(user).not_to be_valid
  end
  it 'is invalid if an email has already been taken' do
    user = User.create(name: 'Tim', email: 'rose3@gmail.com', password: 'sertoi')
    expect(user).not_to be_valid
  end
  describe 'associations' do
    it 'can have many friendships' do
      user = User.reflect_on_association(:friendships)
      expect(user.macro).to eql(:has_many)
    end
    it 'can have many friendships' do
      user = User.reflect_on_association(:inverse_friendships)
      expect(user.macro).to eql(:has_many)
    end
  end
end

RSpec.feature 'Users' do
  before(:each) do
    @user = User.create(name: 'user4', email: 'user4@gmail.com', password: '123456')
  end
  scenario 'when a user signs up' do
    visit '/users/sign_up'
    fill_in 'user_name', with: '4'
    fill_in 'user_email', with: '4@gmail.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
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