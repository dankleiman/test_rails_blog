class ArticlesController < ApplicationController
  def index
    @articles = Articles.order('created_at DESC')
  end

  def new
    @categories = Category.all
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      params[:category].each do |category_id|
        category = Category.find(category_id)
        Categorization.create(article: @article,
          category: category)
      end

      redirect_to '/articles'
    else
      flash.now[:notice] = "Your blog post could not be saved."
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :author, :body)
  end
end

