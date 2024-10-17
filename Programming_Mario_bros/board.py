from mario import Mario
from block import Blocks
from enemy import Enemy
from pipes import Pipes
from object_board import ObjectBoard
from star import Star
from timer import Timer
import random
import pyxel


class Board:
    """ This class contains all the information needed to represent the
    board"""
    def __init__(self, w: int, h: int):
        """ The parameters are the width and height of the board"""
        self.width = w
        self.height = h
        self.coins = 0
        self.level = " 1-1 "
        self.time = Timer()
        # This creates a Mario at the middle of the screen in x and at y = 200
        # facing right
        self.mario = Mario(self.width/2, 208)
        self.end = True
        listenems = []

        for number_enemy in range(4):
            xenem = random.randint(0, 250)
            yenem = 208
            listenems.append(Enemy(xenem, yenem, 100))

        self.enemy = listenems
        self.bush = [ObjectBoard(100, 208, "bush"), ObjectBoard(200, 208, "bush")]
        self.little_coin = ObjectBoard(93, 21, "little_coin")
        self.star= []
        # In this part we create a list of blocks printed

        yblck = 208
        listfloor = []
        void = [78, 79, 95, 96, 97, 162, 163]
        for i in range(25):
            h = random.randrange(25, 2000)
            void += [range(h, h+32)]

        # In this part we create a list of blocks printed
        yblck = 208
        listfloor = []
        void = [78, 79, 95, 96, 97, 162, 163]
        while yblck < 256:
            yblck += 16
            xblck = 0
            nblock = 0
            while nblock < 225:
                if nblock not in void:
                    listfloor.append(Blocks(xblck, yblck, "solid"))
                    xblck += 16
                    nblock += 1
                else:
                    xblck += 16
                    nblock += 1
        self.block = listfloor

        #drawing mountains
        small_mountain_Yes = [25, 73, 119, 168, 217]
        big_mountain_Yes = [9, 57, 105, 153, 201]
        small_mountain = []
        big_mountain = []
        for i in small_mountain_Yes:
            small_mountain.append(ObjectBoard(i*16, 192, "little mountain"))
        self.little_mountain = small_mountain
        for i in big_mountain_Yes:
            big_mountain.append(ObjectBoard(i*16, 176, "big mountain"))
        self.big_mountain = big_mountain

        # drawing pypes
        self.pipes = [Pipes(37*16, 192, "top"), Pipes(47*16, 176, "top"),
                         Pipes(55*16, 160, "top"), Pipes(66*16, 160, "top"),
                         Pipes(188*16, 192, "top"), Pipes(172*16, 192, "top"),
                         Pipes(47*16, 208, "bottom"), Pipes(55*16, 192, "bottom"),
                         Pipes(66*16, 192, "bottom"), Pipes(55*16, 208, "bottom"),
                         Pipes(66*16, 208, "bottom")]
        for element in self.pipes:
            self.block.append(element)

        # drawaing bush
        self.bush = [ObjectBoard(520, 208, "single bush"), ObjectBoard(1288, 208, "single bush"),
                     ObjectBoard(2056, 208, "single bush"), ObjectBoard(2824, 208, "single bush"),
                     ObjectBoard(328, 208, "triple bush"), ObjectBoard(1096, 208, "triple bush"),
                     ObjectBoard(1832, 208, "triple bush"), ObjectBoard(808, 208, "double bush"),
                     ObjectBoard(1576, 208, "double bush"), ObjectBoard(2344, 208, "double bush")]

        # drawing scaleras
        self.stairs = [Blocks(143*16, 160, "unbreakable 1"), Blocks(157*16, 160, "unbreakable 1"),
                       Blocks(190*16, 160, "unbreakable 1"), Blocks(149*16, 160, "unbreakable 2"),
                       Blocks(164*16, 160, "unbreakable 2"), Blocks(161*16, 160, "unbreakable 3"),
                       Blocks(194*16, 96, "unbreakable 1"), Blocks(198*16, 96, "unbreakable 3"),
                       Blocks(194*16, 160, "unbreakable 4"), Blocks(198*16, 160, "unbreakable 3"),
                       Blocks(207*16, 208, "unbreakable 5")]

        for element in self.stairs:
            self.block.append(element)
        # drawing castle and flag
        self.ending = [ObjectBoard(207*16, 192, "pole"), ObjectBoard(207*16, 176, "pole"),
                       ObjectBoard(207*16, 160, "pole"), ObjectBoard(207*16, 144, "pole"),
                       ObjectBoard(207*16, 128, "pole"), ObjectBoard(207*16, 112, "pole"),
                       ObjectBoard(207*16, 96, "pole"), ObjectBoard(207*16, 80, "pole"),
                       ObjectBoard(207*16, 64, "poletop"), ObjectBoard(3304, 80, "flag"),
                       ObjectBoard(211*16, 128, "castle")]

        self.question_blocks = [Blocks(25*16, 160, "question"), Blocks(30*16, 160, "question"),
                                Blocks(32*16, 160, "question"), Blocks(31*16, 96, "question"),
                                Blocks(87*16, 160, "question"), Blocks(103*16, 96, "question"),
                                Blocks(115*16, 160, "question"), Blocks(118*16, 160, "question"),
                                Blocks(118*16, 96, "question"), Blocks(121*16, 160, "question"),
                                Blocks(139*16, 96, "question"), Blocks(140*16, 96, "question"),
                                Blocks(115*16, 160, "question"), Blocks(179*16, 160, "question")]

        for element in self.question_blocks:
            self.block.append(element)

        self.breakable_blocks = [Blocks(29*16, 160, "breakable"), Blocks(31*16, 160, "breakable"),
                                 Blocks(33*16, 160, "breakable"), Blocks(88*16, 160, "breakable"),
                                 Blocks(86*16, 160, "breakable"), Blocks(89*16, 96, "breakable"),
                                 Blocks(90*16, 96, "breakable"), Blocks(91*16, 96, "breakable"),
                                 Blocks(92*16, 96, "breakable"), Blocks(93*16, 96, "breakable"),
                                 Blocks(94*16, 96, "breakable"), Blocks(95*16, 96, "breakable"),
                                 Blocks(96*16, 96, "breakable"), Blocks(100*16, 96, "breakable"),
                                 Blocks(101*16, 96, "breakable"), Blocks(102*16, 96, "breakable"),
                                 Blocks(103*16, 160, "breakable"), Blocks(109*16, 160, "breakable"),
                                 Blocks(110*16, 160, "breakable"), Blocks(124*16, 160, "breakable"),
                                 Blocks(127*16, 96, "breakable"), Blocks(128*16, 96, "breakable"),
                                 Blocks(129*16, 96, "breakable"), Blocks(138*16, 96, "breakable"),
                                 Blocks(141*16, 96, "breakable"), Blocks(139*16, 160, "breakable"),
                                 Blocks(140*16, 160, "breakable"), Blocks(177*16, 160, "breakable"),
                                 Blocks(178*16, 160, "breakable"), Blocks(180*16, 160, "breakable")]

        for element in self.breakable_blocks:
            self.block.append(element)

        # drawing clouds
        self.clouds = [ObjectBoard(29*16, 40, "small cloud"), ObjectBoard(37*16, 56, "big cloud"),
                       ObjectBoard(55*16, 40, "small cloud"), ObjectBoard(66*16, 44, "small cloud"),
                       ObjectBoard(77*16, 40, "small cloud"), ObjectBoard(83*16, 56, "big cloud"),
                       ObjectBoard(89*16, 40, "small cloud"), ObjectBoard(114*16, 40, "small cloud"),
                       ObjectBoard(124*16, 40, "small cloud"), ObjectBoard(130*16, 54, "big cloud"),
                       ObjectBoard(143*16, 40, "small cloud"), ObjectBoard(162*16, 40, "small cloud"),
                       ObjectBoard(29*16, 40, "small cloud"), ObjectBoard(172*16, 40, "small cloud"),
                       ObjectBoard(180*16, 56, "big cloud"), ObjectBoard(209*16, 40, "small cloud"),
                       ObjectBoard(199*16, 40, "small cloud")]

    def moveboard(self):
        for element in self.block:
            element.x -= 2
        for element in self.clouds:
            element.x -= 2
        for element in self.little_mountain:
            element.x -= 2
        for element in self.big_mountain:
            element.x -= 2
        for element in self.bush:
            element.x -= 2
        for star in self.star:
            star.x -= 2
        for enemy in self.enemy:
            enemy.x -= 2
        for element in self.ending:
            element.x -= 2

    def col(self):
        for element in self.mario.colision.keys():
            self.mario.colision[str(element)] = False
        for block in self.block:

            if type(element) == "pipes.Pipe":
                for i in range (0,1):
                    if ((block.x) // 16) -i  == (self.mario.x) // 16 and (self.mario.y) // 16 == (block.y - 16) // 16:
                        self.mario.gravity = False
                        self.mario.colision["down"] = True

                    if block.y // 16 == (self.mario.y) // 16 and (self.mario.x) // 16 == (block.x - 16) // 16:
                        self.mario.colision["right"] = True

                    if block.y // 16 == (self.mario.y) // 16 and (self.mario.x) // 16 == (block.x + 16) // 16:
                        self.mario.colision["left"] = True



            if (block.x)//16 == (self.mario.x)//16 and (self.mario.y)//16 == (block.y - 16)//16:
                self.mario.gravity = False
                self.mario.colision["down"] = True


            if block.x //16 == self.mario.x//16  and self.mario.y//16  == (block.y)//16 :
                self.mario.colision["up"] = True
                if block in self.question_blocks:
                    if block.sprite != (0, 32, 0, 16, 16):
                        self.star.append(Star(block.x, block.y-16))
                    block.sprite = (0, 32, 0, 16, 16)
                if block in self.breakable_blocks:
                    self.block.remove(block)

            if block.y//16 == (self.mario.y)//16 and (self.mario.x)//16 == (block.x )//16:
                self.mario.colision["right"] = True

            if block.y//16 == (self.mario.y)//16 and (self.mario.x)//16 == (block.x + 16)//16:
                self.mario.colision["left"] = True


    def colenemy(self):

        for enemy in self.enemy:

            if enemy.x //16 == self.mario.x//16  and self.mario.y//16  == (enemy.y-16)//16 :
                self.enemy.remove(enemy)
                count = 0
            if enemy.y//16 == (self.mario.y)//16 and (self.mario.x)//16 == (enemy.x )//16:
                #self.mario.lives -= 1
                self.mario.colisionenem = False

    def colobject(self):
        for star in self.star:

            if star.x//16  == self.mario.x//16  and self.mario.y//16  == (star.y)//16:
                if star.name == "coin":
                    self.coins += 1
                self.star.remove(star)

    def update(self):
        if self.time.actual_count != 0:
            if self.mario.x != self.stairs[-1].x:
                self.time.counter()
            else:
                self.time.quickcounter()
        self.colobject()
        self.col()
        self.colenemy()
        self.mario.fall()

        if pyxel.btnp(pyxel.KEY_Q) or self.mario.y > 250 or self.mario.lives < 0:
            pyxel.quit()


        """ if pyxel.btn(pyxel.KEY_UP):
            self.mario.pyxelcount = pyxel.frame_count
            if pyxel.frame_count < self.mario.pyxelcount+100:
                self.mario.jump = True
                self.mario.jump_up()
            else:
                self.mario.jump = False """
        if pyxel.btn(pyxel.KEY_UP) and not self.mario.gravity and not self.mario.colisionenem:
            self.mario.jumping = True
        if self.mario.colision["up"]:
            self.mario.jumping = False
        if self.mario.jumping and not self.mario.colision["up"]:
            self.col()
            self.mario.jump()

        if pyxel.btn(pyxel.KEY_RIGHT)  and not self.mario.colisionenem:
            if not self.mario.colision["right"]:
                if not self.mario.displacement and self.mario.x != self.stairs[-1].x:
                    self.moveboard()
                self.mario.direction = True
                self.mario.move(True, self.width)

        elif pyxel.btn(pyxel.KEY_LEFT) and not self.mario.colisionenem:
            if not self.mario.colision["left"]:
                self.mario.direction = False
                self.mario.move(False, self.width)

        elif pyxel.btn(pyxel.KEY_SPACE):
            for i in range(3):
                self.mario.y -= 1

        #hay que arreglarlooooo
        if self.mario.x == self.stairs[-1].x and self.end:
            for i in range(100000):
                self.ending[9].y -= 0.001
            self.end = False

    def draw(self):
        pyxel.cls(6)
        pyxel.text(33, 16, "MARIO", 7)
        pyxel.text(33, 22, self.mario.score, 7)
        pyxel.text(100, 22, str(self.coins), 7)
        pyxel.text(145, 16, "WORLD", 7)
        pyxel.text(145, 22, self.level, 7)
        pyxel.text(213, 16, "TIME", 7)
        pyxel.text(217, 22, str(self.time.actual_count), 7)
        for enemy in self.enemy:
            enemy.x = enemy.x - pyxel.frame_count // 1000

        # We draw Mario taking the values from the mario object
        # Parameters are x, y, image bank, the starting x and y and the size

        for element in self.block:
            pyxel.blt(element.x, element.y, *element.sprite, colkey=6)

        for element in self.ending:
            pyxel.blt(element.x, element.y, *element.sprite, colkey=6)
        for element in self.bush:
            pyxel.blt(element.x, element.y, *element.sprite, colkey=6)
        for element in self.clouds:
            pyxel.blt(element.x, element.y, *element.sprite, colkey = 6)
        for element in self.little_mountain:
            pyxel.blt(element.x, element.y, *element.sprite, colkey=6)
        for element in self.big_mountain:
            pyxel.blt(element.x, element.y, *element.sprite, colkey=6)

        for star in self.star:
            pyxel.blt(star.x, star.y, *star.sprite, colkey=6)

        for enemy in self.enemy:
            pyxel.blt(enemy.x, enemy.y, *enemy.sprite, colkey=6)

        pyxel.blt(self.little_coin.x, self.little_coin.y, *self.little_coin.sprite, colkey=6)
        pyxel.blt(self.mario.x, self.mario.y, *self.mario.sprite, colkey=6)





