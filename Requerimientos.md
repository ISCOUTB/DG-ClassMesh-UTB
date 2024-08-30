# Requerimientos del Sistema

## D: REQ-001

**Descripción:**

El sistema debe proporcionar un software planeador de horarios universitarios para la Universidad Tecnológica de Bolívar (UTB), dirigido a los estudiantes y a los directivos de la institución. El objetivo es facilitar la planificación académica mediante la generación automática de todas las combinaciones posibles de horarios, basadas en las materias seleccionadas por los estudiantes.

### Requisitos Funcionales:

- **REQ-001.1:** El sistema debe permitir a los estudiantes ingresar los códigos de sus materias y generar automáticamente todas las combinaciones posibles de horarios.
- **REQ-001.2:** El sistema debe mostrar en cada combinación de horario el código de la clase (NRC), profesor asignado y salón.
- **REQ-001.3:** El sistema debe permitir a los estudiantes filtrar entre sus preferencias (horario de clase preferido, profesores, etc.) y recibir opciones de horarios personalizados.
- **REQ-001.4:** El sistema debe permitir guardar y exportar los horarios en formatos como PDF o JPG.
- **REQ-001.5:** El sistema debe enviar notificaciones vía e-mail a los usuarios sobre variaciones en sus horarios (cambio de salón, de profesor, etc.).

**Prioridad:** Alta  
**Dependencias:** Ninguna  
**Notas:** Este requerimiento es fundamental para asegurar que los estudiantes puedan planificar sus horarios de manera eficiente y personalizada.

---

## D: REQ-002

**Descripción:**

El sistema debe integrarse dinámicamente con la base de datos de la UTB para actualizar la información sobre horarios, salones y disponibilidad de profesores en tiempo real.

### Requisitos Funcionales:

- **REQ-002.1:** El sistema debe permitir la actualización dinámica de datos de horarios, salones y profesores proporcionados por la UTB.
- **REQ-002.2:** Los administradores designados deben poder gestionar y modificar la información almacenada en la base de datos de manera segura y eficiente.

**Prioridad:** Alta  
**Dependencias:** REQ-001  
**Notas:** Este requerimiento garantiza que la información utilizada por el sistema esté siempre actualizada y sea precisa.

---

## D: REQ-003

**Descripción:**

El sistema debe ofrecer una interfaz gráfica de usuario (GUI) intuitiva y accesible, compatible con dispositivos móviles y de escritorio.

### Requisitos Funcionales:

- **REQ-003.1:** La GUI debe permitir a los estudiantes ingresar sus preferencias y seleccionar entre las combinaciones de horarios generadas.
- **REQ-003.2:** El sistema debe ofrecer soporte en varios idiomas, incluyendo español e inglés.
- **REQ-003.3:** La interfaz debe ser funcional en una variedad de dispositivos, incluyendo PCs, laptops, tablets y smartphones, y debe ser compatible con los principales navegadores web (Chrome, Firefox, Safari, Edge).

**Prioridad:** Media  
**Dependencias:** REQ-001, REQ-002  
**Notas:** La accesibilidad y facilidad de uso son clave para asegurar que todos los estudiantes puedan utilizar el sistema sin inconvenientes.

---

## D: REQ-004

**Descripción:**

El sistema debe ser escalable y capaz de manejar el acceso simultáneo de un gran número de estudiantes, especialmente durante los períodos de inscripción y cambios de semestre.

### Requisitos No Funcionales:

- **REQ-004.1:** El sistema debe ser capaz de procesar y generar horarios en tiempo real para al menos 5000 estudiantes simultáneamente.
- **REQ-004.2:** El sistema debe estar disponible el 99.9% del tiempo, con una tolerancia mínima a fallos durante períodos críticos como la inscripción de materias.

**Prioridad:** Alta  
**Dependencias:** Ninguna  
**Notas:** La escalabilidad y alta disponibilidad son esenciales para el correcto funcionamiento del sistema durante los períodos de mayor demanda.

---

## D: REQ-005

**Descripción:**

El sistema debe cumplir con las políticas de privacidad y protección de datos de la UTB y las regulaciones locales sobre manejo de información personal.

### Requisitos del Sistema:

- **REQ-005.1:** El acceso al sistema debe estar restringido a usuarios autenticados mediante el sistema de autenticación de la UTB (correo institucional).
- **REQ-005.2:** Toda la información personal y académica debe estar encriptada durante la transmisión y almacenamiento.
- **REQ-005.3:** Los datos temporales almacenados en la base de datos deben ser eliminados periódicamente para evitar la retención innecesaria de información sensible.

**Prioridad:** Alta  
**Dependencias:** Ninguna  
**Notas:** La seguridad y privacidad de los datos son fundamentales para proteger la información personal de los estudiantes y cumplir con las normativas de la universidad.
