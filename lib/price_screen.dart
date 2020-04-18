import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Only show certain classes from this imported package
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropdownValue = 'USD';

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
      value: dropdownValue,
      items: dropdownItems,
      onChanged: (newValue) {
        setState(
          () {
            dropdownValue = newValue;
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
      },
      children: cupertinoValues,
    );
  }

  // Use the dart:io Platform class to determine the platform and choose a picker
  Widget getPicker () {
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
                  '1 BTC = ? USD',
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
