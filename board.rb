require_relative 'piece.rb'
require_relative 'display.rb'
require 'byebug'

require 'colorize'

class Board

	ROYALS = [:R, :B, :Kn, :Q, :K, :Kn, :B, :R]

	attr_accessor :grid

	def initialize(truth, grid = nil)
		@grid = Array.new(8) { Array.new(8) }
		if truth
			set_board
			place_royals
			place_pawns
			set_top_royals
			set_bottom_royals
		else
			@grid = grid
		end


	end


	def set_board
		@grid.each_with_index do |row,idx|
			row.each_with_index do |el,idx2|
				@grid[idx][idx2] = NullPiece.new
			end
		end
	end

	def place_royals
		ROYALS.each_with_index do |royal, idx|
			x = 0
			y = 0
			while y < 8
				if idx == y
				@grid[x][y] = royal
				end
			y += 1
			end
		end

		ROYALS.each_with_index do |royal, idx|
			x = 7
			y = 7
			while y >= 0
				if idx == y
				@grid[x][y] = royal
				end
			y -= 1
			end
		end
	end


	def set_top_royals
		@grid[0].each_with_index do |piece, col_num|
			case piece
				when :R
					@grid[0][col_num] = Rook.new([0, col_num], :white)
				when :B
					@grid[0][col_num] = Bishop.new([0, col_num], :white)
				when :Kn
					@grid[0][col_num] = Knight.new([0, col_num], :white)
				when :Q
					@grid[0][col_num] = Queen.new([0, col_num], :white)
				when :K
					@grid[0][col_num] = King.new([0, col_num], :white)
				end
		end
	end

	def set_bottom_royals
			@grid[7].each_with_index do |piece, col_num|
			case piece
				when :R
					@grid[7][col_num] = Rook.new([7, col_num], :black)
				when :B
					@grid[7][col_num] = Bishop.new([7, col_num], :black)
				when :Kn
					@grid[7][col_num] = Knight.new([7, col_num], :black)
				when :Q
					@grid[7][col_num] = Queen.new([7, col_num], :black)
				when :K
					@grid[7][col_num] = King.new([7, col_num], :black)
				end
		end
	end






	# def set_royals
	# 	@grid.each_with_index do |row, row_num|
	# 		row.each_with_index do |piece, col_num|
	# 			case piece
	# 			when :R
	# 				@grid[row_num][col_num] = Rook.new([row_num, col_num], :white)
	# 			when :B
	# 				@grid[row_num][col_num] = Bishop.new([row_num, col_num], :white)
	# 			when :Kn
	# 				@grid[row_num][col_num] = Knight.new([row_num, col_num], :white)
	# 			when :Q
	# 				@grid[row_num][col_num] = Queen.new([row_num, col_num], :white)
	# 			when :K
	# 				@grid[row_num][col_num] = King.new([row_num, col_num], :white)
	# 			# when :R && row_num == 7
	# 			# 	@grid[row_num][col_num] = Rook.new([row_num, col_num], :black)
	# 			# when :B && row_num == 7
	# 			# 	@grid[row_num][col_num] = Bishop.new([row_num, col_num], :black)
	# 			# when :Kn && row_num == 7
	# 			# 	@grid[row_num][col_num] = Knight.new([row_num, col_num], :black)
	# 			# when :Q && row_num == 7
	# 			# 	@grid[row_num][col_num] = Queen.new([row_num, col_num], :black)
	# 			# when :K && row_num == 7
	# 			# 	@grid[row_num][col_num] = King.new([row_num, col_num], :black)
	# 			end
	# 		end
	# 	end
	# end



	def place_pawns
		x = 1
		y = 0
		while y < 8
			@grid[x][y] = Pawn.new([x,y], :white )
		y += 1
		end

		x = 6
		y = 0
		while y < 8
			@grid[x][y] = Pawn.new([x,y], :black )
		y += 1
		end
	end

	def check_moves(pos)
		piece = self[pos]
		valid_moves = piece.show_moves(self)
		piece.check_for_check(self, valid_moves)
	end

	def [](pos)
		row, col = pos
		@grid[row][col]
	end

	def []=(pos, mark)
		row, col = pos
		@grid[row][col] = mark
	end

	def move(start, end_pos)
		if self[start].validate_move(end_pos, self)
			self[end_pos] = dup_piece(self[start], end_pos)
			self[start] = NullPiece.new
		end
	end

	def dup
		new_grid = @grid.map do |row|
			row.map do |piece|
				piece.dup
			end
		end
		Board.new(false, new_grid)
	end


	def move!(start, end_pos)
			self[end_pos] = dup_piece(self[start], end_pos)
			self[start] = NullPiece.new
	end


	def in_check?(color)
		king = find_king(color)
		@grid.flatten.any? do |piece|
			piece.show_moves(self).include?(king)
		end

	end



	def dup_piece(piece, pos)
		piece.class.new(pos, piece.color)
	end


	def find_king(color)
		found_king = nil
		get_kings.each do |king|
			found_king = king if king.color == color
		end

		found_king.position
	end



	def get_kings
		kings = []
		(0..7).each do |row|
			(0..7).each do |col|
				piece = @grid[row][col]
				if piece.is_a?(King)
					kings << piece
				end
			end
		end
		kings
	end


	def occupied?(pos)
		@grid[pos].occupied?
	end

	def in_bounds?(pos)
		return true if pos[0] >= 0 && pos[0] <= 8 && pos[1] >= 0 && pos[1] <= 8
	end


end
