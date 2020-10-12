require_relative '../lib/general_knowledge'
describe Generalknowledge do
  let(:general) { Generalknowledge.new }
  it 'Raises argument error when arguments are given' do
    expect { general.request('value') }.to raise_error(ArgumentError)
  end
  it 'Raises argument error when arguments are given' do
    expect { general.prep('value') }.to raise_error(ArgumentError)
  end
end
