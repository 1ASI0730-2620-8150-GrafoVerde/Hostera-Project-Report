# Preparación del Sprint 2

Documento de trabajo del equipo Grafo Verde para preparar el Sprint Planning 2 y
redactar la sección 5.2.2 del informe. No forma parte del entregable: su contenido se
traslada a `report.md` cuando el equipo confirme el alcance en la reunión de
planificación y disponga de las evidencias correspondientes.

Las tablas reproducen la estructura que ya utiliza la sección 5.2.1 del informe, de
modo que puedan copiarse sin volver a formatearlas.

## 1. Decisiones que el equipo debe confirmar antes de redactar 5.2.2

| # | Decisión | Propuesta de este documento |
| :---: | --- | --- |
| 1 | Alcance del Sprint 2 | Flujos operativos del frontend con datos de demostración: `US011`, `US033`, `US012`, `US019`, `US013`, `US024`, `US025`, `US027` y `US026`, por 41 Story Points. |
| 2 | Líderes por aspecto | Distribución de la sección 4 de este documento, que reparte el liderazgo entre los cinco integrantes. |
| 3 | Fecha, hora, lugar, responsable y asistentes del Sprint Planning 2 | Se registran con los datos reales de la reunión; no se completan por adelantado. |
| 4 | Resumen del Sprint 1 Review y del Sprint 1 Retrospective | Se redactan a partir de lo ocurrido en ambos eventos; la sección 2 indica qué debe contener cada uno. |
| 5 | Destino de despliegue | Firebase Hosting para la Frontend Web Application y Render para la API de datos de demostración, según la sección 5.1.4 del informe. |

## 2. Entradas del Sprint Planning 2

### Sprint 1 Review

El resumen debe indicar qué se presentó, quién asistió y qué observaciones se
recibieron. Los hechos verificables disponibles son los siguientes:

- Se implementaron las ocho User Stories de `EP001`, por 42 Story Points.
- La Landing Page quedó publicada en GitHub Pages
  (https://1asi0730-2620-8150-grafoverde.github.io/landing-page/).
- La exposición de la revisión está registrada en el video del Anexo A.
- Después de la revisión se incorporaron a la Landing Page la página de contacto
  comercial independiente, los metadatos sociales y la corrección de precios de los
  planes Starter y Professional, liberados como versión `v0.3.0` del repositorio de
  la Landing Page. Estos cambios se documentan en el Sprint 2 porque son posteriores
  al cierre del Sprint 1.

### Sprint 1 Retrospective

El resumen debe recoger lo que el equipo acordó en la retrospectiva: qué sostener,
qué cambiar y qué acción concreta se asume para el Sprint 2. Dos hechos del Sprint 1
conviene discutirlos explícitamente, porque la rúbrica evalúa el aporte individual:

- El reparto de commits fue desigual entre los integrantes, tanto en el repositorio
  del informe como en el de la Landing Page.
- Las ocho User Stories se integraron el mismo día, lo que concentró la revisión y
  la integración al final del sprint.

### Velocity

| Referencia | Valor |
| --- | ---: |
| Story Points comprometidos en el Sprint 1 | 42 |
| Story Points completados en el Sprint 1 | 42 |
| Velocity observada | 42 Story Points por sprint |
| Story Points propuestos para el Sprint 2 | 41 |

## 3. Alcance propuesto del Sprint 2

El Sprint 2 implementa la primera versión de la Frontend Web Application, que consume
la API de datos de demostración descrita en la sección 5.1.1 del informe. El orden
respeta la prioridad del Product Backlog de la sección 3.3 y la recomendación 1 del
roadmap: construir primero los flujos operativos del frontend con datos de
demostración mientras se preparan los servicios.

Las historias de registro, inicio de sesión y autorización (`US009`, `US010`) quedan
fuera del sprint, de acuerdo con la recomendación 3 del roadmap. En su lugar, los
datos de demostración incluyen un operador y una propiedad activa preconfigurados.

| Orden en el backlog | User Story ID | User Story | Story Points | Capacidad del producto |
| :---: | :---: | --- | :---: | --- |
| 9 | US011 | Monitor operations across assigned properties | 5 | Panorama operativo |
| 10 | US033 | Navigate between operational areas | 3 | Panorama operativo |
| 11 | US012 | Find and review reservations | 3 | Reservas |
| 12 | US019 | Review room availability for a selected date | 5 | Reservas |
| 13 | US013 | Create a reservation | 5 | Reservas |
| 23 | US024 | Monitor property inventory | 5 | Inventario y almacén |
| 24 | US025 | Manage inventory item records | 5 | Inventario y almacén |
| 25 | US027 | Manage storage locations | 5 | Inventario y almacén |
| 26 | US026 | Adjust inventory stock | 5 | Inventario y almacén |
| | **Total** | **Primera versión de la Frontend Web Application** | **41** | |

Las historias `US014` a `US018`, que completan el ciclo de vida de la reserva, el
pago, el check-in y el check-out, conservan su prioridad en el backlog y se
consideran candidatas al Sprint 3, una vez disponibles los servicios de reservas.

### Sprint 2 Goal propuesto

Nuestro enfoque está en que el administrador de un hotel independiente y el
responsable de operaciones de una cadena pequeña puedan ver, en la Frontend Web
Application desplegada, el estado actual de la propiedad que tienen activa y actuar
sobre sus reservas y sus insumos sin salir de ese contexto. Creemos que esto les
permite reemplazar la consulta de hojas de cálculo y mensajes dispersos por una sola
vista operativa. Esto se confirmará cuando, con los datos de demostración, una
persona pueda pasar del panorama de su propiedad a crear una reserva para una
habitación disponible y a registrar un ajuste de existencias en una ubicación de
almacén.

### Métrica del Sprint 2 Goal propuesta

El objetivo se considerará cumplido cuando, en la aplicación desplegada, los tres
recorridos siguientes se completen con los datos de demostración: del panorama
operativo a la consulta de una reserva, del panorama operativo a la creación de una
reserva sobre una habitación disponible, y del panorama operativo al registro de un
ajuste de existencias. Como condición de entrega, las nueve User Stories del sprint
deben estar implementadas y la aplicación y su API de datos de demostración deben
estar publicadas en los destinos definidos en la sección 5.1.4.

## 4. Aspect Leaders and Collaborators propuestos

Los aspectos del Sprint 2 corresponden a las nueve User Stories del alcance, más un
aspecto técnico transversal para la API de datos de demostración y el despliegue. La
distribución reparte el liderazgo entre los cinco integrantes, de modo que cada uno
responda por al menos dos aspectos y acumule commits propios en el repositorio del
frontend.

| Team Member | GitHub Username | US011<br>Panorama | US033<br>Navegación | US012<br>Consulta de reservas | US019<br>Disponibilidad | US013<br>Creación de reserva | US024<br>Monitoreo de inventario | US025<br>Artículos | US027<br>Ubicaciones | US026<br>Ajustes de existencias | API de demostración<br>y despliegue |
| --- | --- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Cuba Pareja, Joaquin Antonio | `joacuba` | L | C | C | C | C | C | C | C | C | L |
| Cuba Vega, Darnell Yadir | `darnell1910` | C | L | C | C | C | C | L | C | C | C |
| Condori Urviola, Mateo Sebastián | `BeyaminUv` | C | C | C | C | L | L | C | C | C | C |
| Flores Rios, Juan Diego | `YopoFlores` | C | C | C | L | C | C | C | L | C | C |
| Santana Luna, José Antonio | `JhosBY2005` | C | C | L | C | C | C | C | C | L | C |

## 5. Sprint Backlog 2 propuesto

Las horas son estimaciones de planificación por tarea y no sustituyen la estimación
relativa en Story Points de cada User Story. La suma propuesta es de 114 horas,
repartidas en 25 para Joaquin Cuba, 24 para Mateo Condori, 22 para Juan Diego Flores,
22 para José Santana y 21 para Darnell Cuba.

| Story Id | Story Title | Task Id | Task Title | Task Description | Estimation (Hours) | Assigned To |
| --- | --- | --- | --- | --- | :---: | --- |
| US011 | Monitor operations across assigned properties | T011.1 | Build the operational overview view | Implementar la vista de panorama con los indicadores de ocupación, habitaciones, inventario y accesos de la propiedad activa. | 8 | Joaquin Cuba |
| US011 | Monitor operations across assigned properties | T011.2 | Add the active property selector | Implementar el cambio de propiedad activa y su persistencia durante la sesión de trabajo. | 5 | Joaquin Cuba |
| US033 | Navigate between operational areas | T033.1 | Implement the operational navigation shell | Implementar el layout, el menú de áreas operativas y las rutas de la aplicación. | 6 | Darnell Cuba |
| US033 | Navigate between operational areas | T033.2 | Preserve the active property context | Mantener la propiedad activa y el estado de navegación al cambiar de área operativa. | 4 | Darnell Cuba |
| US012 | Find and review reservations | T012.1 | Build the reservation list and filters | Implementar el listado de reservas con los filtros por huésped, periodo, habitación y estado. | 6 | José Santana |
| US012 | Find and review reservations | T012.2 | Build the reservation detail view | Implementar la vista de detalle con la información de la reserva, su habitación y su estado. | 5 | José Santana |
| US019 | Review room availability for a selected date | T019.1 | Build the availability view by date | Implementar la consulta de disponibilidad desde una fecha seleccionada y su presentación por habitación. | 8 | Juan Diego Flores |
| US019 | Review room availability for a selected date | T019.2 | Add availability states and legend | Representar los estados diarios de cada habitación con su leyenda y sus estados vacíos. | 4 | Juan Diego Flores |
| US013 | Create a reservation | T013.1 | Build the reservation creation form | Implementar el formulario de creación con los datos del huésped, el periodo y la habitación disponible. | 8 | Mateo Condori |
| US013 | Create a reservation | T013.2 | Validate the reservation before saving | Validar el periodo, la disponibilidad de la habitación y la tarifa aplicable antes de registrar la reserva. | 6 | Mateo Condori |
| US024 | Monitor property inventory | T024.1 | Build the inventory overview | Implementar el listado de existencias por ubicación de almacén con sus condiciones de stock. | 6 | Mateo Condori |
| US024 | Monitor property inventory | T024.2 | Add low-stock indicators | Señalar los artículos que alcanzan o superan su umbral de reposición. | 4 | Mateo Condori |
| US025 | Manage inventory item records | T025.1 | Build the inventory item form | Implementar la creación y la edición de artículos con su identificación, clasificación y umbrales. | 7 | Darnell Cuba |
| US025 | Manage inventory item records | T025.2 | Validate item records | Validar los datos obligatorios, la unidad de medida y la ubicación asignada de cada artículo. | 4 | Darnell Cuba |
| US027 | Manage storage locations | T027.1 | Build the storage location management view | Implementar la creación, la edición y el listado de ubicaciones de almacén de la propiedad. | 6 | Juan Diego Flores |
| US027 | Manage storage locations | T027.2 | Associate items with their location | Implementar la asignación de artículos a su ubicación y el equipo responsable. | 4 | Juan Diego Flores |
| US026 | Adjust inventory stock | T026.1 | Build the stock adjustment form | Implementar el registro de entradas y salidas de existencias con su motivo y su cantidad. | 6 | José Santana |
| US026 | Adjust inventory stock | T026.2 | Show the adjustment history | Presentar el historial de ajustes de un artículo con su fecha, su motivo y su responsable. | 5 | José Santana |
| — | API de demostración y despliegue | TD.1 | Set up the demo data API | Definir los recursos y las rutas de `server/db.json` y `server/routes.json` para las nueve User Stories del sprint. | 6 | Joaquin Cuba |
| — | API de demostración y despliegue | TD.2 | Deploy the application and its demo API | Publicar la Frontend Web Application y la API de datos de demostración en los destinos de la sección 5.1.4 y registrar sus URL. | 6 | Joaquin Cuba |

## 6. Evidencias que deben reunirse durante el Sprint 2

| Subsección del informe | Evidencia requerida | Responsable propuesto |
| --- | --- | --- |
| 5.2.2.3 Sprint Backlog 2 | Captura del board de YouTrack con el Sprint 2 creado, sus historias asignadas, sus responsables con nombre real y sus Story Points. | Darnell Cuba |
| 5.2.2.4 Development Evidence | Tabla de commits por repositorio, rama, identificador, mensaje, cuerpo y fecha, tomada del historial de `hostera-frontend`. | Cada líder de aspecto |
| 5.2.2.5 Execution Evidence | Capturas de las vistas alcanzadas y video de navegación publicado en Microsoft Stream, con su duración. | José Santana |
| 5.2.2.6 Services Documentation Evidence | Tabla de endpoints de la API de datos de demostración, con su verbo HTTP y su captura de verificación en Postman. | Joaquin Cuba |
| 5.2.2.7 Software Deployment Evidence | Captura de la configuración de despliegue y URL públicas de la aplicación y de la API, más la versión publicada de la Landing Page posterior al Sprint 1. | Joaquin Cuba |
| 5.2.2.8 Team Collaboration Insights | Capturas de contributors y del historial de commits de `hostera-frontend`, con el resumen de commits funcionales por integrante. | Mateo Condori |

Mientras una de estas evidencias no exista, su subsección no se incorpora al informe:
el enunciado penaliza los encabezados reservados sin contenido.
