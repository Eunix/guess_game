# frozen_string_literal: true

require 'twilio-ruby'

# Send messages
class WhatsApp
  attr_accessor :client

  def initialize
    account_sid = ENV['account_sid']
    auth_token = ENV['auth_token']

    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def send_message(to, message)
    @client.messages
           .create(
             from: 'whatsapp:+14155238886',
             body: message,
             to: to
           )
  end

  def send_media(to, media_url)
    @client.messages
           .create(
             from: 'whatsapp:+14155238886',
             body: '',
             to: to,
             media_url: media_url
           )
  end
end
