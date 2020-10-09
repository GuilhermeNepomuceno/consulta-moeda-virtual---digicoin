class ResumoDiario {
  ResumoDiario(
    this._high,
    this._low,
    this._vol,
    this._last,
    this._buy,
    this._sell,
    this._open,
  );

  double _high;
  double _low;
  double _vol;
  double _last;
  double _buy;
  double _sell;
  double _open;

  factory ResumoDiario.fromJson(Map<String, dynamic> json) {
    return ResumoDiario(
      double.parse(json["high"]),
      double.parse(json["low"]),
      double.parse(json["vol"]),
      double.parse(json["last"]),
      double.parse(json["buy"]),
      double.parse(json["sell"]),
      double.parse(json["open"]),
    );
  }

  double get getHigh {
    return this._high;
  }

  double get getLow {
    return this._low;
  }

  double get getVol {
    return this._vol;
  }

  double get getLast {
    return this._last;
  }

  double get getBuy {
    return this._buy;
  }

  double get getSell {
    return this._sell;
  }

  double get getOpen {
    return this._open;
  }
}
