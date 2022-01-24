import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitcoin_tracker/coin_api.dart';
import 'package:flutter_bitcoin_tracker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var selectedCurrency = 'USD';
  String bitcoinRate = '?';

  final coinApi = CoinApi();

  updateUI() async {
    print('calling with selectedCurrency: $selectedCurrency');
    final double? rate = await coinApi.getExchangeRate(selectedCurrency);
    print('rate in currency');
    print("$rate in $selectedCurrency");
    setState(() {
      bitcoinRate = rate?.toStringAsFixed(0) ?? '?';
    });
  }

  getDropDownWidget() {
    return Platform.isIOS
        ? CupertinoPicker(
            itemExtent: 32.0,
            onSelectedItemChanged: (itemIndex) {
              setState(() {
                selectedCurrency = currenciesList[itemIndex];
              });
              updateUI();
            },
            backgroundColor: Colors.lightBlue,
            children: currenciesList.map((e) => Text(e)).toList(),
          )
        : DropdownButton(
            value: selectedCurrency,
            style: const TextStyle(fontSize: 20.0),
            items: currenciesList
                .map((e) => DropdownMenuItem(child: Text(e), value: e))
                .toList(),
            onChanged: (String? value) {
              setState(() {
                selectedCurrency = value ?? selectedCurrency;
              });
              updateUI();
            },
          );
  }

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getDropDownWidget()),
        ],
      ),
    );
  }
}
