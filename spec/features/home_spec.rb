require 'rails_helper'

RSpec.feature 'Home page', type: :feature do
  context 'without sign in' do
    scenario 'visit home page' do
      visit(root_path)
      click_link 'Library.com'
      expect(find('h1')).to have_content('Welcome to Takshashila Library')
      expect(find('.btn-primary')).to have_content('Register')
      expect(find('.btn-info')).to have_content('Log in')
    end

    scenario 'visits about page' do
      visit home_about_path
      expect(page).to have_content 'Our History'
    end
  end

  describe 'signing up' do
    let(:user) { build(:random_user) }

    before(:each) do
      visit new_user_registration_path
      within('form') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
    end

    scenario 'should throw error' do
      click_button 'Sign up'
      expect(page).to have_content('Password confirmation doesn\'t match Password')
    end

    it 'does sign up successfully' do
      within('form') do
        fill_in 'Password confirmation', with: user.password
      end
      click_button 'Sign up'
      expect(find('.notice')).to have_content('Welcome! You have signed up successfully')
    end
  end
end
