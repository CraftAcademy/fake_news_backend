class V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    if articles.empty? 
      render_error_message("There are no articles here", 404)
    else
      render json: articles, each_serializer: Articles::IndexSerializer
    end
  end

  def show
    
    if Article.exists?(id: params[:id])
      @article = Article.find(params[:id])
      render json: @article, serializer: Articles::IndexSerializer
    else
      render_error_message("The article couldn't be found", 404)
    end
  end

  def create
    @article = Article.create(article_params)
    attach_image
    if @article.persisted? && @article.image.attached?
      render json: { message: 'Article was successfully created' }
    else
      render_error_message(@article.errors.full_messages.to_sentence, 400)
    end
  end

  private

  def article_params
    params.permit([:title, :content, keys: [:image]])
  end

  def attach_image
    if params['image'] && params['image'].present?
      DecodeService.attach_image(params['image'], @article.image)
    end
  end
  
  def render_error_message(message, status) 
    render json: { error_message: message }, status: status
  end
end