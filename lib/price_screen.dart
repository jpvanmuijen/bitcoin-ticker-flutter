import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
// Only show certain classes from this imported package
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currencyDropdown = 'USD';  
  double rate;

  Future getExchangeRates(String coin, String currency) async {
    //var url =
        '$coinAPIexchangerate/BTC/$currencyDropdown/?apikey=$coinAPIkey';
        var url = 'https://rest.coinapi.io/v1/exchangerate/BTC/EUR/?apikey=467F83A6-B238-40F8-A78D-CB05CC819957';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // return jsonResponse;
      rate = jsonResponse['rate'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  // Lesson 173
  DropdownButton<String> androidDropdown() {
    // Create an empty list to hold the items, must contain the type and its childrens type
    List<DropdownMenuItem<String>> dropdownItems = [];
    // Loop through de currencylist, create a new item for each currency
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      // Add item to the list
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: currencyDropdown,
      items: dropdownItems,
      onChanged: (newValue) {
        setState(
          () {
            currencyDropdown = newValue;
            getExchangeRates('BTC', currencyDropdown);
          },
        );
      },
    );
  }

  // Lesson 173
  CupertinoPicker iOSPicker() {
    // Lists and maps should be empty, not null
    List<Text> cupertinoValues = [];
    // This time we're using a for-in-loop
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      // Add item to the list
      cupertinoValues.add(newItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      magnification: 1.2,
      useMagnifier: true,
      itemExtent: 30.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        getExchangeRates('BTC', currenciesList[selectedIndex]);
      },
      children: cupertinoValues,
    );
  }

  // Use the dart:io Platform class to determine the platform and choose a picker
  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }

  /*
  // Lesson 171: get dropdown items, as a List of DropdownMenuItems
  List<DropdownMenuItem> getDropdownItems() {
    // Create an empty list to hold the items, must contain the type and its childrens type
    List<DropdownMenuItem<String>> dropdownItems = [];
    // Loop through de currencylist, create a new item for each currency
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      // Add item to the list
      dropdownItems.add(newItem);
    }
    // Return the List
    return dropdownItems;
  }

  // Lesson 172: create list for Cupertino dropdown items
  List<Text> createCupertinoItems() {
    // Lists and maps should be empty, not null
    List<Text> cupertinoValues = [];
    // This time we're using a for-in-loop
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      // Add item to the list
      cupertinoValues.add(newItem);
    }
    return cupertinoValues;
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $rate $currencyDropdown',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
            // Shorthand turnary version
            //child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
