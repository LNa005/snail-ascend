# 🐌 Snail Ascend: The Sticky Climb 🌱

> *"Cada pared es un camino. Cada gota, una segunda oportunidad."*

Un videojuego de plataformas vertical desarrollado en **una sola noche** como Game Jam personal. Controla a un caracol que asciende por paredes resbaladizas, gestiona su humedad y esquiva cristales de sal en caída libre. Hecho con amor, Lua y mostesito. 🍵

---

## 🧪 Stack Tecnológico

![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![LIKO-12](https://img.shields.io/badge/LIKO--12-Fantasy_Console-4CAF50?style=for-the-badge&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)
![Game Jam](https://img.shields.io/badge/Game_Jam-One_Night-8BC34A?style=for-the-badge)
![Status](https://img.shields.io/badge/Estado-En_Desarrollo-yellowgreen?style=for-the-badge)

| Tecnología | Uso |
|---|---|
| **LIKO-12** | Fantasy Console basada en Lua. Resolución 192×128, paleta de 16 colores, gestión de sprites y tilemap integrada. |
| **Lua 5.3** | Lenguaje principal. Toda la lógica del juego: física, scroll, colisiones y sistemas de recursos. |
| **Pixel Art 8×8** | Sprites diseñados manualmente en el editor interno de LIKO-12. |
| **GitHub** | Control de versiones y despliegue del portafolio. |

---

## 🎮 Concepto y Mecánicas

Snail Ascend es un juego de **supervivencia técnica** en scrolling vertical. El jugador no salta: se *adhiere* a superficies usando física de tiles, convirtiendo cada movimiento en una decisión de gestión de recursos.

### 🌿 Mecánicas Principales

| Mecánica | Descripción técnica |
|---|---|
| 🐌 **Movimiento Sticky** | El caracol se adhiere a paredes y techos mediante lectura de `flag 0` en los tiles del mapa. No hay gravedad convencional. |
| 💧 **Rastro de Baba** | Array circular de las últimas `N` posiciones del jugador, dibujado frame a frame como estela verde semitransparente. |
| 🌡️ **Sistema de Humedad** | Barra de recursos que decrementa con cada movimiento. Al llegar a 0 → Game Over por desecación. |
| 💦 **Gotas de Agua** | Entidades coleccionables que restauran humedad al detectar colisión AABB con el jugador. |
| 🧂 **Cristales de Sal** | Proyectiles dinámicos que caen desde la parte superior del mapa con velocidad variable. Contacto = Game Over. |

---

## 👥 Equipo de Desarrollo

<table>
  <thead>
    <tr>
      <th>👩‍💻 Perfil</th>
      <th>Rol</th>
      <th>Responsabilidades</th>
      <th>Background</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Ele</strong></td>
      <td>🏗️ Arquitecta de Software</td>
      <td>
        Estructura del código y módulos<br>
        Gestión de memoria y arrays<br>
        Lógica de colisiones (flags de tiles)<br>
        Sistema de scroll de cámara
      </td>
      <td>Estudiante de DAM/DAW · Desarrollo web full-stack · Proyectos en JavaScript, Python y Lua</td>
    </tr>
    <tr>
      <td><strong>Miguel</strong></td>
      <td>🎨 Gameplay & Level Designer</td>
      <td>
        Pixel Art 8×8 (sprites y tileset)<br>
        Lógica de eventos y triggers<br>
        Sistema de proyectiles (sal)<br>
        Diseño de niveles asistido por IA
      </td>
      <td>Desarrollador de servidores y plugins de Minecraft · Lógica de eventos · Diseño de sistemas de juego</td>
    </tr>
  </tbody>
</table>

> 💡 Este proyecto refleja una colaboración real entre un perfil orientado a la **arquitectura técnica** y otro orientado al **diseño de sistemas y experiencia de juego**, reproduciendo la dinámica de un equipo profesional indie en condiciones de tiempo límite.

---

## 🛣️ Roadmap — La Noche en 3 Fases

```
🌙  ──────────────────────────────────────── 🌅 
   │                   │                    │
FASE 1             FASE 2               FASE 3
Arquitectura       Assets & Mundo       Lógica Avanzada
```

### 🔧 Fase 1 — Arquitectura del Motor 

- [ ] Inicialización del proyecto en LIKO-12
- [ ] Sistema de cámara con scroll vertical suave
- [ ] Lógica de colisiones por flags de tiles (`fget`)
- [ ] Movimiento sticky: adherencia a paredes y techos
- [ ] Módulo de estado del jugador (`player.lua`)

### 🎨 Fase 2 — Assets & Construcción del Mundo 

- [ ] Diseño de sprites: caracol (8×8), gota de agua, cristal de sal
- [ ] Tileset: pared, suelo, fondo vegetal
- [ ] Construcción del mapa vertical en el editor de LIKO-12
- [ ] Colocación de triggers de coleccionables y peligros
- [ ] Paleta de color restringida (tonos verdes, azules y grises)

### ⚙️ Fase 3 — Lógica Avanzada & Polish 

- [ ] Sistema de Humedad con barra de UI
- [ ] Rastro de baba (array de posiciones + renderizado)
- [ ] Generador de cristales de sal (spawn + física de caída)
- [ ] Colisión y recolección de gotas de agua
- [ ] Pantallas de Game Over y Victoria
- [ ] Ajuste de dificultad y balance

---

## 🧬 Ejemplo de Código — Rastro de Baba

El sistema de rastro es un buen ejemplo de **gestión de memoria eficiente** en un entorno con recursos limitados (Fantasy Console). Se usa un array de tamaño fijo como **buffer circular** para evitar allocations dinámicas en cada frame.

```lua
-- 🐌 trail.lua — Sistema de Rastro de Baba
-- Guarda las últimas MAX_TRAIL posiciones del jugador
-- y las dibuja como una estela verde degradada.

local Trail = {}
Trail.__index = Trail

local MAX_TRAIL = 20  -- número máximo de puntos guardados

function Trail.new()
  local t = setmetatable({}, Trail)
  t.positions = {}   -- array de {x, y}
  t.head = 1         -- índice del punto más reciente (buffer circular)
  t.count = 0        -- cuántos puntos hay actualmente
  return t
end

-- Llamar una vez por frame con la posición actual del jugador
function Trail:update(px, py)
  -- Sobrescribimos el índice actual del buffer
  self.positions[self.head] = { x = px, y = py }
  -- Avanzamos el puntero (circular: vuelve a 1 cuando supera MAX_TRAIL)
  self.head = (self.head % MAX_TRAIL) + 1
  -- Incrementamos el contador hasta el máximo
  if self.count < MAX_TRAIL then
    self.count = self.count + 1
  end
end

-- Dibuja la estela, más opaca cerca del jugador y más tenue al fondo
function Trail:draw(cam_y)
  for i = 1, self.count do
    -- Calculamos el índice hacia atrás desde la cabeza del buffer
    local idx = ((self.head - i - 1) % MAX_TRAIL) + 1
    local p = self.positions[idx]
    if p then
      -- Alpha simulado: los puntos más lejanos usan color más oscuro
      local color = (i < 7) and 11 or (i < 14) and 3 or 1
      -- Color 11 = verde claro, 3 = verde oscuro, 1 = negro (LIKO-12 palette)
      pset(p.x, p.y - cam_y, color)
    end
  end
end

return Trail

-- ─── Uso en main.lua ───────────────────────────────────────────────────────
--
-- local Trail = require("trail")
-- local snail_trail = Trail.new()
--
-- function TIC()               -- loop principal de LIKO-12
--   snail_trail:update(player.x, player.y)
--   snail_trail:draw(camera.y)
-- end
```

> 🔍 **Por qué este enfoque:** En una Fantasy Console como LIKO-12, el garbage collector de Lua puede provocar micro-stutters si se crean tablas nuevas cada frame. El buffer circular reutiliza las mismas posiciones de memoria, manteniendo el juego a 60fps estables.

---

## 🏆 Objetivos de Portafolio

Este proyecto, aunque pequeño en escala, está diseñado específicamente para demostrar competencias técnicas reales:

### 🧠 Optimización en entornos con restricciones

Desarrollar en LIKO-12 implica trabajar con **memoria limitada, una CPU virtual y una paleta de 16 colores**. Cada decisión técnica (buffer circular, lectura de flags en lugar de colisiones por hitbox, scroll suave sin librerías externas) es una solución de optimización deliberada, no una convención del framework.

### 🔗 Arquitectura modular en Lua

El código está dividido en módulos desacoplados (`player`, `trail`, `hazards`, `camera`), demostrando capacidad para **estructurar proyectos con separación de responsabilidades**, incluso en lenguajes de scripting ligeros.

### ⏱️ Entrega bajo presión

Completar un juego jugable en una sola noche simula los **ciclos de sprint cortos** de un equipo de desarrollo real, con priorización de features, descarte de extras y enfoque en el producto mínimo viable.

### 🤝 Colaboración técnica en pareja

La división de roles (arquitectura vs. diseño de sistemas) imita la estructura de un equipo indie profesional. El proyecto demuestra capacidad de **trabajar en paralelo**, coordinar APIs internas entre módulos y mantener coherencia de código sin una metodología formal.

### 🎮 Dominio de lógica de videojuegos

Implementar desde cero sistemas como scroll de cámara, colisiones por mapa de tiles, física de proyectiles y gestión de recursos demuestra comprensión profunda de los **fundamentos del game development**, más allá del uso de motores de alto nivel.

---

## 📁 Estructura del Proyecto

```
snail-ascend/
├── main.lua          # Loop principal, inicialización y TIC()
├── player.lua        # Estado, movimiento sticky y gestión de humedad
├── trail.lua         # Sistema de rastro de baba (buffer circular)
├── camera.lua        # Scroll vertical suave
├── hazards.lua       # Cristales de sal: spawn, física y colisión
├── collectibles.lua  # Gotas de agua: posición y recolección
├── ui.lua            # Barra de humedad y HUD
└── README.md         # Este archivo
```

---

## 🚀 Cómo Ejecutar

1. Descarga **LIKO-12** desde [liko12.github.io](https://liko12.github.io) o instálalo en Steam.
2. Clona este repositorio:
   ```
   git clone https://github.com/TU_USUARIO/snail-ascend.git
   ```
3. Abre LIKO-12 y navega al directorio del proyecto.
4. Ejecuta `main.lua` desde la consola de LIKO-12:
   ```
   load main.lua
   run
   ```

---

## 🌱 Créditos

| | |
|---|---|
| 🐌 Concepto & Game Design | Ele + Miguel |
| 🏗️ Arquitectura de Software | Ele |
| 🎨 Pixel Art & Level Design | Miguel |
| 🌙 Jam Duration | Una noche (≈8 horas) |
| 💚 Dedicado a | todos los caracoles que alguna vez intentaron escalar |

---

<p align="center">
  <em>Hecho con 💚 made in casa, con montesito · Game Jam One Night · 2026</em><br>
  <em>🐌 "Los lentos también llegan arriba."</em>
</p>
