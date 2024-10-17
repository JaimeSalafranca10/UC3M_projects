class Timer:
    def __init__(self):
        self.started_counter = False
        self.actual_count = 400
        self.start_time = 0
        self.time_elapsed = 0


    def counter(self):
        import time
        if not self.started_counter:
            self.start_time = time.time()
        if self.time_elapsed < 1:
            end = time.time()
            self.time_elapsed = end - self.start_time
            self.started_counter = True
        else:
            self.started_counter = False
            self.actual_count -= 1
            self.time_elapsed = 0

    def quickcounter(self):
        import time
        if not self.started_counter:
            self.start_time = time.time()
        if self.actual_count < 1:
            end = time.time()
            self.time_elapsed = end - self.start_time
            self.started_counter = True
        else:
            self.started_counter = False
            self.actual_count -= 1
            self.time_elapsed = 0


