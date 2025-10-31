class OrdersController < ApplicationController
  before_action :authenticate_user! # 追加

  def new
    @order = Order.new
    @line_items = current_cart.line_items  # 現在のカートのアイテムを取得
  end

def confirm
  @order = Order.new(order_params)
  @line_items = current_cart.line_items # Get items from cart

  # @order.total = calculate_total → unnecessary
  # @cart = current_cart → unnecessary

  # Create order details
  @line_items.each do |line_item| # ← modified here
    quantity = params[:order][:quantity].to_i

    if quantity > 0
      line_item.update(quantity: quantity)
    else
      line_item.destroy
    end

    @order.order_details.build(
      book: line_item.book,
      count: line_item.quantity,
      price: line_item.price
    )
  end

  # Calculate total amount and quantity
  @order.total = calculate_total
  @order.quantity = calculate_quantity

  # Temporary data for confirmation screen
  @order_details = @line_items.map do |line_item|
    {
      book_name: line_item.book.book_name,
      quantity: line_item.quantity,
      price: line_item.price,
      total_price: line_item.price * line_item.quantity
    }
  end
end

  def create
      
    @order = Order.new(order_params)
    @order.total = calculate_total # 合計金額を計算
    @order.quantity = calculate_quantity

    # 注文詳細を作成
    current_cart.line_items.each do |line_item|
      @order.order_details.build(
        book: line_item.book,
        count: line_item.quantity,
        price: line_item.price
      )
    end

    if @order.save
      # 注文後にカートを空にする
      current_cart.line_items.destroy_all

      redirect_to complete_order_path(@order)
    else
      render :new
    end
  end

  def complete
    @order = Order.find(params[:id]) # 注文情報を取得
  end

  private

    def order_params
      params.require(:order).permit(:quantity, :delivery_address, :total, line_items: [])
    end

    def calculate_total
      current_cart.line_items.sum { |line_item| line_item.price * line_item.quantity }
    end

    def calculate_quantity
      current_cart.line_items.sum { |line_item| line_item.quantity }
    end

end