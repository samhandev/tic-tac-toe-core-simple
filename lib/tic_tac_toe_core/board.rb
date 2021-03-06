module TicTacToeCore
  class Board
    EMPTY_MARK = '-'

    WINNING_ROWS = {
      3 => [ [0, 1, 2], [3, 4, 5], [6, 7, 8],
             [0, 3, 6], [1, 4, 7], [2, 5, 8],
             [0, 4, 8], [2, 4, 6]],
      4 => [ [0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15], 
             [0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], 
             [0, 5, 10, 15], [3, 6, 9, 12]]
    }

    attr_reader :positions ,:size

    def self.create_empty(size = 3)
      starting_positions = EMPTY_MARK * size * size
      Board.new(size, starting_positions.split(''))
    end

    def initialize(size, positions)
      @size = size
      @positions = positions
    end

    def move(index, marker)
      new_positions = positions.dup
      new_positions[index] = marker
      Board.new(size, new_positions)
    end

    def is_available?(index)
      positions[index] == EMPTY_MARK
    end

    def available_moves
      positions.each_index.select do |index|
        is_available?(index)
      end
    end

    def winner
      winning_row = find_winning_row
      if winning_row
        first_in_row(winning_row)
      end
    end

    def won?
      !find_winning_row.nil?
    end

    def tie?
      no_more_moves? && !won?
    end

    def finished?
      no_more_moves? || won?
    end

    def all_moves
      (0...positions.length).to_a
    end

    def marker_at(index)
      positions[index]
    end

    def moves_made
      positions.each_index.count do |position|
        !is_available?(position)
      end

    end

    private

    def no_more_moves?
      available_moves.length == 0
    end

    def find_winning_row
      get_winning_rows.find do |winning_row|
        row_has_winner?(winning_row)
      end
    end

    def get_winning_rows
      WINNING_ROWS[size]
    end

    def row_has_winner?(row)
      row.all? do |index|
        positions[index] != EMPTY_MARK && positions[index] == first_in_row(row)
      end
    end

    def first_in_row(row)
      positions[row[0]]
    end
  end
end
