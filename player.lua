-- Estado del jugador
local p = {}

function player_init()
  p.x = 96         -- Centro horizontal (192/2)
  p.y = 100        -- Cerca del suelo
  p.sp = 1         -- Sprite del caracol
  p.humedad = 100  -- Barra de recurso principal
  p.vivo = true
end

function player_update()
  if not p.vivo then return end

  local moved = false
  if btn(0) then p.x = p.x - 1; moved = true end  -- Izquierda
  if btn(1) then p.x = p.x + 1; moved = true end  -- Derecha
  if btn(2) then p.y = p.y - 1; moved = true end  -- Arriba
  if btn(3) then p.y = p.y + 1; moved = true end  -- Abajo

  -- Consumo de humedad al moverse
  if moved then
    p.humedad = p.humedad - 0.2
  end

  if p.humedad <= 0 then
    p.vivo = false
  end
end

function player_draw()
  if not p.vivo then
    print("GAME OVER", 70, 60, 8)
    return
  end
  spr(p.sp, p.x, p.y)
end

-- Acceso externo (para colisiones, trail, etc.)
function player_get()
  return p
ends