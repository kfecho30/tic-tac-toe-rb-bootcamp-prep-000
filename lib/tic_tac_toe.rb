# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player = "X")
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  counter = 0
  while counter < 9
    turn(board)
    counter += 1
  end
end

WIN_COMBINATIONS = [
  [0,1,2], #top row win
  [3,4,5], #middle row win
  [6,7,8], #bottom row win
  [0,3,6], #first column win
  [1,4,7], #second column win
  [2,5,8], #third column win
  [0,4,8], #diagonal win
  [2,4,6] #diagonal win
]

def won?(board)
  won = false
  WIN_COMBINATIONS.detect do |combo|
    if board[combo[0]] == " "
      won = false
    elsif board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]]
      won = combo
    end
  end
  won
end

def full?(board)
  board.none?{|space| space == " "}
end

def draw?(board)
  won?(board) == false && full?(board) ? true : false
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board) != false
    board[won?(board)[0]]
  end
end
