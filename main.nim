import nico
import tables
import random
import sugar
# frame counter
var frame = 0
const X_Dim =64 
const Y_Dim =64 
const Scale_Fac =  8

type 
  Screen =  ref object 
    matr:seq[seq[int]] 
  SpriteLayers  = ref object
    planes :seq[Screen]
  SubSprite = ref object
    X_Up,Y_Up:int
    layer:int
    repr:Screen

#var GlobalSprites:seq[SubSprite]
#var GlobalSpritesTable:Table[string,SubSprite]

proc CreateBlankScreen(x_dim:int = X_Dim,y_dim:int = Y_Dim):Screen=
  var tmp : Screen
  tmp.matr.setLen(x_dim)
  for i in 0..tmp.matr.high() :
    tmp.matr[i].setLen(y_dim)
  return tmp 

proc CleanSector(pl:var Screen,rectangle:array[4,int] = [0,0,0,0])=
  var x_low  = rectangle[0]
  var x_high = rectangle[2] 
  var y_low  = rectangle[1]
  var y_high = rectangle[3]

  if rectangle == [0,0,0,0]:
    x_low = pl.matr.low()
    y_low = pl.matr[0].low()
    x_high = pl.matr.high()
    y_high = pl.matr[0].high()

  for x in x_low..x_high:
    for y in x_low..x_high:
      pl.matr[x][y] = 0
  return

proc MeldSpriteLayers(main_scr:var Screen, layers: ref SpriteLayers)=
  var la:int = layers.planes.len() - 1
  var full:bool = true
  while la > 0:
    full = true
    for x in 0..layers.planes[0].matr.high():
      for y in 0..layers.planes[0].matr[0].high():
        if main_scr.matr[x][y] == 0:
          full = false
          main_scr.matr[x][y] = layers.planes[la].matr[x][y] 
    if full:
      break
    dec(la)

proc InsertToLayer(layers: ref SpriteLayers, spr:SubSprite, layer:int,ofs:array[2,int]=[0,0])=
  const x = 0
  const y = 1
   
  var OriSprite:array[2,int] = [spr.X_Up + ofs[x],spr.Y_Up + ofs[y] ]
  var EndSprite:array[2,int] = [OriSprite[x] + spr.repr.matr.high(),
                                OriSprite[y] + spr.repr.matr[0].high() ]
  
  var OriBound:array[2,int] = [max]
  var EndBound:array[2,int]
  

  for x in 0..layers.planes[layer].matr.high():
    for y in 0..layers.planes[layer].matr[0].high():
      if 
  

  
  

  return

func InsertToLayer(layers: ref SpriteLayers, spr:SubSprite) = 


proc DrawScreen(board:Screen)=
  
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
nico.createWindow("nico", X_Dim, Y_Dim, Scale_Fac)

nico.run(gameInit, gameUpdate, gameDraw)

