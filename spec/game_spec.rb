require_relative '../lib/game'
require_relative '../lib/players'
require_relative '../lib/board'

describe Game do
  let(:players) { instance_double(Players) }
  let(:board) { instance_double(Board) }
  subject(:game) { described_class.new }

  describe '#get_move' do
    let(:move) { 'a' }
    let(:color) { :red }

    context 'when a valid move is entered :A' do
      before do
        allow(board).to receive(:space_available?)
        allow(game).to receive(:gets).and_return(move)
      end

      it 'move is returned as uppercase symbol' do
        result = game.get_move
        expect(result).to eq(move.upcase.to_sym)
      end
    end
  end
end
