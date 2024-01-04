import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:exchange_rates/components/header_image.dart';

const String informationData = '© ALENA KULIKOVA otus.ru';

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
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
                  buildCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 17, 28, 24),
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        'Информация о продукте',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  buildCard() {
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
            children: [buildCenter()],
          ),
        ),
      ),
    );
  }

  buildCenter() {
    return Container(
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              informationData,
              style: TextStyle(
                color: Colors.white,
                fontSize: 110,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
