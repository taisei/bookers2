class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
  	@book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def show
      @bookes = Book.new
      @book = Book.find(params[:id])
      @user = @book.user
  end
  def destroy
      book = Book.find(params[:id])
      book.destroy
      redirect_to books_path
  end
  def edit
      @book = Book.find(params[:id])
      @user = @book.user
      if @user.id != current_user.id
      redirect_to books_path
      end
  end
  def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'successfully'
      else
      render :edit
      end
  end
  def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
        redirect_to book_path(@book.id), notice: 'successfully'
        else 
        @books = Book.all
        @user = User.find(current_user.id)
        render :index
        end
  end
  private
  def user_params
      params.require(:user).permit(:name, :profile_image)
  end
  def book_params
      params.require(:book).permit(:title, :body)
  end
end