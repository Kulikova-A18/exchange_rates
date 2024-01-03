import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exchange_rates/models/provider.dart';

import 'dart:ui';
import 'package:exchange_rates/components/header_image.dart';
import 'package:exchange_rates/models/rate.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var rate = Provider.of<RateProvider>(context).currentrate;
    return Scaffold(
      appBar: buildAppBar(rate),
      backgroundColor: Color.fromARGB(255, 17, 28, 24),
      body: FractionallySizedBox(
        heightFactor: 1,
        child: Stack(
          children: <Widget>[
            HeaderImage(
              height: 150,
              child: Container(),
            ),
            Positioned.fill(
              child: ListView(
                children: <Widget>[
                  buildCard(rate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildAppBar(Rate rate) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 17, 28, 24),
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        rate.name,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  buildCard(Rate rate) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 500,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 23, 143, 139).withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [buildCenter(rate), buildRight()],
          ),
        ),
      ),
    );
  }

  buildCenter(Rate rate) {
    return Container(
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              rate.value.toStringAsFixed(4),
              style: TextStyle(
                color: Colors.white,
                fontSize: 110,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Вчера: ${rate.previous.toStringAsFixed(4)}',
                  style: TextStyle(
                    color: Color(0xffdddddd),
                    fontSize: 40,
                  ),
                ),
                rate.value - rate.previous >= 0
                    ? Icon(
                        Icons.arrow_drop_up,
                        color: Color(0xffdddddd),
                        size: 60.0,
                      )
                    : Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xffdddddd),
                        size: 60.0,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildRight() {
    return Container(
      width: 100,
      child: Text(
        'руб.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
