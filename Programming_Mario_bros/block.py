class Blocks:
    def __init__(self, x: int, y: int, block: str):
        self.x = x
        self.y = y
        self.block = block
        if self.block == "solid":
            self.sprite = (0, 16, 64, 16, 16)
        elif self.block == "question":
            self.sprite = (0, 0, 0, 16, 16)
        elif self.block == "breakable":
            self.sprite = (0, 16, 0, 16, 16)
        elif self.block == "unbreakable 1":
            self.sprite = (2, 0, 64, 64, 64)
        elif self.block == "unbreakable 2":
            self.sprite = (2, 80, 64, 64, 64)
        elif self.block == "unbreakable 3":
            self.sprite = (2, 0, 0, 16, 64)
        elif self.block == "unbreakable 4":
            self.sprite = (2, 0, 0, 64, 64)
        elif self.block == "unbreakable 5":
            self.sprite = (2, 0, 0, 16, 16)






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
def coin(self):
    return self.__coin

@coin.setter
def coin(self, coin):
    if type(coin) != int:
        raise TypeError()
    else:
        self.__coin = coin