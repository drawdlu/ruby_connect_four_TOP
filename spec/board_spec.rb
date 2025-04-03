require_relative '../lib/board'

describe Board do
  subject(:connect_board) { described_class.new }
  let(:sample_board) { Array.new(6) { Array.new(7, nil) } }
  let(:color) { :red }

  describe '#place_piece_on_board' do
    let(:letter) { :A }

    context 'when a piece is placed on an empty column' do
      it 'will go to the bottom' do
        sample_board[0][5] = color

        connect_board.place_piece_on_board(color, letter)
        board_result = connect_board.instance_variable_get(:@board)
        expect(board_result).to eq(sample_board)
      end
    end

    context 'when a piece is placed on a column with 1 piece' do
      it 'will place the above the first piece' do
        sample_board[0][5] = color
        one_piece_board = Marshal.load(Marshal.dump(sample_board))
        sample_board[0][4] = color
        connect_board.instance_variable_set(:@board, one_piece_board)

        connect_board.place_piece_on_board(color, letter)
        board_result = connect_board.instance_variable_get(:@board)
        expect(board_result).to eq(sample_board)
      end
    end
  end

  describe '#check_win?' do
    context 'Horizontal Checks' do
      context 'when there is four consecutive colors on last row' do
        it 'will return True' do
          sample_board[5][0..3] = Array.new(4, color)
          last_index_pair = [5, 3]
          connect_board.instance_variable_set(:@board, sample_board)
          result = connect_board.check_win?(last_index_pair)
          expect(result).to be_truthy
        end
      end

      context 'when there is four consecutive colors on mid row and mid column' do
        it 'will return True' do
          sample_board[3][1..4] = Array.new(4, color)
          last_index_pair = [3, 4]
          connect_board.instance_variable_set(:@board, sample_board)
          result = connect_board.check_win?(last_index_pair)
          expect(result).to be_truthy
        end
      end

      context 'when there is only 3 consecutive colors on first row mid column' do
        it 'will return False' do
          sample_board[0][2..4] = Array.new(3, color)
          last_index_pair = [0, 4]
          connect_board.instance_variable_set(:@board, sample_board)
          result = connect_board.check_win?(last_index_pair)
          expect(result).to be_falsy
        end
      end

      context 'when there is only 3 consecutive colors on last row and left most column' do
        it 'will return False' do
          sample_board[5][0..2] = Array.new(3, color)
          last_index_pair = [5, 2]
          connect_board.instance_variable_set(:@board, sample_board)
          result = connect_board.check_win?(last_index_pair)
          expect(result).to be_falsy
        end
      end
    end

    context 'Vertical Checks' do
      context 'when there are 4 consecutive on left most column bottom row' do
        it 'will return True' do
          (2..5).each { |index| sample_board[index][0] = color }
          last_index_pair = [5, 0]
          connect_board.instance_variable_set(:@board, sample_board)
          result = connect_board.check_win?(last_index_pair)
          expect(result).to be_truthy
        end
      end

      context 'when there are 4 consecutive pieces on middle row and column' do
        it 'will return True' do
          (1..4).each { |index| sample_board[index][4] = color }
          last_index_pair = [4, 4]
          connect_board.instance_variable_set(:@board, sample_board)
          result = connect_board.check_win?(last_index_pair)
          expect(result).to be_truthy
        end
      end

      context 'when there are only 3 consecutive pieces on the last column' do
        it 'will return False' do
          (2..4).each { |index| sample_board[index][6] = color }
          last_index_pair = [4, 6]
          connect_board.instance_variable_set(:@board, sample_board)
          result = connect_board.check_win?(last_index_pair)
          expect(result).to be_falsy
        end
      end
    end
  end
end
