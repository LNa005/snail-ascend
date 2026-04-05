require("art")

function _init()
  generar_arte()
  p = {
    x=64, y=110, sp=1, hum=100,
    w=8, h=8, on_wall=false, flp=false
  }
  cam_y = 0
  baba = {}
  for i=0,15 do mset(i,15,4) end
  for i=0,8 do
    mset(10-i, 14-i, 4)
    mset(5+i,  14-i, 4)
  end
end

function _update()
  if btn(0) then p.x=p.x-1 p.flp=true  end
  if btn(1) then p.x=p.x+1 p.flp=false end

  p.on_wall = false
  if fget(mget((p.x-1)/8, p.y/8),0) or
     fget(mget((p.x+8)/8, p.y/8),0) then
    p.on_wall = true
  end

  if p.on_wall and btn(2) then p.y=p.y-1 end

  if btn(0) or btn(1) or (p.on_wall and btn(2)) then
    table.insert(baba, {x=p.x+3, y=p.y+7})
    if #baba > 50 then table.remove(baba,1) end
    p.hum = p.hum - 0.05
  end

  if p.hum < 0 then p.hum = 0 end
  if p.y < cam_y+40 then cam_y = p.y-40 end
  if cam_y > 0 then cam_y = 0 end
end

function _draw()
  cls(0)
  camera(0, cam_y)
  map(0,0)
  for i,pt in ipairs(baba) do
    pset(pt.x, pt.y, 11)
  end
  spr(p.sp, p.x, p.y, 1, 1, p.flp)
  camera(0,0)
  rectfill(4,4,104,8,5)
  rectfill(4,4, 4+p.hum, 8, 11)
  print("HUM", 4, 10, 7)
end