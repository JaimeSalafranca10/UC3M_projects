class Pipes:
    def __init__(self, x: int, y: int, type_of_pype: str):
        self.x = x
        self.y = y
        self.type_of_pipe = type_of_pype

    @property
    def sprite(self):
        if self.type_of_pipe == "top":
            return 1, 0, 48, 32, 32
        else:
            return 1, 0, 64, 32, 16

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