class MicropostsController < ApplicationController
    include MicropostsHelper
    before_filter :signed_in_user, only: [:create, :destroy]
    before_filter :correct_user,   only: :destroy

    def create
        @micropost = current_user.microposts.build(params[:micropost])
        @micropost.content = @micropost.content
        if @micropost.save
            flash[:success] = "Micropost Created!"
            redirect_to root_path
        else
            @feed_items = current_user.feed.paginate(page: params[:page])
            render 'static_pages/home'
        end
    end

    def destroy
        @micropost.destroy
        redirect_back_or root_path
    end

    private
      
      def correct_user
          @micropost = current_user.microposts.find(params[:id])
      rescue
          redirect_to root_path
      end
end

