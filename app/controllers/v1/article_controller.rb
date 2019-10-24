class V1::ArticleController < ApplicationController
  def index
    articles = Article.all
  end
end
