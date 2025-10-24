class LineItemsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    quantity = params[:quantity].to_i
    current_cart.add_product(@book, quantity)
    redirect_to cart_path(@book.id), notice: "#{@book.book_name}がカートに追加されました"
  end
end