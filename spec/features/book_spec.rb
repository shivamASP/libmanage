require 'rails_helper'

RSpec.feature 'book CRUD', type: :feature do
  context '/books/index page' do
    let(:book) { create(:sequenced_book) }
    let(:admin_user) { create(:random_user, :admin) }
    let(:user) { build(:random_user)}

    before(:each) do
      visit new_user_session_path
      within('form') do
        fill_in 'Email', with: admin_user.email
        fill_in 'Password', with: admin_user.password
        click_button 'Log in'
      end
      click_link 'Add New Book'
      within('form') do
        fill_in 'Title', with: book.title
        fill_in 'Author', with: book.author
        fill_in 'Published in', with: book.published_in
        fill_in 'Volume', with: book.volume
        click_button 'Submit'
      end
    end

    scenario 'view book' do
      find_link('Sign out').click
      expect(find('.notice')).to have_text 'Signed out successfull'
      visit new_user_registration_path
      expect(page).to have_current_path '/users/sign_up'
      within('form') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password confirmation', with: user.password
        click_button 'Sign up'
      end
      expect(page).to have_current_path '/books'
      find_link('View Book', match: :first).click
      expect(page).to have_current_path("/books/#{book.id}")
      expect(find('h1')).to have_content('book1')
    end

    scenario 'added new book?' do
      expect(find('.notice')).to have_content 'Book was successfully created'
      expect(page).to have_text book.title.to_s
    end

    scenario 'edit book' do
      visit edit_book_path(book.id)
      expect(page).to have_current_path "/books/#{book.id}/edit"
      within('form') do
        fill_in 'Volume', with: 2
      end
      click_button 'Submit'
      expect(find('.notice')).to have_text 'Book was successfully updated.'
    end

    scenario 'issue and return book' do
      find_link('Sign out').click
      expect(find('.notice')).to have_text 'Signed out successfull'
      visit new_user_registration_path
      expect(page).to have_current_path '/users/sign_up'
      within('form') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password confirmation', with: user.password
        click_button 'Sign up'
      end
      expect(page).to have_current_path '/books'
      expect(find('.notice')).to have_text 'Welcome! You have signed up successfully'
      within('table') do
        click_on 'Issue', exact: true, match: :first
      end
      expect(find('.notice')).to have_text 'Book has been issued'
      within('table') do
        click_on 'Return', exact: true, match: :first
      end
      expect(find('.notice')).to have_text 'Book returned'
    end
  end
end
