class FireFlower:
    def __init__(self, x: int, y: int, life: int):
        self.x = x
        self.y = y
        self.life = life

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