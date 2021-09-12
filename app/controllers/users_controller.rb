class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
    redirect_to user_path(current_user.id)
    end
  end

  def create
    @user = User.new(book_params)
    @user.user_id = current_user.id
    if @user.save
    flash[:notice] = "Book was successfully created."
    redirect_to user_path(@user.id)
    else
    @users = User.all
    render :index
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "ユーザーを正常に更新しました。"
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
