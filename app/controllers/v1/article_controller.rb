class V1::ArticleController < ApplicationController
  def index
    articles = Article.all
    render json: {articles: articles}
  end
end