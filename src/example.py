from math import *

def calculate(expression):
    try:
        return (True, eval(expression, globals()))
    except:
        return (False, 0)
        