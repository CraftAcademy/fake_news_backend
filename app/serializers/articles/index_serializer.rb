class Articles::IndexSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
    
  attributes :id, :title, :content, :image
  belongs_to :category, serializer: Categories::IndexSerializer

  def image
    if Rails.env.test?
      rails_blob_url(object.image)
    else
      object.image.service_url(expires_in: 1.hour, disposition: 'inline')
    end
  end
end