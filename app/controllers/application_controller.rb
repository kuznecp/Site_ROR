# frozen_string_literal: true

# class ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  protected

  def authorize
    return if User.find_by(id: session[:user_id])

    redirect_to '/login', notice: 'You trying to access without permit?'
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options = {})
    options.merge(locale: I18n.locale)
  end
end
