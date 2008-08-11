class HomeController < ApplicationController

  #
  #
  #
  def confirm_user
    @user = User.find_by_token(params[:token])

    if @user.nil?
      # TODO - fix this
      render :text => 'User confirmation not found'
      return
    end

    @user.update_attribute(:is_confirmed, true)
    @user.unapproved_pastes.each do |p|
      p.update_attribute(:is_approved, true)
    end
    cookies[:token] = @user.token
    flash[:notice] = 'Your humanity was confirmed. Thank you.'
    redirect_to paste_path(@user.pastes.first)
  end

  def time_to_upgrade
    render :layout => false
  end

end
