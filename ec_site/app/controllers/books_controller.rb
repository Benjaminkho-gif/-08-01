class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :admin_scan, only: %i[show edit update destroy]

  # GET /books or /books.json
  def index
    # Initialize the Ransack search object
    @q = Book.ransack(params[:q])

    # Get the filtered books from the search
    @books = @q.result(distinct: true)

    # Optional: Pagination with Kaminari or WillPaginate
    @books = @books.page(params[:page])
    
    respond_to do |format|
      format.html
      format.js   # respond to AJAX (index.js.erb) for same-page updates
    end
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "新しい書籍を登録しました" }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "書籍情報を編集しました" }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_path, status: :see_other, notice: "書籍を削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:book_name, :author_name, :issue_date, :product_display, :price, :status, :image, tag_ids: [])
    end

    def admin_scan
      unless admin_signed_in?
        redirect_to products_path  # Redirect to products_path if admin is not signed in
      end
    end
end
