import 'package:http/http.dart' as http;
class ApiServis{
  static Future<http.Response> haberleriGetir() {
    return http.get(Uri.parse("https://service.stemabkm.com/Api/KonyaHaberleri"));
  }
}