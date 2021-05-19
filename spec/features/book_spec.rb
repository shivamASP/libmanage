require 'rails_helper'

RSpec.feature 'book features', type: :feature do
  context '/books/index page' do
    let(:book) { build(:sequenced_book) }
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
        stub_api_call(book.title, true)
        fill_in 'Title', with: book.title
        fill_in 'Author', with: book.author
        fill_in 'Published in', with: book.published_in
        fill_in 'Volume', with: book.volume
        click_button 'Submit'
      end
    end

    scenario 'added new book?' do
      book = Book.last
      expect(find('.notice')).to have_content 'Book was successfully created'
      expect(find('h1')).to have_text book.title.to_s
    end

    scenario 'view book' do
      book = Book.last
      visit books_path
      expect(page).to have_current_path '/books'
      find_link('View Book', match: :first).click
      expect(page).to have_current_path "/books/#{book.id}"
      expect(find('h4')).to have_text 'Book Summary'
    end
    scenario 'edit book' do
      book = Book.last
      find_link('Books').click
      within('table') do
        find_link('Edit', match: :first).click
      end
      expect(page).to have_current_path "/books/#{book.id}/edit"
      within('form') do
        stub_api_call('update title', true)
        fill_in 'Title', with: 'update title'
        fill_in 'Volume', with: 2
      end
      click_button 'Submit'
      expect(find('.notice')).to have_text 'Book was successfully updated.'
      expect(find('h1')).to have_text 'update title'
    end

    scenario 'issue book' do
      find_link('Sign out').click
      visit new_user_registration_path
      within('form') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password confirmation', with: user.password
        click_button 'Sign up'
      end
      within('table') do
        expect(find(:xpath, 'tbody/tr/td[7]/a')).to have_text 'Issue'
        find(:xpath, 'tbody/tr/td[7]/a').click
        expect(find(:xpath, 'tbody/tr/td[7]/a')).to have_text 'Return'
      end
      expect(find('.notice')).to have_text 'Book has been issued'
    end

    scenario 'return book' do
      find_link('Sign out').click
      visit new_user_registration_path
      within('form') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password confirmation', with: user.password
        click_button 'Sign up'
      end
      expect(page).to have_current_path '/books'
      expect(find('.notice')).to have_text 'Welcome! You have signed up successfully'
      within('table') do
        find(:xpath, 'tbody/tr/td[7]/a').click
        expect(find(:xpath, 'tbody/tr/td[7]/a')).to have_text 'Return'
        click_on 'Return', match: :first
        expect(find(:xpath, 'tbody/tr/td[7]/a')).to have_text 'Issue'
      end
      expect(find('.notice')).to have_text 'Book returned'
    end
  end

  context 'unavailable book' do
    let!(:book) { create(:random_book, :skip_validate, availability: 0) }
    let(:user) { create(:random_user) }
    let(:admin_user) { create(:random_user, :admin) }

    scenario 'cannot issue unavailable book' do
      visit new_user_session_path
      expect(page).to have_current_path '/users/sign_in'

      within('form') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end
      expect(page).to have_current_path '/books'
      expect(page).to have_text book.title.to_s

      within('table') do
        click_on 'Issue', exact: true
      end
      expect(page).to have_current_path '/books'
      expect(find('.notice')).to have_text 'Availability is 0, cannot be issued'
    end
  end
end

RSpec.feature 'Check for book data validity', type: :feature do
  let(:book) { build(:sequenced_book) }
  let(:admin_user) { create(:random_user, :admin) }

  scenario 'fails for invalid data' do
    stub_api_call(book.title, false)

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

    expect(page).to have_current_path '/books'
    expect(find('#error_explanation')).to have_text 'prohibited this book from being saved'
  end

  scenario 'succeeds for valid data' do
    stub_api_call(book.title, true)

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

    expect(find('.notice')).to have_text 'Book was successfully created.'
  end
end

RSpec.feature 'Admin panel', type: :feature do
  context 'access permission' do
    let(:user) { create(:random_user) }
    let(:admin) { create(:random_user, :admin) }

    before do
      visit new_user_session_path
    end
    it 'is inaccessible to non admin user' do
      within('form') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end

      visit rails_admin_path
      expect(page).to have_current_path '/books'
    end

    it 'is accessible to admin' do
      within('form') do
        fill_in 'Email', with: admin.email
        fill_in 'Password', with: admin.password
        click_button 'Log in'
      end

      visit rails_admin_path
      expect(page).to have_current_path '/admin'
    end
  end
end