class Admin::NewsController < Admin::ApplicationController
  before_filter :find_news, :only => [:edit, :update, :destroy, :delete]

  def index
    @all_news = News.order("#{sort_column} #{sort_direction}").page(params[:page]).per(20)
    @no = paging(20)
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)
    if @news.save
      flash[:notice] = 'News was successfully create.'
      redirect_to admin_news_index_path
    else
      flash[:error] = "News failed to create"
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @news.update_attributes(news_params)
      flash[:notice] = 'News was successfully updated.'
      redirect_to admin_news_index_path
    else
      flash[:error] = "News failed to update"
      render :action => :edit
    end
  end

  def destroy
    flash[:notice] =  @news.destroy ? 'News was successfully deleted.' :
                                           'News was falied to delete.'
    redirect_to admin_news_index_path
  end

  private

    def news_params
      params.require(:news).permit(:title, :content, :short_content, :user, :permalink)
    end

    def find_news
      @news = News.find_by_id(params[:id])
      if @news.nil?
        flash[:notice] = "Cannot find the News with id '#{params[:id]}'"
        redirect_to admin_news_index_path
      end
    end

    def sort_column
      params[:sort] || "created_at"
    end

    def sort_direction
      params[:direction] || "desc"
    end
end
