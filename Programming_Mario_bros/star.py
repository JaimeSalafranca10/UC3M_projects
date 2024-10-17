import random
class Star:
    def __init__(self, x: int, y: int):
        self.x = x
        self.y = y
        aux = random.randint(1,10)
        if aux == 1:
            self.sprite = (0,0,16,16,16)
            self.name = "champi"
        if aux == 2:
            self.sprite = (0, 16, 16, 16, 16)
            self.name = "planta"
        if aux == 3:
            self.sprite = (0,32,16,16,16)
            self.name = "estrella"
        if aux > 3:
            self.sprite = (0,32,32,16,16)
            self.name = "coin"


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