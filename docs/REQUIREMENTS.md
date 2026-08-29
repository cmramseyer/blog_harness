# Requirements

Project status: `complete`

## 1. Configurar RSpec

Status: `done`

Como desarrollador, quiero usar RSpec para cubrir la aplicacion con pruebas automatizadas.

Acceptance criteria:

- RSpec esta instalado y configurado para Rails.
- La suite se ejecuta con `bundle exec rspec`.
- Se elimina la configuracion Minitest que no se use.

## 2. Configurar verificaciones

Status: `blocked`

Blocked reason: `bin/commit-and-push` stages unrelated workspace changes with `git add -A`.

Como desarrollador, quiero ejecutar una unica verificacion local antes de desplegar.

Acceptance criteria:

- RuboCop queda configurado como linter del proyecto.
- Existe `bin/verify`.
- `bin/verify` ejecuta RSpec y RuboCop.
- El comando falla si una prueba o el linter fallan.

## 3. Autenticacion de usuarios

Status: `blocked`

Blocked reason: `bin/commit-and-push` stages unrelated workspace changes with `git add -A`.

Como visitante, quiero crear una cuenta e iniciar y cerrar sesion para poder publicar y comentar.

Acceptance criteria:

- Devise esta instalado y configurado.
- Existe un modelo `User`.
- El usuario se registra e inicia sesion con email y contrasena.
- El usuario puede cerrar sesion.
- No se implementan recuperacion de contrasena, bloqueo de cuenta ni funciones adicionales.
- Hay pruebas para registro, inicio y cierre de sesion.

## 4. Crear y listar posts

Status: `done`

Como usuario autenticado, quiero crear posts y ver el listado para publicar contenido.

Acceptance criteria:

- Existe un modelo `Post` con `title`, `content` y referencia obligatoria a `User`.
- `title` y `content` son obligatorios.
- Un usuario autenticado puede crear posts.
- `/posts` muestra el listado de posts.
- Cada post enlaza a su pagina de detalle.
- No existe funcionalidad para eliminar posts.
- Hay pruebas para creacion, asociacion y listado.

## 4.1 Crear seeds de users

Status: `done`

Acceptance criteria:

- Crear dos users via seeds, email: `admin@blog.com`, `user@blog.com`, ambos con password `blog1234`.

## 5. Ver y editar posts

Status: `done`

Como usuario, quiero ver el detalle de un post y editar mis propios posts.

Acceptance criteria:

- Existe una pagina en `/posts/:id`.
- Solo el autor puede editar su post.
- El formulario permite modificar `title` y `content`.
- No existe funcionalidad para eliminar posts.
- Hay pruebas para detalle y autorizacion de edicion.

## 6. Comentar posts

Status: `done`

Como usuario autenticado, quiero comentar un post.

Acceptance criteria:

- Existe un modelo `Comment` asociado obligatoriamente a un `Post` y un `User`.
- Un post puede tener cero o mas comentarios.
- El contenido del comentario es obligatorio.
- `/posts/:id` muestra los comentarios y un formulario con `textarea`.
- Al enviar el formulario se crea el comentario y se recarga la pagina.
- No se usa AJAX ni Stimulus.
- Hay pruebas para creacion, asociaciones y visualizacion.

## 7. Nombre de usuario en comentarios

Status: `in_progress`

Como usuario autenticado, quiero ver el email del usuario que ha dejado sus comentarios.

Acceptance criteria:

- Se visualiza el email del user arriba de cada comentario.
- Se usara un prefijo `User <email> comentó`.
- Usa el mismo estilo visual actual.
