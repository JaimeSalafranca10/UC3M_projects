from board import Board
import pyxel

board = Board(256, 256)

# The first thing to do is to create the screen, see API for more parameters
pyxel.init(board.width, board.height, caption="This is super Mario")
# Loading the pyxres file, it has a 16x16 cat in (0,0) in bank 0
pyxel.load("my_resource.pyxres")
# Loading a 16x16 spaceship at bank 1 in (17,0)
# To start the game we invoke the run method with the update and draw functions
pyxel.run(board.update, board.draw)