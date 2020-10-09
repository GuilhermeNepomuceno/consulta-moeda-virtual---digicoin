import 'package:digicoin/classes/resumoDiario.dart';

class Ticker {
  Ticker({
    this.resumo,
  });

  ResumoDiario resumo;

  factory Ticker.fromJson(Map<String, dynamic> json) => Ticker(
        resumo: ResumoDiario.fromJson(json["ticker"]),
      );
}
