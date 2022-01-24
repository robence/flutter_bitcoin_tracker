import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CoinApi {
  final _apiUrl = 'https://rest.coinapi.io/v1/exchangerate';
  final _apiKey = dotenv.env['API_KEY'];

  Future<double?> getExchangeRate(String currency) async {
    final response =
        await http.get(Uri.parse('$_apiUrl/BTC/$currency?apikey=$_apiKey'));
    if (response.statusCode == 200) {
      final parsedData = jsonDecode(response.body);
      final double rate = parsedData['rate'];
      return rate;
    } else {
      print("Error getting exchange rate for coin: BTC in currency USD");
      print(response.statusCode);
    }
  }
}
