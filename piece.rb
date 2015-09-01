class Piece 

	attr_reader  :value, :color
	attr_accessor :position

	def initialize
		@occupied = false
		@value = 0
	end

	def out_of_bounds?(pos)
		pos.any? {|el| el < 0 || el > 8 } 
	end


end

class Slidable < Piece

HORIZONTAL_DIFFS = [[-1,0], [1,0], [0,-1], [0,1]]

DIAGONAL_DIFFS = [[-1,-1], [-1,1], [1,-1], [1,1]] 

end

class Rook < Slidable

	def validate_move(end_pos, board)
		possible_positions = [] 
		self.position[0] = start_x
		self.position[1] = start_y 


		HORIZONTAL_DIFFS.each do |arr|
			new_pos = [(arr[0] + start_x), (arr[1] + start_y)]
			until board[new_pos].occupied? || out_of_bounds?(new_pos) 
				possible_positions << new_pos 
				new_pos = [new_pos[0] + start_x, new_pos[1] + start_y]
			end

		end

		return true if possible_positions.include?(end_pos)
		return false 

	end




	

	








