require_relative 'board.rb'
require_relative 'player.rb'
require "byebug"

class Game
	attr_accessor :board, :display, :player

	def initialize
		@board = Board.new(true)
		@display = Display.new(@board)
		@player1 = Player.new(:white)
		@player2 = Player.new(:black)
		@current_player = @player1
	end


	def play

		# until game_over
		# play_game
		#
		# goodbye
		while(true)
			# system "clear"
			display.render
			pos = display.get_input
			move_loop
			switch_player
		end
	end

	private

	def move_loop
		puts "#{@current_player}, please make a move"
		start_pos, end_pos = @current_player.get_move(display)
		until board[start_pos].occupied? && (board[start_pos].color == @current_player.color)
			puts "Sorry, that was not a valid move. Please try again"
			start_pos, end_pos = @current_player.get_move(display)
		end
		board.move(start_pos, end_pos)
	end

	def switch_player
		if @current_player == @player1
			@current_player = @player2
		else
			@current_player = @player1
		end
	end




	#def play_game
	#get_move

	# def get_move
	# 	puts "Press space to choose starting and ending positions"
	# 	pos1 = @display.get_input if @display.get_input.class == Array
	# 	pos2 = @display.get_input if @display.get_input.class == Array
	# 	@grid.move(pos1, pos2)
	# end

	#def game_over
		#checkmate?
	#end




end
