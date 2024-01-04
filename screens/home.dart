import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:exchange_rates/components/rates_list.dart';
import 'package:exchange_rates/api/api.dart';
import 'package:exchange_rates/models/rate.dart';

import 'package:exchange_rates/components/scale_route.dart';
import 'package:exchange_rates/screens/information.dart';

import 'package:exchange_rates/components/header_image.dart';

const MONTHS = {
  1: 'января',
  2: 'февраля',
  3: 'марта',
  4: 'апреля',
  5: 'мая',
  6: 'июня',
  7: 'июля',
  8: 'августа',
  9: 'сентября',
  10: 'октября',
  11: 'ноября',
  12: 'декабря',
};

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Rate> rateList = [];

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    return Scaffold(
      appBar: appBarr(context),
      backgroundColor: Color.fromARGB(255, 17, 28, 24),
      body: FractionallySizedBox(
        heightFactor: 1,
        child: Stack(
          children: <Widget>[
            HeaderImage(
              height: 300,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 120,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 110,
                    top: 50,
                    child: Text(
                      '${MONTHS[date.month]}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: RatesList(
                list: rateList,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getJSONData() async {
    try {
      var response = await getCurrentRates();

      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);
        var rates = Map<String, dynamic>.from(decoded['Valute']);

        setState(() {
          rateList = rates.keys.toList().map((key) {
            return Rate(
                code: key,
                value: rates[key]['Previous'] / rates[key]['Nominal'],
                date: decoded['Date'],
                name: rates[key]['Name'],
                previous: rates[key]['Value'] / rates[key]['Nominal']);
          }).toList();
        });
      } else {
        var decoded = json.decode(response.body);
        throw Exception(decoded['message']);
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ошибка'),
              content: Text('$e'),
              actions: <Widget>[
                TextButton(
                  child: new Text('Ok'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }
  }

  appBarr(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 17, 28, 24),
      iconTheme: IconThemeData(color: Colors.white),
      title: const Text(
        'Курсы валют',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context)
                .push<void>(ScaleRoute(page: InformationScreen()));
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    this.getJSONData();
  }
}
