-- Gotas de agua coleccionables
local gotas = {}

function collectibles_init()
  -- Genera 5 gotas en posiciones aleatorias
  gotas = {}
  for i = 1, 5 do
    table.insert(gotas, {
      x = rnd(180),
      y = rnd(100),
      activa = true
    })
  end
end

function collectibles_update()
  local p = player_get()
  for _, g in ipairs(gotas) do
    if g.activa then
      -- Colisión AABB simple (8x8)
      if math.abs(p.x - g.x) < 8 and math.abs(p.y - g.y) < 8 then
        g.activa = false
        p.humedad = math.min(100, p.humedad + 25)
      end
    end
  end
end

function collectibles_draw()
  for _, g in ipairs(gotas) do
    if g.activa then
      spr(3, g.x, g.y)   -- Sprite gota (ID 3)
    end
  end
end