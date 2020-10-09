import 'package:digicoin/classes/ticker.dart';
import 'package:digicoin/controller/tickerControl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _moeda;
  int _iterator = 1; //Inicia o app com a req para Bitcoin
  Future<Ticker> _futureTicker;
  TickerControl tController = TickerControl();

  Map<int, List> _coin = {
    1: [FlutterIcons.bitcoin_faw, 'Bitcoin'],
    2: [FlutterIcons.bitcoin_faw5d, 'Bitcoin Cash'],
    3: [FlutterIcons.ethereum_mco, 'Ethereum'],
    4: [FlutterIcons.litecoin_mco, 'Litecoin'],
  };

  void initState() {
    super.initState();

    _moeda = _coin[_iterator].elementAt(1);

    _futureTicker = tController.getResumoDiario(_iterator);
  }

  void _changeCoin(int i) {
    _iterator += i;
    if (_iterator > 4) {
      _iterator = 1;
    } else if (_iterator < 1) {
      _iterator = 4;
    }

    setState(() {
      _moeda = _coin[_iterator].elementAt(1);
      _futureTicker = tController.getResumoDiario(_iterator);
      _iterator *= 1;
    });
  }

  void _update() {
    setState(() {
      _futureTicker = tController.getResumoDiario(_iterator);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: bodyView(),
    );
  }

  Widget bodyView() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [content(), header(), footer()],
        ),
      ),
    );
  }

  Widget content() {
    return Container(
        height: 540,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<Ticker>(
                future: _futureTicker,
                builder: (context, ticker) {
                  if (ticker.hasData) {
                    return Container(
                      height: 400,
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          Card(
                              child: ListTile(
                            title: Text(
                                'R\$ ${ticker.data.resumo.getLow.toStringAsPrecision(8).replaceAll('.', ',')}'),
                            subtitle: Text('Valor mínimo nas últimas 24h'),
                          )),
                          Card(
                              child: ListTile(
                            title: Text(
                                'R\$ ${ticker.data.resumo.getHigh.toStringAsPrecision(8).replaceAll('.', ',')}'),
                            subtitle: Text('Valor máximo nas últimas 24h'),
                          )),
                          Card(
                              child: ListTile(
                            title: Text(
                                '${ticker.data.resumo.getVol.ceilToDouble()}'),
                            subtitle: Text('Volume negociado'),
                          )),
                          Card(
                              child: ListTile(
                            title: Text(ticker.data.resumo.getBuy
                                .toString()
                                .replaceAll('.', ',')),
                            subtitle: Text('Próximas 20 ordens de compra'),
                          )),
                          Card(
                              child: ListTile(
                            title: Text(ticker.data.resumo.getSell
                                .toString()
                                .replaceAll('.', ',')),
                            subtitle: Text('Próximas 20 ordens de venda'),
                          )),
                        ],
                      ),
                    );
                  } else {
                    return LinearProgressIndicator();
                  }
                }),
            Divider(),
          ],
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              bottomLeft: Radius.elliptical(100, 40),
              bottomRight: Radius.elliptical(100, 40)),
        ));
  }

  Widget header() {
    return Positioned(
      top: 27,
      child: Container(
          height: 60,
          width: 200,
          alignment: Alignment.center,
          child: Text(
            _moeda,
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorLight,
                ]),
            borderRadius: BorderRadius.all(Radius.circular(60)),
          )),
    );
  }

  Widget footer() {
    return Positioned(
      bottom: 5,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                iconSize: 60,
                splashColor: Colors.orangeAccent,
                onPressed: () => _changeCoin(-1)),
            Container(
              width: 100,
              height: 100,
              child: IconButton(
                  splashColor: Colors.orangeAccent,
                  tooltip: 'Toque para atualizar os campos',
                  icon: Icon(
                    _coin[_iterator].elementAt(0),
                    color: Colors.white,
                  ),
                  iconSize: 50,
                  onPressed: () {
                    _update();
                  }),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Colors.lightGreen,
                  Theme.of(context).accentColor,
                ]),
              ),
            ),
            IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                iconSize: 60,
                splashColor: Colors.orangeAccent,
                onPressed: () => _changeCoin(1))
          ],
        ),
      ),
    );
  }
}
