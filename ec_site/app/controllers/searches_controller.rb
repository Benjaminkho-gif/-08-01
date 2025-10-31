class SearchesController < ApplicationController
  # Simple search controller that uses Ransack to search Books.
  # Provides index (renders results) and search (helper for /search route).

  def index
  @q = Book.ransack(params[:q])
  @books = @q.result(distinct: true)
  # Call pagination only if the pagination gem is present
  @books = @books.page(params[:page]) if @books.respond_to?(:page)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # /search route helper — redirects to searches#index with same params
  def search
    # Instead of redirecting, render the index view directly with the
    # provided params so we avoid extra redirects (which caused loops
    # in some environments). Keep behavior equivalent to index.
  @q = Book.ransack(params[:q])
  @books = @q.result(distinct: true)
  @books = @books.page(params[:page]) if @books.respond_to?(:page)
    respond_to do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end
end
