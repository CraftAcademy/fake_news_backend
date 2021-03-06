class V1::ArticlesController < ApplicationController
  before_action :authenticate_user!,  except: :index

  def index
    articles = Article.all
    
    if articles.empty? 
      render_error_message("There are no articles here", 401)
    else
      render json: articles, each_serializer: Articles::IndexSerializer
    end
  end

  def show
    if (current_user.role == 'subscriber') || (current_user.role == 'journalist')
      if Article.exists?(id:params[:id])
        article =  Article.find(params[:id])
        render json: article, serializer: Articles::IndexSerializer
      else
        render_error_message("Unavailable content", 401)
      end
    else
      render_error_message('You need to become a Subscriber to view this article', 401)
    end
  end

  def create
    authorize Article.create
    category = Category.find_by(name: params['category'])
    
    article = Article.create(article_params.merge!(journalist: current_user, category: category))
    
    if article.persisted? && attach_image(article)
      render json: { message: 'Article was successfully created' }
    else
      render_error_message(article.errors.full_messages.to_sentence, 400)
    end
  end
  
  def update
    article = Article.find(params[:id])
    
    authorize article
    
    if article.update(article_params) && attach_image(article)
      render json: {message: 'Article was successfully edited'}, status: 200
    else
      render_error_message(article.errors.full_messages.to_sentence, 400)
    end
  end

  private

  def article_params
    params.permit(:title, :content, keys: [:image])
  end

  def attach_image(article)
    if params['image'] && params['image'].present?
      DecodeService.attach_image(params['image'].first, article.image)
    end
  end
  
  def render_error_message(message, status) 
    render json: { error_message: message }, status: status
  end
end