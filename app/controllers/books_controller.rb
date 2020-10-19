class BooksController < ApplicationController
  before_action :correct_user, only: [:edit]


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
   else
     @books = Book.all
     @user = current_user
      render :index
   end
  end


  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @booknew = Book.new
    @user = @book.user

  end

  def edit
    # @book = Book.find(params[:id])

    if @book.user_id == current_user
    @book = Book.find(params[:id])
      render :edit
    else
      @book.user = current_user
      render :edit
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "successfully"
     redirect_to book_path(@book)
    else
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

  def correct_user
    @book = Book.find(params[:id])
    # redirect_to user_path(current_user.id) unless params[:id] == cur÷rent_user.id
    redirect_to(books_url) unless @book.user == current_user

  end

end
