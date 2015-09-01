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
		pos.any? {|el| el < 0 || el > 8 } 
	end

	def to_s
		@value 
	end
end



class NullPiece < Piece 

	def initialize
		@value = "   "
	end


	def occupied? 
		false
	end


	

end



class Slidable < Piece

HORIZONTAL_DIFFS = [[-1,0], [1,0], [0,-1], [0,1]]

DIAGONAL_DIFFS = [[-1,-1], [-1,1], [1,-1], [1,1]] 

def validate_move(end_pos, board, orientation)
		possible_positions = [] 
		self.position[0] = start_x
		self.position[1] = start_y 


		DIFFS.each do |arr|
			new_pos = [(arr[0] + start_x), (arr[1] + start_y)]
			until board[new_pos].occupied? || out_of_bounds?(new_pos) 
				possible_positions << new_pos 
				new_pos = [new_pos[0] + start_x, new_pos[1] + start_y]
			end

		end

		return true if possible_positions.include?(end_pos)
		return false 

	end
end

class Rook < Slidable

	DIFFS = [[-1,0], [1,0], [0,-1], [0,1]]

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

	DIFFS = [[-1,-1], [-1,1], [1,-1], [1,1]] 

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

	DIFFS = [[-1,0], [1,0], [0,-1], [0,1], [-1,-1], [-1,1], [1,-1], [1,1]]

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

	def validate_move(end_pos, board)
		self.position[0] = start_x
		self.position[1] = start_y
		possible_moves = DIFFS.map do |el|
			[ el[0] + start_x, el[1] + start_y ]
		end
		possible_moves.each do |move|
			possible_moves.delete(move) if board[move].occupied? || out_of_bounds?(move) 
		end

		return true if possible_moves.include?(end_pos)
		return false 
	end
end



class Knight < Steppable 
	DIFFS = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, 2], [1, -2], [2, -1], [2, 1]] 

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
	DIFFS = [[-1,0], [1,0], [0,-1], [0,1], [-1,-1], [-1,1], [1,-1], [1,1]]

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

end





	










	

	








