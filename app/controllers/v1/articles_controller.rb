class V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles, each_serializer: Articles::IndexSerializer
  end
end