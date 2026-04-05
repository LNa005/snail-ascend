-- HUD: barra de humedad y puntuación
function ui_draw()
  local p = player_get()

  -- Barra de humedad (arriba a la izquierda)
  print("HUM:", 2, 2, 7)
  rect(30, 2, 100, 8, 5)                                    -- Fondo gris
  rectfill(30, 2, 30 + p.humedad, 8, 12)                   -- Relleno azul

  -- Texto de humedad
  print(math.floor(p.humedad).."%", 104, 2, 7)
end