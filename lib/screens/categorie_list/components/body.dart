import 'dart:convert';
import 'package:http/http.dart' as http;



class ApiService {
  static Future<List<dynamic>> getCategories() async {
    final response = await http.get(Uri.parse(Config.apiUrl + 'categories?fields=name,image'));
    if (response.statusCode == 200) {
      List<dynamic> categories = jsonDecode(response.body);
      return categories.map((category) => {
        'name': category['name'],
        'image': category['image']
      }).toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }
}


class Config {
static const String apiUrl = 'http://localhost:8000/api/';

}
