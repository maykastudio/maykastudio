class Manage::ApplicationController < ApplicationController

  layout 'manage'

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: t('cancan.access_denied')
  end

  private

  def namespace
    params[:controller].split('/').first
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, namespace)
  end
end