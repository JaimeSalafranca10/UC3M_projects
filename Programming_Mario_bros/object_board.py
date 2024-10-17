class ObjectBoard:
    """This class stores the information for objects that we
    are using in the game"""
    def __init__(self, x:int, y:int, object:str):
        """This method creates the obejcts
        @param.x gives an x initial position
        @param.y gives a y initial position
        @param.object gives the type of object
        """
        self.x = x
        self.y = y
        self.object = object

    @property
    def sprite(self):
        """This method defines the sprite the object will have
        depending on what object it is"""
        if self.object == "small cloud":
            return 0, 0, 80, 32, 32
        elif self.object == "big cloud":
            return 0, 144, 32, 72, 32
        elif self.object == "breakable":
            return 0, 16, 0, 16, 16
        elif self.object == "single bush":
            return 0, 32, 96, 32, 16
        elif self.object == "double bush":
            return 0, 0, 112, 48, 16
        elif self.object == "triple bush":
            return 1, 0, 32, 64, 16
        elif self.object == "little mountain":
            return 1, 0, 0, 48, 32
        elif self.object == "big mountain":
            return 1, 0, 80, 80, 48
        elif self.object == "little_coin":
            return 0, 32, 48, 7, 7
        elif self.object == "castle":
            return 0, 64, 32, 80, 96
        elif self.object == "pole":
            return 0, 96, 16, 16, 16
        elif self.object == "poletop":
            return 0, 96, 0, 16, 16
        elif self.object == "flag":
            return 0, 80, 0, 16, 16

