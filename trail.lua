-- Rastro de baba circular
local trail = {}
local MAX = 20

function trail_init()
  trail = {}
end

function trail_update()
  local p = player_get()
  table.insert(trail, {x = p.x + 3, y = p.y + 6})
  if #trail > MAX then
    table.remove(trail, 1)
  end
end

function trail_draw()
  for i, pos in ipairs(trail) do
    local alpha = i / MAX   -- Más opaco al final
    if alpha > 0.5 then
      pset(pos.x, pos.y, 11)   -- Verde lima
    end
  end
end