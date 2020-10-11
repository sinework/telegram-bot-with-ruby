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

   




end   