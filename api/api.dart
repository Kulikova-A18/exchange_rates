import 'dart:async';
import 'package:http/http.dart' as http;

const String CBR_URL = 'https://www.cbr-xml-daily.ru/daily_json.js';

Future<http.Response> getCurrentRates() {
  return http.get(Uri.parse(CBR_URL));
}
