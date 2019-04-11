# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require './wikipedia'
require './whatsapp'

# Guess game sinatra app
class GuessGame < Sinatra::Base
  attr_accessor :players, :whatsapp, :wikipedia

  def initialize
    super
    @players = {}
    @whatsapp = WhatsApp.new
    @wikipedia = Wikipedia.new
  end

  post '/message' do
    participant = params['From']
    body = params['Body']

    case body
    when 'Play'
      start_game(participant)
    else
      if @players[participant].nil?
        @whatsapp.send_message(
          participant,
          "You didn't start the game. Please start with sending play command"
        )
      elsif @players[participant].include?(body)
        @whatsapp.send_message(
          participant, 'Nice! Well done. Type play to start again'
        )
        @players[participant].nil?
      else
        @whatsapp.send_message(
          participant,
          'Oh no! Please try again or start a game with play'
        )
      end
    end
  end

  private

  def start_game(participant)
    random_page = @wikipedia.random_page

    @players[participant] = random_page[:title]

    puts "Trying to guess #{random_page[:title]}"

    @whatsapp.send_message(participant, 'Please guess the title')
    @whatsapp.send_media(participant, random_page[:image])
  end
end

run GuessGame.run!
