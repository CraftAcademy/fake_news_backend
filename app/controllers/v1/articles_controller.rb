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
    @article = Article.create(article_params)
    attach_image
    if @article.persisted? && @article.image.attached?
      render json: { message: 'Article was successfully created' }
    else
      render_error_message(@article.errors.first.to_sentence, 400)
    end
  end

  private

  def article_params
    params.permit([:title, :content, keys: [:image]])
  end

  def attach_image
    if params['image'] && params['image'].present?
      DecodeService.attach_image(params['image'].first, @article.image)
    end
  end
  
  def render_error_message(message, status) 
    render json: { error_message: message }, status: status
  end
end