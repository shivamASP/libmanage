class HomeController < ApplicationController
  def index
    if current_user
      redirect_to books_path
    end
  end
end