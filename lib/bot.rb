require 'telegram/bot'
require 'net/http'
require 'json'

require_relative './general_knowledge'
class Bot
  attr_accessor :general, :token, :question_object, :dupe, :ans, :user_score, :user_answer

  def initialize
    @token = '1294334531:AAGenQ2e-OQlO-VdYs-Sywk2KI7saIxXAyM'
    @question_object = {}
    @dupe = []
    @ans = []
    @user_answer = ''
    @ind = ''
    @user_score = {
      num_of_questions: 0,
      correct_ans: 0
    }
  end

  def main
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        case message
        when Telegram::Bot::Types::CallbackQuery
          call_back(bot, message)
        when Telegram::Bot::Types::Message
          case message.text
          when '/start'
            bot.api.send_message(chat_id: message.chat.id,
                                 text: 'Hi there,type /play to play with me, /stop to stop')
          when '/play'
            kb = [Telegram::Bot::Types::InlineKeyboardButton.new(text: 'General Knowledge', callback_data: 'general')]
            markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
            bot.api.send_message(chat_id: message.chat.id, text: 'Choose a category', reply_markup: markup)
          when '/stop'
            bot.api.send_message(chat_id: message.chat.id, text: 'Sorry to see you go :(')
          end
        end
      end
    end
  end

  # case text
  #   general method which will display instruction to users
  def general_method(bot, message)
    kb = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Hit Me', callback_data: 'hitme'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: "I'm done", callback_data: 'done')
    ]
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
    bot.api.send_message(chat_id: message.from.id, text: "To play, press the 'Hit Me' button.
     to quit press 'I'm done'", reply_markup: markup, one_time_keyboard: true)
  end

  #  method to check if the user pressed the right choice
  def check_win(bot, message)
    if @question_object[:checked] == true
      bot.api.send_message(chat_id: message.from.id, text: 'You have already tried this question, try another one')
    else
      @user_score[:correct_ans] += 1
      @user_score[:num_of_questions] += 1
      bot.api.send_message(chat_id: message.from.id, text: 'Horray that is correct!')
      bot.api.send_message(chat_id: message.from.id,
                           text: "Your score is #{@user_score[:correct_ans]} from #{@user_score[:num_of_questions]}!")
      @question_object[:checked] = true
      kb = [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Hit Me', callback_data: 'hitme'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: "I'm done", callback_data: 'done')
      ]
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      bot.api.send_message(chat_id: message.from.id,
                           text: "To continue, press the 'Hit Me' button. to quit press 'I'm done'",
                           reply_markup: markup, one_time_keyboard: true)
    end
  end

  # Check Wrong answer
  def wrong_answer(bot, message)
    if @question_object[:checked] == true
      bot.api.send_message(chat_id: message.from.id, text: 'You have already tried this question, try another one')
    else
      @user_score[:num_of_questions] += 1
      bot.api.send_message(chat_id: message.from.id, text: ':( That is Wrong!')
      bot.api.send_message(chat_id: message.from.id,
                           text: "Your score is #{@user_score[:correct_ans]} from #{@user_score[:num_of_questions]}!")
      @question_object[:checked] = true
      kb = [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Hit Me', callback_data: 'hitme'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: "I'm done", callback_data: 'done')
      ]
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      bot.api.send_message(chat_id: message.from.id,
                           text: "To continue, press the 'Hit Me' button. to quit press 'I'm done'",
                           reply_markup: markup, one_time_keyboard: true)
    end
  end

  # When done
  def done(bot, message)
    bot.api.send_message(
      chat_id: message.from.id,
      text: " It was fun playing with you :) You've scored #{@user_score[:correct_ans]}
    from #{@user_score[:num_of_questions]}! \n hit /play to play again"
    )
    @user_score[:correct_ans] = 0
    @user_score[:num_of_questions] = 0
    @question_object = {}
  end

  # When hit me
  def hit_me(bot, message)
    general = Generalknowledge.new
    @question_object = general.prep
    @question_object[:checked] = false
    question = general.prep['ques']
    @ans = general.prep['answrs']
    @ind = @ans.index(@question_object['correct']).to_s

    kb = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: (@ans[0]).to_s, callback_data: '0'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: (@ans[1]).to_s, callback_data: '1'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: (@ans[2]).to_s, callback_data: '2'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: (@ans[3]).to_s, callback_data: '3')
    ]

    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
    bot.api.send_message(chat_id: message.from.id, text: question.to_s, reply_markup: markup, one_time_keyboard: true)
  end

  def call_back(bot, message)
    case message.data
    when 'general'
      general_method(bot, message)
    when @ind
      check_win(bot, message)

    when 'hitme'
      hit_me(bot, message)
    when 'done'
      done(bot, message)
    else
      wrong_answer(bot, message)
    end
  end
end
