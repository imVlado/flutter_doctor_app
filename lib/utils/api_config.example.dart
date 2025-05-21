class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://TU_BACKEND_URL_AQUI', // Cambia aquí tu backend real para desarrollo
  );
}