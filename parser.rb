require 'nokogiri'
require 'httparty'

class Parser
  def self.photo_urls
    PhotoParser.new.get_photos_urls
  end

#  def self.audio_urls
#    AudioParser.new.get_audio_urls
#  end
end

class PhotoParser
  ALBUM = 'https://vk.com/album-65249820_259499294?rev=1'

  attr_reader :photo_urls

  def initialize
    @photo_urls = []
  end

  def get_photos_urls
    photo_page = HTTParty.get(ALBUM)
    @parsed_photo_page = Nokogiri::HTML(photo_page)

    @parsed_photo_page.xpath('//img').each do |data|
      @photo_urls.push data.attr('data-src_big').to_s.match(/https\S+jpg/).to_s
    end

    @photo_urls -= [""]
  end
end

# class AudioParser
#   AUDIOS = 'https://topsoundboard.ru/gladvalakas/'
#
#  attr_reader :audio_urls
#
#  def initialize
#    @audio_urls = []
#  end
#
#  def get_audio_urls
#    audio_page = HTTParty.get(AUDIOS)
#    @parsed_audio_page = Nokogiri::HTML(audio_page)
#
#    @parsed_audio_page.xpath('//input').each do |data|
#      @audio_urls.push data.attr('onclick').to_s.match(/http\S+.mp3/).to_s
#    end
#
#    @audio_urls -= [""]
#  end
# end
