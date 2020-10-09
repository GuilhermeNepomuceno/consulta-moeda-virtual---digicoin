import 'package:http/http.dart' as http;
import 'package:digicoin/classes/ticker.dart';
import 'dart:async';
import 'dart:convert';

class TickerControl {
  Map<int, String> _coins = {
    1: 'BTC',
    2: 'BCH',
    3: 'ETH',
    4: 'LTC',
  };

  Future<Ticker> getResumoDiario(int coin) async {
    var response = await http
        .get('https://www.mercadobitcoin.net/api/${_coins[coin]}/ticker');
    if (response.statusCode == 200) {
      return Ticker.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Indisponible service');
    }
  }
}
