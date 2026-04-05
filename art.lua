function generar_arte()
  local caracol_hex = "0000000000000000000333330000000344444300000341114300000344444300000333333000000000000000"
  local gota_hex    = "0000000000000013000000000001333331000013133333100001313331111000013331111000001111110000"
  local pared_hex   = "5555555555555555555555555555555555555555555555555555555555555555"
  local sal_hex     = "0000000000000000000666000000006777600000667776600000677777600000666766600000006660000000"
  local lechuga_hex = "0000000000000011100000011111100001111111100000113331100000033333300000033333300000003333000"

  import_sprite_hex(1, caracol_hex)
  import_sprite_hex(3, gota_hex)
  import_sprite_hex(4, pared_hex)
  import_sprite_hex(5, sal_hex)
  import_sprite_hex(6, lechuga_hex)
  set_flag(4, 0, true)
end

function import_sprite_hex(id, hex)
  local addr = 0x4000 + (id * 32)
  for i = 1, #hex, 2 do
    local val = tonumber(hex:sub(i, i+1), 16)
    if val then poke(addr + (i-1)/2, val) end  -- FIX: guard nil
  end
end

function set_flag(sprite_id, flag_id, value)
  poke(0x3000 + sprite_id,
    bitwise_setflag(peek(0x3000 + sprite_id), flag_id, value))  -- FIX: peek no peeking
end

function bitwise_setflag(byte, flag, val)
  local mask = 2 ^ flag
  if val then return byte + mask
  else return byte - mask end
end