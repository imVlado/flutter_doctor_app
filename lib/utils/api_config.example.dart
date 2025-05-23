class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
     // Cambia aquí tu backend real para desarrollo
     // Quita el ".example" del nombre del archivo.
    defaultValue: 'http://TU_BACKEND_URL_AQUI',
  );
}