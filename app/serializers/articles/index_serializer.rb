class Articles::IndexSerializer < ActiveModel::Serializer  
  attributes :id, :title, :content, :image

  def image
    object.image.service_url(expires_in: 1.hour, disposition: 'inline')
  end
end
