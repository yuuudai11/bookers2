class BooksController < ApplicationController

  before_action :is_matching_book, only: [:edit, :update, :destroy]

  def new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index

    end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
    # @book_new = Book.new
    # # @book = Book.find(params[:id])
    # # @users = @book.new
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
    @book_new = Book.new
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :edit
    end
  end


  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_book
    @book = Book.find(params[:id])
    book_id = @book.user_id
    unless book_id == current_user.id
      redirect_to books_path
    end
  end

end