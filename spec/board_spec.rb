require_relative '../lib/board'

describe Board do
  describe '#place_piece_on_board' do
    subject(:connect_board) { described_class.new }
    context 'when a piece is placed on an empty board' do
      it 'will go to the bottom' do
        expected_result = Array.new(6) { Array.new(7, nil) }
        expected_result[0][5] = :red

        connect_board.place_piece_on_board(color, letter)
        board_result = connect_board.get_instance_variable(:@board)
        expect(board_result).to eq(expected_result)
      end
    end
  end
end
