# La Casa de Mandi — Proyecto Semestral Programación 2

Plataforma web con login para la pastelería artesanal "La Casa de Mandi". Digitaliza el ciclo completo del pedido personalizado: catálogo (Dulces y Postres) → pedido con diseño a medida → abono verificado por admin → producción → pago final verificado → entrega. Incluye panel de administración con gestión de estados, pagos, productos, clientes, capacidad de entregas y reportes.

## Stack

- **Backend:** Java (Servlets + JSP)
- **Servidor de aplicaciones:** Apache Tomcat
- **Base de datos:** MySQL (corriendo vía XAMPP, solo para el motor de base de datos)
- **Frontend:** HTML / CSS / JavaScript
- **IDE:** Eclipse (Eclipse IDE for Enterprise Java and Web Developers)
- **Acceso a datos:** JDBC (driver `mysql-connector-j`)

> Proyecto 100% local — no requiere PHP ni Node.js. La única pieza que XAMPP aporta aquí es MySQL; el servidor web real es Tomcat.

## Estructura del proyecto

```
ProyectoSemestral/
├── WebContent/                    ← Raíz pública del proyecto (lo que sirve Tomcat)
│   ├── index.jsp                  ← Página de bienvenida
│   ├── WEB-INF/
│   │   ├── web.xml                ← Configuración de la app, mapeo de Servlets
│   │   └── lib/                   ← Aquí va mysql-connector-j.jar (no se sube a Git)
│   ├── jsp/
│   │   ├── public/                ← Pantallas sin login (login, registro, catálogo...)
│   │   ├── cliente/                ← Pantallas del panel de cliente
│   │   ├── admin/                  ← Pantallas del panel de administración
│   │   └── layouts/                ← Header, footer, fragmentos reutilizables
│   ├── css/
│   ├── js/
│   └── img/
├── src/
│   └── com/lacasademandi/
│       ├── modelo/                 ← JavaBeans: Cliente.java, Pedido.java, Producto.java...
│       ├── dao/                    ← Acceso a datos (JDBC + SQL): ClienteDAO.java...
│       ├── controlador/            ← Servlets: LoginServlet.java, PedidoServlet.java...
│       └── util/                   ← ConexionBD.java y utilidades varias
├── database/
│   ├── schema.sql                  ← Estructura de las tablas (ejecutar primero)
│   └── seed.sql                    ← Datos de prueba: catálogo real + 8 pedidos de ejemplo
├── docs/                           ← Copia de la documentación del vault de Obsidian
├── .gitignore
└── README.md
```

### Por qué esta estructura

Es la estructura estándar que genera Eclipse al crear un **Dynamic Web Project**: `WebContent` es la carpeta pública que Tomcat expone, `WEB-INF` contiene configuración y librerías que NO son accesibles directamente desde el navegador (por seguridad), y `src` es el código Java fuente, separado en tres capas:

- **modelo** → clases que solo representan datos (getters/setters), sin lógica de base de datos.
- **dao** → clases que sí hablan con MySQL (usando JDBC), una por entidad. Los Servlets nunca escriben SQL directamente, siempre pasan por su DAO correspondiente.
- **controlador** → los Servlets, que reciben la petición HTTP, llaman al DAO, y decide qué JSP mostrar.

Ya hay un ejemplo completo de punta a punta siguiendo este patrón: `Cliente.java` (modelo) → `ClienteDAO.java` (dao) → `LoginServlet.java` (controlador) → `login.jsp` (vista). Cualquier módulo nuevo debe seguir esta misma cadena.

## Cómo importar el proyecto en Eclipse

1. Abrir Eclipse → **File → Import → Git → Projects from Git** (o clonar primero con `git clone` desde la terminal y luego **Import → Existing Projects into Workspace**).
2. Confirmar que Eclipse lo reconozca como **Dynamic Web Project**. Si no lo detecta automáticamente, click derecho sobre el proyecto → **Properties → Project Facets** → habilitar "Dynamic Web Module" y apuntar el Content Directory a `WebContent`.
3. Asociar el proyecto a tu instalación de Tomcat: click derecho → **Properties → Targeted Runtimes** → seleccionar tu versión de Tomcat.
4. Descargar el conector JDBC de MySQL (`mysql-connector-j-X.X.X.jar`) desde [dev.mysql.com/downloads/connector/j](https://dev.mysql.com/downloads/connector/j/) y copiarlo dentro de `WebContent/WEB-INF/lib/` (esa carpeta está en `.gitignore`, así que cada quien debe colocar el suyo).
5. Click derecho sobre el proyecto → **Run As → Run on Server** → elegir Tomcat.

## Cómo levantar la base de datos

```bash
mysql -u root -p < database/schema.sql
mysql -u root -p < database/seed.sql
```

O desde phpMyAdmin (el que trae XAMPP): pestaña **Importar** → seleccionar `schema.sql` → Continuar, y repetir con `seed.sql`.

Revisar `src/com/lacasademandi/util/ConexionBD.java` y ajustar usuario/password si tu MySQL local no usa `root` sin contraseña (configuración por defecto de XAMPP).

### Cuentas de prueba (vienen en el seed)

| Tipo | Correo / WhatsApp | Password |
|---|---|---|
| Cliente | ana.perez@gmail.com / 6000-0001 | cliente123 |
| Cliente | carlos.gomez@gmail.com / 6000-0002 | cliente123 |
| Cliente | maria.rodriguez@gmail.com / 6000-0003 | cliente123 |
| Cliente | luis.fernandez@gmail.com / 6000-0004 | cliente123 |
| Cliente | daniela.castillo@gmail.com / 6000-0005 | cliente123 |

No hay cuenta de administrador en el seed — se crea aparte directamente en la tabla `Administrador` cuando se necesite probar el panel admin.

> Nota técnica: el password de estos clientes está guardado como hash BCrypt real. El `LoginServlet` de ejemplo todavía compara el password en texto plano (marcado con `TODO` en el código) porque falta agregar una librería de BCrypt para Java (ej. `jBCrypt`) al proyecto — agregar ese `.jar` a `WEB-INF/lib` antes de validar contraseñas reales.

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
git clone https://github.com/MarianC-programing/La-Casa-de-mandi.git
cd La-Casa-de-mandi
git checkout feature/<tu-rama>
```

### Flujo de trabajo diario

1. Antes de empezar a trabajar, actualizar tu copia local:
   ```bash
   git pull origin main
   ```

2. Trabajar siempre dentro de tu rama asignada, no directo sobre `main`.

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
