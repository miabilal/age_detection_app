import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey =
      '9355a276c7msh51e2c73c9fd6413p1d4436jsn4be91a753d3a';
  static const String _apiHost = 'age-detector.p.rapidapi.com';
  static const String _apiUrl = 'https://$_apiHost/age-detection';
  Future<List<dynamic>> detectAge(String base64Image) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'X-Rapidapi-Key': _apiKey,
        'X-Rapidapi-Host': _apiHost,
      },
      body: jsonEncode({
        'image': base64Image, // Sending base64 image data
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to detect age');
    }
  }
}
