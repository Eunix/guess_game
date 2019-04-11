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

  def parse_image_url(json)
    json['thumbnail']['source']
  end
end
