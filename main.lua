-- Carga todos los módulos
require("art")
require("player")
require("trail")
require("collectibles")
require("hazards")
require("camera")
require("ui")

function _init()
  generar_arte()   -- Inyecta sprites en RAM
  player_init()
  trail_init()
  collectibles_init()
  hazards_init()
  camera_init()
end

function _update()
  player_update()
  trail_update()
  collectibles_update()
  hazards_update()
  camera_update()
end

function _draw()
  cls(1)           -- Limpia pantalla (azul oscuro = fondo)
  trail_draw()
  collectibles_draw()
  hazards_draw()
  player_draw()
  ui_draw()
end