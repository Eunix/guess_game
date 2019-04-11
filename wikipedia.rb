# frozen_string_literal: true

require 'json'
require 'httpclient'

# Fetches random wikipedia page
class Wikipedia
  attr_accessor :client

  def initialize
    @client = HTTPClient.new
  end

  def random_page
    response = client.get(
      'https://en.wikipedia.org/api/rest_v1/page/random/summary',
      follow_redirect: true
    )
    json = JSON.parse(response.body)

    {
      title: json['title'],
      image: parse_image_url(json)
    }
  end

  private

  def image_url(media_url)
    response = client.get(media_url)
    json = JSON.parse(response.body)
    json['items'].first['original']['source']
  end

  def parse_image_url(json)
    json['thumbnail']['source']
  end
end
