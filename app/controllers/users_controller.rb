class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @user = User.new
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
    redirect_to user_path(current_user.id)
    end
  end

def create
    @user = User.new(user_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "you have created book successfully."
    redirect_to book_path(@book.id)
    else
    @books = Book.all
    render :show
    end
end



  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user)
    else
    render 'edit'
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
