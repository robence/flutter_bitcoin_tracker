import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CoinApi {
  final _apiUrl = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD';
  final _apiKey = dotenv.env['API_KEY'];

  Future<int?> getExchangeRate() async {
    final response = await http.get(Uri.parse('$_apiUrl?apikey=$_apiKey'));
    if (response.statusCode == 200) {
      print(response.body);
      print(response.statusCode);
      final parsedData = const JsonDecoder().convert(response.body);
      final double rate = parsedData['rate'];
      print('rate');
      print(rate);
      return rate.toInt();
    } else {
      print(response.statusCode);
    }
  }
}
