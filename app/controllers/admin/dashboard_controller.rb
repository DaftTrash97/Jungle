class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin
  before_action :load_stats, only: [:show]
  def show
  end

  def authenticate_admin
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end

  def load_stats
    @product_count = Product.count
    @category_count = Category.count
  end
end