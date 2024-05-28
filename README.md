# LICENSES SERVICE

### Introducción
Proyecto personal desarrollado con **CAP CDS** para poner en práctica conceptos relacionados a dicha tecnología.

### Solución
Se requiere un sistema que permita gestionar y administrar dentro de una base de datos **empleados** y sus respectivas **licencias**. 

Es necesario proteger con **seguridad** al aplicativo, autenticando y autorizando a todo usuario que intente acceder. Éstos usuarios podrán ser **'Solicitantes'**, **'Aprobadores'** o **'Administradores'**. Según los roles asignados se limita dicho acceso a ciertas funcionalidades. 

Además, se solicita **validar** toda entrada de datos previo a cualquier operación de escritura.

Por otro lado, se desea contar con **traducciones (i18n)** a diversos lenguajes en función de la localización del cliente.

### Conceptos puestos en práctica.
- Creación de entidades del dominio (asociación, composición, aspectos, tipos, enums).
- Definición de servicios que expongan dichas entidades.
- Eventos:
    - beforeHandlers.
    - afterHandlers.
    - onHandlers (Actions).
- Seguridad:
   - Autenticación por credenciales.
   - Autorización por roles.
   - Restricciones en según ID del usuario.
- Protocolo de internacionalización (i18n).
 - Buenas prácticas recomendadas por la documentación oficial de SAP CAP.
