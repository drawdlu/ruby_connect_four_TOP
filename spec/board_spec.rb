require_relative '../lib/board'

describe Board do
  describe '#place_piece_on_board' do
    subject(:connect_board) { described_class.new }
    let(:color) { :red }
    let(:letter) { :A }
    let(:expected_result) { Array.new(6) { Array.new(7, nil) } }

    context 'when a piece is placed on an empty column' do
      it 'will go to the bottom' do
        expected_result[0][5] = color

        connect_board.place_piece_on_board(color, letter)
        board_result = connect_board.instance_variable_get(:@board)
        expect(board_result).to eq(expected_result)
      end
    end

    context 'when a piece is placed on a column with 1 piece' do
      it 'will place the above the first piece' do
        expected_result[0][5] = color
        one_piece_board = Marshal.load(Marshal.dump(expected_result))
        expected_result[0][4] = color
        connect_board.instance_variable_set(:@board, one_piece_board)

        connect_board.place_piece_on_board(color, letter)
        board_result = connect_board.instance_variable_get(:@board)
        expect(board_result).to eq(expected_result)
      end
    end
  end
end
