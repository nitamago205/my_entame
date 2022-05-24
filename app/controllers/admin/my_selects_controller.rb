class Admin::MySelectsController < ApplicationController
  def edit
    @post = Post.find(params[:post_id])
    @select = MySelect.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @select = MySelect.find(params[:id])
    if @select.update(my_select_params)
      redirect_to admin_post_path(@select.post_id), notice: "マイセレクトを更新しました。"
    else
      render :edit
    end
  end

  def destroy
     @select = MySelect.find_by(id: params[:id], post_id: params[:post_id])
    if @select.destroy
      redirect_to admin_post_path(@select.post_id)
    end
  end

  private

  def my_select_params
    params.require(:my_select).permit(:title, :body, :post_id)
  end

end
