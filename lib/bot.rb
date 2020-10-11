require 'telegram/bot'
require 'net/http'
require 'json'

require_relative './caller.rb'
class Bot
    attr_accessor :general, :token, :question_object, :dupe, :ans, :user_score, :user_answer
   def initialize
    @token = '1294334531:AAGenQ2e-OQlO-VdYs-Sywk2KI7saIxXAyM'
    @question_object=Hash.new()
    @dupe=[]
    @ans=[]
    @user_answer=''
    @ind=''
    @user_score={
      num_of_questions: 0,
      correct_ans:0
    }
    
   end
   def main
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        case message
        when Telegram::Bot::Types::CallbackQuery
         
           if message.data == 'general'
           general(bot,message)
            elsif message.data == @ind
              # bot.api.delete_message( chat_id: message.from.id, message_id: message_id)
              check_win(bot,message)
              
            elsif message.data == 'hitme'
              general=General_knowledge.new()
              @question_object=general.prep
              @question_object[:checked]=false
              question=general.prep['ques']
              @ans=general.prep['answrs']
              @ind= @ans.index(@question_object['correct']).to_s
              
                kb=[
                  Telegram::Bot::Types::InlineKeyboardButton.new(text: "#{@ans[0]}", callback_data: "#{0}"),
                  Telegram::Bot::Types::InlineKeyboardButton.new(text: "#{@ans[1]}", callback_data: "#{1}"),
                  Telegram::Bot::Types::InlineKeyboardButton.new(text: "#{@ans[2]}", callback_data: "#{2}"),
                  Telegram::Bot::Types::InlineKeyboardButton.new(text: "#{@ans[3]}", callback_data: "#{3}")
              ]
                
                markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
                bot.api.send_message(chat_id: message.from.id, text: "#{question}", reply_markup:markup,one_time_keyboard: true)
           elsif message.data == 'done'
            
            bot.api.send_message(chat_id: message.from.id, text: " It was fun playing with you :) You've scored #{@user_score[:correct_ans]} from #{@user_score[:num_of_questions]}! \n hit /play to play again") 
            @user_score[:correct_ans] =0
                @user_score[:num_of_questions] = 0
            @question_object= {}
          else
            
           wrong_answer(bot, message)
          end
        when Telegram::Bot::Types::Message
          case message.text
          when '/start'
            bot.api.send_message(chat_id: message.chat.id, text: 'Hi there, my name is QuizMe, you can use me to test your knowledge in the topic of your choice. hit /play to start. You can also type /stop when ever you want to exit')
          when '/play'
            kb = [
  
              Telegram::Bot::Types::InlineKeyboardButton.new(text: 'General Knowledge', callback_data: 'general'),
              Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Computers', callback_data: 'computer')
  
            ]
            markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
            bot.api.send_message(chat_id: message.chat.id, text: 'Choose a Category. I only have one category for you now \n  but more will be comming soon ', reply_markup: markup)
          when '/stop'
            bot.api.send_message(chat_id: message.chat.id, text: 'Sorry to see you go :(')
          end
        end
      end
    end
  end  
#   general method which will display instruction to users
  def general(bot, message)
    kb=[
      Telegram::Bot::Types::InlineKeyboardButton.new(text: "Hit Me", callback_data: "hitme"),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: "I'm done", callback_data: "done")
       ]
       markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
       bot.api.send_message(chat_id: message.from.id, text: "To play, press the 'Hit Me' button. to quit press 'I'm done'", reply_markup:markup, one_time_keyboard: true
      )
   end  
   




end   