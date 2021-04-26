class IssuebookController < ApplicationController
  def issue
    if user_signed_in?
      if Book.find(params[:id]).availability.zero?
        redirect_to books_url, notice: 'Availability is 0, cannot be issued'
      else
        Book.issuelogic(params, current_user.id)
        redirect_to controller: 'books', action: 'index'
      end
    else
      redirect_to new_user_session_path
    end
  end

  def return
    if user_signed_in?
      Book.returnlogic(params, current_user.id)
    else
      redirect_to new_user_session_path
    end
    redirect_to controller: 'books', action: 'index'
  end

  def viewissuedbooks
    @issuedbooks = Bookissue.where(user_id: params[:id])
  end
end
