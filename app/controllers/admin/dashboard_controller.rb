class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin

  def show
    # Your existing code for the show action
  end

  private

  def authenticate_admin
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end
end