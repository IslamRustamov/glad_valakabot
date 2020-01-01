# coding: UTF-8
require 'telegram/bot'
require_relative 'parser'

WHAT = ['каво?', 'нипонял', 'эта що такое', 'КАВО', 'БАН']

#No no noooo, Im not giving you my API key
TOKEN = ''

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::CallbackQuery
      if message.data == 'sendpic'
        bot.api.send_photo(chat_id: message.from.id, photo: Parser.photo_urls.sample)
      end
    # if message.data == 'sendaudio'
    #   bot.api.send_message(chat_id: message.from.id, text: Parser.audio_urls.sample)
    # end
      if message.data == 'what'
        bot.api.send_message(chat_id: message.from.id, text: WHAT.sample)
      end
    when Telegram::Bot::Types::Message
      kb = [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Пакажи картиначку', callback_data: 'sendpic'),
      # Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Дай галасок паслушать', callback_data: 'sendaudio'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Йощкаре', callback_data: 'what')
      ]
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      bot.api.send_message(chat_id: message.chat.id, text: 'Шо нада?', reply_markup: markup)
    end
  end
end
