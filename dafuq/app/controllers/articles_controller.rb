class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh",
                               password: "secret",
                               except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    ## display the basic string and text entered:
    # render plain: params[:article].inspect
    ## [I] am (a) dork: https://github.com/rails/rails/issues/14650

    ## securely pass the title and text parameters
    # @article = Article.new(params.require(:article).permit(:title, :text))

    # Uses the private method below "so it can be reused by multiple actions
    # in the same controller, for example create and update."
    # per http://guides.rubyonrails.org/v4.2/getting_started.html#saving-data-in-the-controller
    # and more info on "strong parameters" http://weblog.rubyonrails.org/2012/3/21/strong-parameters/
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    # Note that we don't need to add a view for this
    # action since we're redirecting to the index action.
    redirect_to articles_path
  end

#In general, Rails encourages using resources objects instead of
# declaring routes manually. For more information about routing,
# see Rails Routing from the Outside In:
# http://guides.rubyonrails.org/v4.2/routing.html

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

end
