class V1::CategoriesController < ApplicationController
  before_action :authenticate_user!,  except: :index

  def index
    categories = Category.all
    render json: categories, each_serializer: Categories::IndexSerializer
  end
end
