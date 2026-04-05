-- Cristales de sal cayendo
local sales = {}

function hazards_init()
  sales = {}
  for i = 1, 3 do
    table.insert(sales, {
      x = rnd(184),
      y = rnd(40) - 40,       -- Empiezan fuera de pantalla arriba
      vel = 0.5 + rnd(1)
    })
  end
end

function hazards_update()
  local p = player_get()
  for _, s in ipairs(sales) do
    s.y = s.y + s.vel

    -- Recicla cuando sale por abajo
    if s.y > 130 then
      s.x = rnd(184)
      s.y = -8
    end

    -- Colisión con jugador
    if math.abs(p.x - s.x) < 7 and math.abs(p.y - s.y) < 7 then
      p.vivo = false
    end
  end
end

function hazards_draw()
  for _, s in ipairs(sales) do
    spr(5, s.x, s.y)   -- Sprite sal (ID 5)
  end
end