require_relative 'board.rb'

class Game
	attr_accessor :grid, :display

	def initialize
		@grid = Board.new
		@display = Display.new(@grid)
	end


	def play
		while(true) 
			system "clear"
			display.render
			pos = display.get_input
		end
	end


end

