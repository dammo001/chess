require 'byebug'
class Piece

	attr_reader  :value, :color
	attr_accessor :position

	def initialize(position, color)
		@value = "   "
		@position = position
		@color = color
	end

	def occupied?
		true
	end


	def out_of_bounds?(pos)
		pos.any? {|el| el < 0 || el > 7 }
	end

	def to_s
		@value
	end
end



class NullPiece < Piece

	def initialize
		@value = "   "
		@color = :none
	end


	def occupied?
		false
	end

	def show_moves(board)
		[]
	end




end



class Slidable < Piece

DIFFS = [[-1,0], [1,0], [0,-1], [0,1]]

DIAGONAL_DIFFS = [[-1,-1], [-1,1], [1,-1], [1,1]]

	def validate_move(end_pos, board)
		possible_positions = []
	  start_x = self.position[0]
		 start_y = self.position[1]


		self.class.diffs.each do |diffs|
			new_pos = [(diffs[0] + start_x), (diffs[1] + start_y)]
			until out_of_bounds?(new_pos) || board[new_pos].occupied?
				possible_positions << new_pos
				new_pos = [new_pos[0] + diffs[0], new_pos[1] + diffs[1]]
			end

		end

		return true if possible_positions.include?(end_pos)
		return false

	end

	def show_moves(board)
		possible_positions = []
		enemy_positions = []
		last_position = nil
	  start_x = self.position[0]
		start_y = self.position[1]


		self.class.diffs.each do |diffs|

			new_pos = [(diffs[0] + start_x), (diffs[1] + start_y)]
			until out_of_bounds?(new_pos) || board[new_pos].occupied?
				possible_positions << new_pos
				new_pos = [new_pos[0] + diffs[0], new_pos[1] + diffs[1]]
			end
			unless out_of_bounds?(new_pos)
				if (board[new_pos].color != self.color && board[new_pos].occupied?)
					enemy_positions << new_pos
				end
			end
		end
		possible_positions + enemy_positions
	end







end

class Rook < Slidable

#	DIFFS = [[-1,0], [1,0], [0,-1], [0,1]]

	def self.diffs
		DIFFS
	end


	def initialize(position, color)
		@position = position
		@color = color

		case color
		when :black
			@value = " " + "\u265C".encode("utf-8") + " "
		when :white
			@value = " " + "\u2656".encode("utf-8") + " "
		end

	end






end



class Bishop < Slidable

	#DIFFS = [[-1,-1], [-1,1], [1,-1], [1,1]]

	def self.diffs
		DIAGONAL_DIFFS
	end


	def initialize(position, color)
		@position = position
		@color = color

		case color
		when :black
			@value = " " + "\u265D".encode("utf-8") + " "
		when :white
			@value = " " + "\u2657".encode("utf-8") + " "
		end

	end

end



class Queen < Slidable

	# DIFFS = [[-1,0], [1,0], [0,-1], [0,1], [-1,-1], [-1,1], [1,-1], [1,1]]

	def self.diffs
		DIFFS + DIAGONAL_DIFFS
	end

		def initialize(position, color)
		@position = position
		@color = color

		case color
		when :black
			@value = " " + "\u265B".encode("utf-8") + " "
		when :white
			@value = " " + "\u2655".encode("utf-8") + " "
		end

	end

end



class Steppable < Piece

	KNIGHT_DIFFS = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, 2], [1, -2], [2, -1], [2, 1]]
	KING_DIFFS = [[-1,0], [1,0], [0,-1], [0,1], [-1,-1], [-1,1], [1,-1], [1,1]]

	def validate_move(end_pos, board)
		return true if show_moves(board).include?(end_pos)
		return false
		# return tru
		# start_x = self.position[0]
		# start_y = self.position[1]
		# possible_moves = self.class.diffs.map do |el|
		# 	[ el[0] + start_x, el[1] + start_y ]
		# end
		# possible_moves.each do |move|
		# 	possible_moves.delete(move) if board[move].occupied? || out_of_bounds?(move)
		# end
		#
		# return true if possible_moves.include?(end_pos)
		# return false
	end

	def show_moves(board)
		start_x = self.position[0]
		start_y = self.position[1]
		possible_moves = self.class.diffs.map do |diffs|
			[ diffs[0] + start_x, diffs[1] + start_y ]
		end
		possible_moves.reject! do |move|
			(out_of_bounds?(move) || (board[move].occupied? && board[move].color == self.color))
		end

		possible_moves
	end

end



class Knight < Steppable

	def self.diffs
		KNIGHT_DIFFS
	end


	def initialize(position, color)
		@position = position
		@color = color

		case color
		when :black
			@value = " " + "\u265E".encode("utf-8") + " "
		when :white
			@value = " " + "\u2658".encode("utf-8") + " "
		end

	end


end

class King < Steppable


		def self.diffs
			KING_DIFFS
		end


		def initialize(position, color)
		@position = position
		@color = color

		case color
		when :black
			@value = " " + "\u265A".encode("utf-8") + " "
		when :white
			@value = " " + "\u2654".encode("utf-8") + " "
		end

	end

end


class Pawn < Piece

	BLACK_DIFFS = [[-1, 1], [-1, -1]]
	WHITE_DIFFS = [[1, 1], [1, -1]]



	def initialize(position, color)
		@position = position
		@color = color

		case color
		when :black
			@value = " " + "\u265F".encode("utf-8") + " "
		when :white
			@value = " " + "\u2659".encode("utf-8") + " "
		end

	end


	def validate_move(end_pos, board)
		return true if show_moves(board).include?(end_pos)
		return false
	end


	def show_moves(board)
		start_x = self.position[0]
		start_y = self.position[1]
		possible_moves = []
		case color
		when :black
			if start_x == 6
				possible_moves << [start_x - 2, start_y]
			end
		possible_moves << [start_x -1, start_y]
		when :white
			if start_x == 1
				possible_moves << [start_x + 2, start_y]
			end
		possible_moves << [start_x + 1, start_y]
		end
		possible_moves.reject! {|pos| board[pos].occupied?}

		case color
		when :black
			BLACK_DIFFS.each do |diff|
				new_pos = [(diff[0] + start_x), (diff[1] + start_y)]
				if board[new_pos].occupied? && (board[new_pos].color != self.color)
					possible_moves << new_pos
				end
			end
		when :white
			WHITE_DIFFS.each do |diff|
				new_pos = [(diff[0] + start_x), (diff[1] + start_y)]
				if board[new_pos].occupied? && (board[new_pos].color != self.color)
					possible_moves << new_pos
				end
			end
		end

		possible_moves
	end

end
