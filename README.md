# ContaSync

ContaSync es una aplicación móvil desarrollada en Flutter para ayudar a los contadores y profesionales financieros a mantenerse al día con las noticias contables, recordatorios importantes y fechas clave en el calendario.

## Estructura del Proyecto

### `lib/main.dart`
Este es el punto de entrada principal de la aplicación. Configura la aplicación Flutter y maneja la inicialización de la base de datos.

### `lib/screens/home_page.dart`
Define la estructura principal de la aplicación, incluyendo la barra de navegación inferior y la pantalla de inicio (dashboard). Contiene:
- `HomePage`: Widget principal que maneja la navegación entre las diferentes secciones de la app.
- `DashboardScreen`: Muestra una visión general de las características principales de la aplicación.

### `lib/screens/news_page.dart`
Implementa la página de noticias contables. Muestra una lista de noticias relevantes para los profesionales de la contabilidad.

### `lib/screens/calendar_page.dart`
Proporciona una vista de calendario interactiva donde los usuarios pueden ver y agregar recordatorios para fechas específicas.

### `lib/screens/reminders_page.dart`
Muestra una lista de recordatorios y permite a los usuarios gestionar sus tareas pendientes.

### `lib/screens/splash_screen.dart`
Implementa una pantalla de bienvenida animada que se muestra al iniciar la aplicación.

### `lib/database/database_helper.dart`
Contiene la lógica para interactuar con la base de datos SQLite local. Maneja operaciones como insertar, recuperar y eliminar recordatorios.

## Características Principales

- Dashboard interactivo con información clave
- Noticias contables actualizadas
- Sistema de recordatorios
- Calendario para gestionar fechas importantes
- Interfaz de usuario intuitiva y atractiva

## Instalación y Ejecución

1. Asegúrate de tener Flutter instalado en tu sistema.
2. Clona este repositorio.
3. Ejecuta `flutter pub get` para instalar las dependencias.
4. Conecta un dispositivo o inicia un emulador.
5. Ejecuta `flutter run` para iniciar la aplicación.
