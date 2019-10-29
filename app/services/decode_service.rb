module DecodeService
  def self.attach_image(file, target)
    if Rails.env == 'test'
      image = file
    else
      image = split_base64(file)
    end

    decoded_data = Base64.decode64(image[:data])
    io = StringIO.new
    io.puts(decoded_data)
    io.rewind
    target.attach(io:io, filename: "base.#{image[:extension]}")
  end
  
  private
  
  def self.split_base64(uri_str)
    if uri_str =~ /^data:(.*?);(.*?),(.*)$/
      uri = {}
      uri[:type] = Regexp.last_match(1)
      uri[:encoder] = Regexp.last_match(2)
      uri[:data] = Regexp.last_match(3)
      uri[:extension] = Regexp.last_match(1).split('/')[1]
      uri
    end
  end
end