require_relative '../lib/players'

describe '#get_name' do
  subject(:players) { Players.new }
  let(:player_one) { 1 }
  let(:player_two) { 2 }
  let(:char) { 'c' }
  context 'when player inputs a character' do
    before do
      allow(players).to receive(:gets).and_return(char)
    end

    it 'returns that character' do
      result = players.get_name(player_one)
      expect(result).to eq(char)
    end
  end

  context 'when player inputs nothing first then a char' do
    let(:empty_char) { '' }

    before do
      allow(players).to receive(:gets).and_return(empty_char, char)
    end

    it 're-prompts for name' do
      expect(players).to receive(:print).twice
      players.get_name(player_one)
    end
  end
end
