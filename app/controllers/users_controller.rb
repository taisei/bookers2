class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
  	@bookes = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def new
  end

  def edit
      @user = User.find(params[:id])
      if @user != current_user
      redirect_to user_path(current_user)
      end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id),notice: 'successfully'
    else
    render :edit
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end
  def create
        book = Book.new(book_params)
        book.save
        redirect_to books_path,notice: 'successfully'
  end
  private
  def book_params
        params.require(:book).permit(:title, :body)
  end
end
