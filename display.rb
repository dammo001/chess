require 'colorize'
require_relative 'cursorable'
require 'byebug'


class Display
	include Cursorable

	def initialize(board)
		@board = board
		@cursor_pos = [0,0]
	end

	def build_grid
		@board.grid.map.with_index do |row,i|
			build_row(row, i)
		end
	end

	def build_row(row, i)
		row.map.with_index do |piece, j|
			color_options = colors_for(i,j) #background
			piece.to_s.colorize(color_options)
		end
	end

	def colors_for(i, j)
		bg = :green if show_moves.include? ([i, j])

		if [i, j] == @cursor_pos
			bg = :light_red
		elsif (i + j).odd?
			bg ||= :light_blue
		else
			bg ||= :purple
		end
		{ background: bg, color: :white }
	end

	def render
		system("clear")
		puts "Chess"
		build_grid.each { |row| puts row.join}
	end

end
