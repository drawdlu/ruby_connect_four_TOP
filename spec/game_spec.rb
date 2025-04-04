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
    $stdout = File.open(File::NULL, 'w')

    context 'when a valid move is entered "a"' do
      before do
        allow(board).to receive(:space_available?)
        allow(game).to receive(:gets).and_return(move)
      end

      it 'move is returned as uppercase symbol' do
        result = game.get_move
        expect(result).to eq(move.upcase.to_sym)
      end
    end

    context 'when an invalid move is entered once empty, then "a"' do
      let(:empty_char) { '' }

      before do
        allow(board).to receive(:space_available?)
        allow(game).to receive(:gets).and_return(empty_char, move)
      end

      it 'a prompts for move again' do
        expect(game).to receive(:print).twice
        game.get_move
      end
    end

    context 'when a column is full it prompts for a move again' do
      let(:full_move) { 'b' }
      let(:move_index) { 1 }
      let(:full_board) { Board.new }

      before do
        allow(board).to receive(:space_available?)
        allow(game).to receive(:gets).and_return(full_move, move)
        (0..5).each { |index| full_board.board[index][move_index] = color }
        game.instance_variable_set(:@board, full_board)
      end

      it 'prompts for a move again' do
        expect(game).to receive(:print).twice
        game.get_move
      end
    end
  end
end
