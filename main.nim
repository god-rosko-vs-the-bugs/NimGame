import nico
import random
# frame counter
var frame = 0
var size_x = 128
var size_y = 128

type
  ball = object
    x,y: int
type
  mvector = object
    x,y: float

var movment: mvector
var obj_ball:ball
proc gameInit() =
  obj_ball.x = size_x div 2
  obj_ball.y = size_y div 2
  movment.x = 2
  movment.y = 1

proc gameUpdate(dt: Pfloat) =
  obj_ball.x = (obj_ball.x + movment.x).int
  obj_ball.y = (obj_ball.y + movment.y).int
  if obj_ball.x <= 0 or obj_ball.x >= size_x:
    movment.x = -movment.x 
  if obj_ball.y <= 0 or obj_ball.y >= size_y:
    movment.y = -movment.y

proc gameDraw() =
  #cls()
  setColor(10)
  pset(obj_ball.x,obj_ball.y)
# initialization
nico.init("nico", "test")

# we want a fixed sized screen with perfect square pixels
integerScale(true)
nico.createWindow("nico",size_x,size_y,4)

nico.run(gameInit, gameUpdate, gameDraw)

