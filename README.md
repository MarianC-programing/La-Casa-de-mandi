# La Casa de Mandi — Proyecto Semestral Programación 2

Plataforma web con login para la pastelería artesanal "La Casa de Mandi". Digitaliza el ciclo completo del pedido personalizado: catálogo (Dulces y Postres) → pedido con diseño a medida → abono verificado por admin → producción → pago final verificado → entrega. Incluye panel de administración con gestión de estados, pagos, productos, clientes, capacidad de entregas y reportes.

## Stack

- **Backend:** PHP
- **Base de datos:** MySQL
- **Frontend:** HTML / CSS / JS 

## Estructura del proyecto

```
ProyectoSemestral/
├── public/                 ← Carpeta raíz del servidor (Document Root)
│   ├── index.php           ← Punto de entrada de la aplicación
│   └── assets/
│       ├── css/
│       ├── js/
│       └── img/
├── src/
│   ├── config/
│   │   └── database.php    ← Configuración de conexión a la BD
│   ├── models/              ← Clases que representan las entidades (Cliente, Pedido, etc.)
│   ├── controllers/        ← Lógica de cada módulo (login, pedidos, pagos, admin)
│   └── views/
│       ├── public/          ← Pantallas sin login (inicio, catálogo, login, registro)
│       ├── cliente/         ← Pantallas del panel de cliente
│       ├── admin/           ← Pantallas del panel de administración
│       └── layouts/         ← Header, footer, plantillas compartidas
├── database/
│   ├── schema.sql           ← Estructura de las tablas (ejecutar primero)
│   └── seed.sql             ← Datos de prueba: catálogo real + 8 pedidos de ejemplo
├── docs/                   ← Copia de la documentación del vault de Obsidian (ver abajo)
├── .gitignore
└── README.md
```

## Cómo levantar el proyecto localmente

1. Crear la base de datos ejecutando, en este orden:
   ```bash
   mysql -u root -p < database/schema.sql
   mysql -u root -p < database/seed.sql
   ```
   O desde phpMyAdmin: pestaña **Importar** → seleccionar `schema.sql` → Continuar, y luego repetir con `seed.sql`.

2. Revisar `src/config/database.php` y ajustar usuario/contraseña si tu MySQL local no usa `root` sin password. (Caso particular)

3. Levantar el servidor de PHP integrado desde la raíz del proyecto:
   ```bash
   php -S localhost:8000 -t public
   ```
   Y abrir `http://localhost:8000` en el navegador. (O tu ruta normal de trabajo con XAMMP)

### Cuentas de prueba (vienen en el seed)

| Tipo | Correo / WhatsApp | Password |
|---|---|---|
| Cliente | ana.perez@gmail.com / 6000-0001 | cliente123 |
| Cliente | carlos.gomez@gmail.com / 6000-0002 | cliente123 |
| Cliente | maria.rodriguez@gmail.com / 6000-0003 | cliente123 |
| Cliente | luis.fernandez@gmail.com / 6000-0004 | cliente123 |
| Cliente | daniela.castillo@gmail.com / 6000-0005 | cliente123 |

No hay cuenta de administrador en el seed — se crea aparte directamente en la tabla `Administrador` cuando se necesite probar el panel admin.

## Documentación completa del proyecto

La documentación funcional, de diseño y de base de datos se mantiene en el vault de Obsidian, y una copia vive también en este repositorio dentro de la carpeta `docs/` para que todo el equipo tenga acceso sin necesitar Obsidian instalado.

> Nota: estos archivos usan la sintaxis de enlaces de Obsidian (`[[Nombre del documento]]`). En GitHub se ven como texto plano, no como links clicables — es normal, solo funcionan así dentro de Obsidian.

| Documento | Qué contiene |
|---|---|
| `docs/Proyecto Semestral La Casa de Mandi.md` | Resumen general, tareas, decisiones tomadas |
| `docs/Vision del Proyecto.md` | Problema del negocio y objetivo de la solución |
| `docs/Requisitos Funcionales.md` | Todos los RF del sistema, módulo por módulo |
| `docs/Modelo de Datos.md` | Entidades, atributos, relaciones y flujo de estados del pedido |
| `docs/Mapa del Sitio.md` | Árbol de navegación de las tres zonas (pública, cliente, admin) |
| `docs/Wireframes.md` | Estructura de cada pantalla |
| `docs/Reglas de Desarrollo.md` | Reglas de originalidad y buenas prácticas del proyecto |
| `docs/Script Base de Datos.md` | Explicación del `schema.sql` y `seed.sql`, qué prueba cada pedido del seed |

Antes de tocar código en un módulo nuevo, revisar primero el documento correspondiente en `docs/` — ahí están las decisiones ya tomadas (por ejemplo, por qué el precio de los dulces lo ajusta el admin y el de postres se calcula solo, o por qué los pagos necesitan confirmación manual antes de cambiar el estado del pedido).

Si se actualiza un documento en el vault de Obsidian, hay que recordar copiar el archivo actualizado a `docs/` y subirlo en un commit (`docs/...`) para que el resto del equipo vea la versión más reciente.

## Equipo y división de trabajo

| Rama | Responsable | Alcance |
|---|---|---|
| `feature/admin-panel` | Marian | Dashboard, gestión de pedidos (cambio de estado, confirmación de pagos), gestión de productos/variantes, gestión de clientes, capacidad de entregas, reportes |
| `feature/auth-onboarding` | Laura | Login con redirección por rol, Registro de clientes, Mi Perfil |
| `feature/catalogo-publico` | Evelin | Inicio, Catálogo por categoría (Dulces/Postres), Detalle del Producto |
| `feature/pedidos-pagos-cliente` | Gabriela | Formulario de Nuevo Pedido, Mis Pedidos, Detalle del Pedido, Formulario de Abono, Formulario de Pago Final |

Orden recomendado de integración: `auth-onboarding` primero, porque las demás ramas necesitan un login funcional para probar pantallas con sesión activa.

## Cómo trabajar con Git

### Primera vez (clonar el repositorio)

```bash
git clone <url-del-repositorio>
cd ProyectoSemestral
```

### Flujo de trabajo diario

1. Antes de empezar a trabajar, actualizar tu copia local:
   ```bash
   git pull origin main
   ```

2. Crear una rama para lo que vayas a hacer (no trabajar directo sobre `main`):
   ```bash
   git checkout -b feature/nombre-del-modulo
   ```
   Ejemplos: `feature/login`, `feature/catalogo`, `feature/dashboard-admin`

3. Guardar avances con mensajes claros y en español, describiendo qué se hizo:
   ```bash
   git add .
   git commit -m "Agrega formulario de login con redireccion por rol"
   ```

4. Subir la rama al repositorio remoto:
   ```bash
   git push origin feature/nombre-del-modulo
   ```

5. Abrir un Pull Request hacia `main` en GitHub, revisar los cambios, y luego hacer merge.

6. Una vez fusionado, volver a `main` y actualizar:
   ```bash
   git checkout main
   git pull origin main
   ```

### Convención de nombres de ramas

- `feature/...` → una funcionalidad nueva
- `fix/...` → corrección de un error
- `docs/...` → cambios solo de documentación

### Convención de commits

Mensajes cortos, en español, en modo presente ("Agrega", "Corrige", "Actualiza"), describiendo qué cambia y no cómo se sintió hacerlo.

## Notas del proyecto

- Tiempo de desarrollo estimado: 2 semanas.
- El proyecto evita deliberadamente complejidad innecesaria (sin carrito de compras, sin gestión de inventario en tiempo real, sin roles múltiples de administrador) para mantenerse realizable en el tiempo disponible.
- Cualquier cambio de alcance debe discutirse y documentarse primero en Obsidian antes de implementarse en código.
