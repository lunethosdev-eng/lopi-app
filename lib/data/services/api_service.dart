import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://tu-backend-en-render.onrender.com";

  static Future<List<dynamic>> fetchLatestEpisodes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/latest'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return data['data'];
        }
      }
    } catch (e) {
      print("Error conectando al backend: $e");
    }
    return [];
  }

  // Método automático para enviar ping a Render y evitar que se duerma
  static void keepAlive() async {
    try {
      await http.get(Uri.parse('$baseUrl/ping'));
    } catch (_) {}
  }
}
