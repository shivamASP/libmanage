class IssuebookController < ApplicationController
  def issue
    if user_signed_in?
      Book.issuelogic(params, current_user.id)
    else
      redirect_to new_user_session_path
    end
  redirect_to controller: 'books', action: 'index'
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
