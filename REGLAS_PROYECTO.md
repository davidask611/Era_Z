# REGLAS DEL PROYECTO: JUEGO DE SUPERVIVENCIA ZOMBIE

## 1. Objetivo
El objetivo NO es crear dos juegos por separado e intentar unirlos al final.
El objetivo es construir un solo juego modular, en el que cada persona desarrolle sistemas independientes que luego se conecten.

Tecnologías base:
- Python
- Ursina
- Toon
- Pygame

## 2. Repositorio y ramas
- Repositorio central: GitHub.
- Rama `main`: versión estable del juego.
- David trabaja principalmente en la rama `david`.
- El amigo trabaja principalmente en la rama `amigo`.
- No trabajar directamente sobre `main`.
- Integrar a `main` mediante merge o Pull Request cuando una parte esté terminada y probada.

## 3. Reparto de responsabilidades
### David
- Casas, edificios e interiores.
- Agua, ríos, lagos y mar.
- Clima, cielo, nubes, lluvia, tormentas y niebla.
- Vehículos, conducción, combustible y baúl.
- Caminos y decoración del mundo.
- Piedras, objetos abandonados y vegetación pequeña.

### Amigo
- Zombies, IA, persecución y ataque.
- Vida de los zombies y daño.
- Aparición de zombies.
- Árboles.
- Recolección de recursos.
- Mochila, inventario, objetos y cantidades.
- Armas, munición y durabilidad de herramientas.
- Sistema de construcción, si se decide incluirlo.

### Los dos
- Estructura general del proyecto.
- Jugador, movimiento, cámara y colisiones.
- Carga de la isla.
- Guardado y carga.
- Vida, hambre, sed, daño y muerte.
- Sonido y configuración.
- Integración de los módulos.
- Decisiones de arquitectura.

## 4. Regla principal
Cada uno debe trabajar principalmente sobre sus propios archivos.

Ejemplo para David:
- `mundo/casas.py`
- `mundo/agua.py`
- `clima/lluvia.py`
- `clima/tormenta.py`
- `vehiculos/vehiculo.py`

Ejemplo para el amigo:
- `zombies/zombie.py`
- `zombies/administradorZombies.py`
- `mundo/arboles.py`
- `armas/arma.py`
- `jugador/inventario.py`

Esto reduce mucho la probabilidad de conflictos en Git.

## 5. Archivos centrales
Tocar con más cuidado y avisar antes:
- `main.py`
- `jugador/jugador.py`
- `isla.py` o el módulo equivalente de carga del mundo

Si ambos modifican las mismas líneas al mismo tiempo, Git puede generar un conflicto.

## 6. Estructura de carpetas recomendada
```text
juegoZombie/
|
|-- main.py
|
|-- jugador/
|   |-- jugador.py
|   |-- inventario.py
|
|-- zombies/
|   |-- zombie.py
|   |-- administradorZombies.py
|
|-- mundo/
|   |-- isla.py
|   |-- casas.py
|   |-- arboles.py
|   |-- agua.py
|
|-- vehiculos/
|   |-- vehiculo.py
|   |-- baul.py
|
|-- clima/
|   |-- lluvia.py
|   |-- tormenta.py
|
|-- armas/
|   |-- arma.py
|   |-- municion.py
|
|-- recursos/
|   |-- modelos/
|   |-- texturas/
|   |-- sonidos/
|
|-- .gitignore
|-- README.md
|-- REGLAS_PROYECTO.md
```

## 7. Interfaces entre módulos
Cada módulo debe tener una interfaz sencilla e independiente.

Ejemplos:

### Zombies
```python
zombie = Zombie(posicion=(10, 0, 20))
zombie.recibirDanio(25)
```

### Vehículos
```python
vehiculo = Vehiculo(posicion=(20, 0, 10))
vehiculo.entrar(jugador)
```

### Inventario
```python
inventario.anadir(item, cantidad)
```

Cada persona debe poder usar el sistema del otro sin modificar cómo funciona por dentro.

## 8. Interfaces mínimas que se deben definir pronto
- `jugador`
  - mover(dx, dz)
  - camera/update
  - vida
  - inventario
- `zombie`
  - recibirDanio(daño)
  - activar(posicion)
  - destruir
- `vehiculo`
  - entrar(jugador)
  - salir()
  - mover(dx, dz)
- `inventario`
  - anadir(item, cantidad)
  - eliminar(item, cantidad)
- `clima`
  - cambiar clima()

No cambiar estas interfaces sin avisar al otro.

## 9. Reglas de Git
1. No trabajar directamente sobre `main`.
2. Cada uno trabaja principalmente sobre sus propios módulos.
3. Avisar antes de modificar un archivo que utilice el otro.
4. Hacer commits claros.
5. Probar el código antes de subirlo.
6. No subir archivos temporales.
7. No subir el entorno virtual.
8. Mantener una estructura de carpetas ordenada.
9. Si hay conflicto, revisar antes de borrar cambios.
10. Actualizar la rama antes de comenzar una tarea importante.

Ejemplos de commits claros:
```text
"Agregada IA básica de zombies"
"Agregadas casas"
"Agregado sistema de lluvia"
"Agregado vehículo"
```

## 10. Flujo de trabajo Git
Clonado inicial:
```bash
git clone URL_DEL_REPOSITORIO
```

Cada persona trabaja en su rama:
```bash
git checkout david
```
o:
```bash
git checkout amigo
```

Cuando termina una tarea:
```bash
git add .
git commit -m "Agregadas casas"
git push
```

Después puede crear un Pull Request para integrar los cambios en `main`.

## 11. .gitignore
El proyecto debe tener un `.gitignore` para evitar subir archivos innecesarios.

Mínimo recomendado para Python:
```text
venv/
__pycache__/
*.pyc
.idea/
.vscode/
*.log
*.tmp
```

No subir el entorno virtual completo al repositorio.

## 12. Archivos pesados
Los modelos 3D, texturas, sonidos y otros recursos grandes pueden hacer crecer mucho el repositorio.

Recomendaciones:
- No subir archivos innecesarios, temporales o duplicados.
- Decidir desde el principio cómo se manejarán los assets pesados.
- Usar Git LFS o guardarlos fuera del repositorio si es necesario.
- Mantener el repositorio ligero para que los pulls sean rápidos.

## 13. Convenciones de código
- Usar nombres claros para archivos, clases, funciones y variables.
- Evitar nombres ambiguos como `sistema2` o `pruebaFinal`.
- Usar snake_case para nombres de archivos y funciones:
  - `agregar_zombie()`
  - `cargar_isla()`
- Usar PascalCase para clases:
  - `Zombie`
  - `Vehiculo`
- Cada archivo debería tener una responsabilidad principal.
- Comentar solo lo necesario, evitando código muerto.

## 14. Multijugador
Si el juego finalmente será multijugador, la arquitectura de cliente/servidor debería definirse desde el principio.

Si aún no está decidido:
- Empezar por un jugador.
- Dejar preparado el código para una expansión futura.
- No complicar la base inicial si no es necesario.

## 15. Pruebas antes de subir
Antes de hacer `git push`:
- El código debe poder ejecutarse al menos una vez.
- El módulo modificado no debe romper la base del juego.
- Evitar subir cambios que generen errores.
- Probar la funcionalidad principal del módulo.

## 16. Conflictos de Git
Si hay conflicto:
- No borrar cambios sin revisarlos.
- Comparar ambas versiones.
- Decidir qué código conservar o combinar.
- Avisar si el conflicto afecta a módulos del otro.

## 17. Pull Request y integración
Se puede integrar a `main` mediante un Pull Request.

Antes de integrar revisar:
- Que el código compile/ejecute.
- Que no rompa la estructura.
- Que el módulo tenga una función clara.
- Que no haya archivos temporales.
- Que los cambios estén descritos claramente.

## 18. Plan por fases
### Fase 1 - Base
- Crear repositorio GitHub.
- Crear estructura de carpetas.
- Configurar Python, Ursina, Toon y Pygame.
- Crear jugador.
- Movimiento.
- Cámara.
- Colisiones.
- Crear una primera isla.
- Día y noche básico.

### Fase 2 - Mundo
David:
- Casas
- Agua
- Ríos
- Clima
- Vehículos
- Decoración

Amigo:
- Zombies
- Árboles
- Armas
- Herramientas
- Inventario

### Fase 3 - Supervivencia
- Vida
- Hambre
- Sed
- Daño
- Muerte
- Loot
- Recursos
- Fabricación
- Objetos

### Fase 4 - Integración
- Jugador
- Inventario
- Armas y munición
- Mundo
- Casas
- Vehículos
- Agua
- Zombies
- IA
- Supervivencia
- Clima

## 19. Tareas pendientes iniciales
- Crear carpetas base.
- Configurar entorno de Python.
- Configurar Ursina.
- Crear README.md.
- Definir interfaces básicas.
- Crear primer jugador.
- Probar movimiento y cámara.
- Agregar una isla mínima.
- Agregar primer zombie básico.
- Agregar primer arma o inventario básico.
- Documentar cambios en REGLAS_PROYECTO.md o TAREAS_PENDIENTES.md.

## 20. Resumen
La clave es trabajar separados por módulos, mantener una estructura ordenada y utilizar GitHub para juntar los cambios de forma controlada.

No se debe construir dos mitades diferentes y pegarlas después.

Se debe construir un juego unificado por partes, con interfaces claras y commits pequeños.
