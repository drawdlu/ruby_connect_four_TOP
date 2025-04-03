require_relative '../lib/board'

describe Board do
  describe '#place_piece_on_board' do
    subject(:connect_board) { described_class.new }
    context 'when a piece is placed on an empty column' do
      it 'will go to the bottom' do
        color = :red
        letter = :A
        expected_result = Array.new(6) { Array.new(7, nil) }
        expected_result[0][5] = color

        connect_board.place_piece_on_board(color, letter)
        board_result = connect_board.instance_variable_get(:@board)
        expect(board_result).to eq(expected_result)
      end
    end
  end
end
