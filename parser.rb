require_relative 'parsers_classes'

class Parser
  def self.photo_urls
    PhotoParser.new.get_photos_urls
  end

#  def self.audio_urls
#    AudioParser.new.get_audio_urls
#  end
end
