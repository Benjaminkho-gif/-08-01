class CartsController < ApplicationController
  before_action :authenticate_user! # 追加
  
  def show
    @cart = current_cart
  end

  def destroy
    current_cart.line_items.destroy_all
    redirect_to products_path, alert: 'カートが空になりました'
  end
  
end