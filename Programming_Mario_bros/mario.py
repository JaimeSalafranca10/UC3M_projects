import pyxel

class Mario:
    """ This class stores all the information needed for Mario"""

    def __init__(self, x: int, y: int):
        """ This method creates the Mario object
        @param x the starting x of Mario
        @param y the starting y of Mario
        """
        self.x = x
        self.y = y
        # initial direction right
        self.direction = True
        self.lives = 3
        self.score = "000000"
        # self displacement is used to see if we need to move mario or if we need to move the background
        self.displacement = False
        self.pyxelcount = 0
        # self jumping is used to see if mario must jump
        self.jumping = False
        # we use jump counter to fix the time for mario going up and going down
        self.jumpcounter = 0

        self.gravity = True
        self.colision = {"right": False, "left": False, "down": False, "up": False}
        self.colisionenem = False

    @property
    def sprite(self):
        """ This method attributes the sprite corresponding
        to the direction mario is looking"""

        if self.direction:
            # if direction is True (right) we get the right mario sprite
            return 0, 0, 48, 16, 16
        else:
            # if not we get the left looking sprite
            return 0, 16, 48, 16, 16

    def move(self, direction: bool, size: int):
        """ This method defines how mario will move right and left"""
        # we create a variable that stores the size of mario
        mario_x_size = self.sprite[3]
        # if mario's direction is right and he is on the left side of the screen
        # we set self displacement as negative and we change his x coordinate
        if self.direction:
            if self.x < ((size / 2) - mario_x_size):
                self.x = self.x + 4
                self.displacement = True
            else:
                self.displacement = False

        # if he is looking left he will always be able to move so we change his x coordinate
        elif not self.direction and self.x > 0:
            self.displacement = True
            self.x -= 4

    def fall(self):
        vel = 2
        if self.gravity == True and not self.colision["down"]:
            self.y += 1*vel
        elif self.colision["down"]:
            self.gravity = False
        else:
            self.gravity = True

    def jump(self):
        if self.colision["up"]:
            self.jumping = False

        if self.jumpcounter < 12 and not self.colision["up"]:
            self.gravity = False
            self.y -= 10
            self.jumpcounter += 1

        elif self.jumpcounter < 24 and not self.colision["down"]:
            self.fall()
            self.jumpcounter += 1
        else:
            self.jumpcounter = 0
            self.jumping = False

