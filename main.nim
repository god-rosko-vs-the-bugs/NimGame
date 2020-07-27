import nico
import random
# frame counter
var frame = 0
var size_x =64 
var size_y =64 

type
  Matrix[W, H: static[int]] = object
    data:array[1..W, array[1..H, int]]

var tet: Matrix[25,10]
var loc_x:int=0
var loc_y:int=0
proc DrawScreen(board:Matrix)=
  for i in 1..board.H:
    for j in 1..board.W:
      nico.setColor(board.data[j][i])
      nico.pset(20+i,20+board.W-j);

proc gameInit() =
  loc_x = 1
  loc_y = 1

proc gameUpdate(dt: Pfloat) =
  if frame mod 10 == 0:
    tet.data[loc_x][loc_y] = rand(1..14)
    loc_y+=1
    if loc_y == 10:
      loc_x+=1
      loc_y=1
      if loc_x mod 25 == 0:
        loc_y=1
        loc_x=1
  frame+=1
proc gameDraw() =
  nico.cls()
  DrawScreen(tet)

nico.init("nico", "test")
integerScale(true)
nico.createWindow("nico", size_x, size_y, 8)

nico.run(gameInit, gameUpdate, gameDraw)

