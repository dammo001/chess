require_relative 'piece.rb' 
require 'colorize'

class Board

	def initialize
		@grid = Array.new(8) { Array.new(8) } 
		set_board
	end

	def set_board
		@grid.each_with_index do |row,idx|
			row.each_with_index do |el,idx2|
				@grid[idx][idx2] = Piece.new
			end
		end
	end

	def display
		@grid.each do |row|
			row.each do |el|
				print "#{el.value}"  + "  "
			end
		end


	end

		



end

