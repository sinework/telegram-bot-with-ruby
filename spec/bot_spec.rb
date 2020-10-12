require_relative '../lib/bot'
describe Bot do
  let(:bot) { Bot.new }
  it 'Raises argument error when arguments are given' do
    expect { bot.main('value') }.to raise_error(ArgumentError)
  end
  it 'Raises argument error when arguments are given' do
    expect { bot.check_win('value') }.to raise_error(ArgumentError)
  end
  it 'Raises argument error when arguments are given' do
    expect { bot.general_method('value') }.to raise_error(ArgumentError)
  end
  it 'Raises argument error when arguments are given' do
    expect { bot.wrong_answer('value') }.to raise_error(ArgumentError)
  end
end
