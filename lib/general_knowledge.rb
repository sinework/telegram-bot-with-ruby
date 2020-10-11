require 'telegram/bot'
require 'net/http'
require 'json'


class General_knowledge
  @values = nil
  
  def initialize
    @values = make_the_request
  end

  def make_the_request
    url = 'https://opentdb.com/api.php?amount=10&category=9&type=multiple'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)
    response["results"].sample
  end
  def prep
    preped= Hash.new
       preped['ques'] = @values['question']
    preped['answrs'] = @values["incorrect_answers"]
    preped['answrs'].push(@values['correct_answer'])
    preped['correct'] = @values['correct_answer']
     preped
    
  end

end