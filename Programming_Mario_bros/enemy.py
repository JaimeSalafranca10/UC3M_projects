import random


class Enemy:
    def __init__(self, x: int, y: int, life: int):
        self.x = x
        self.counter = 0
        self.y = y
        self.life = life
        self.direction = "right"
        self.counter = 0
        type_enemy = random.randint(0, 1)
        if type_enemy == 0:
            self.sprite = (0, 48, 16, 16, 16)
        elif type_enemy == 1:
            self.sprite = (0, 16, 32, 16, 16)
        self.gravity = True

    def fall(self):
        vel = 2
        if self.gravity == True:
            self.y += 1*vel
        else:
            self.gravity = True








@property
def x(self):
    return self.__x


@x.setter
def x(self, x):
    if type(x) != int:
        raise TypeError()
    elif x > 256 or x < 0:
        raise ValueError()
    else:
        self.__x = x


@property
def y(self):
    return self.__y


@y.setter
def y(self, y):
    if type(y) != int:
        raise TypeError()
    elif y > 256 or y < 0:
        raise ValueError()
    else:
        self.__y = y


@property
def life(self):
    return self.__life


@life.setter
def life(self, life):
    if type(life) != int:
        raise TypeError()
    else:
        self.__life = life
