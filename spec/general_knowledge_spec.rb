require_relative '../lib/general_knowledge.rb'
describe GeneralKnowledge do
    let(:general) { GeneralKnowledge.new }
    context '#reques' do
      it 'returns true for an object that is a string object' do
        expect(news.send_news.is_a?(String)).to eql(true)
      end
    end
  
    context '#send_news' do
      it 'returns false for an object that is a string object' do
        expect(news.send_news.is_a?(Hash)).to eql(false)
      end
    end
  
    context '#request' do
      it 'returns true for Http request' do
        expect(news.make_request.class).to eql(HTTP::Rss)
      end
    end
  end
  