class V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    if articles.empty? 
      render_error_message("There are no articles here", 404)
    else
      render json: articles, each_serializer: Articles::IndexSerializer
    end
  end

  def create
    
  end

  private
  
  def render_error_message(message, status) 
    render json: { error_message: message }, status: status
  end
end