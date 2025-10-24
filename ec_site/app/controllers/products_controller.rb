class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[ show ]

  def index
    @products = Book.all
  end

  def show
    @product = Book.find(params[:id])
    @line_item = LineItem.new
  end

  private

    def set_book
      @product = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:book_name, :author_name, :issue_date, :product_display, :price, :status, :image, tag_ids: []) # 追加
    end

end