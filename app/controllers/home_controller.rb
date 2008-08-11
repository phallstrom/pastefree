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
    cookies[:token] = { :value => @user.token, :path => '/', :expires => 1.year.from_now } 
    flash[:notice] = 'Your humanity was confirmed. Thank you.'
    redirect_to mine_pastes_path
  end

  def time_to_upgrade
    render :layout => false
  end

end
