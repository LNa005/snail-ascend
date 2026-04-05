-- Cámara con scroll vertical suave
local cam = {x = 0, y = 0}

function camera_init()
  cam.x = 0
  cam.y = 0
end

function camera_update()
  local p = player_get()
  -- Sigue al jugador verticalmente (centrado en Y=60)
  local target_y = p.y - 60
  cam.y = cam.y + (target_y - cam.y) * 0.1  -- Suavizado (lerp)
  camera(cam.x, cam.y)
end