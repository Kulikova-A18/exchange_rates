import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:exchange_rates/models/rate.dart';
import 'package:intl/intl.dart';
import 'package:exchange_rates/screens/detail.dart';
import 'package:exchange_rates/components/scale_route.dart';
import 'package:exchange_rates/models/provider.dart';
import 'package:provider/provider.dart';

var formatter = DateFormat('dd.MM.yyyy');

class RateItem extends StatelessWidget {
  final Rate item;

  RateItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => goToDetail(context, item),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 250,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 23, 143, 139).withOpacity(0.4),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              children: <Widget>[
                left(),
                center(),
                SizedBox(
                  width: 15,
                ),
                right(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  left() {
    return Container(
      width: 250,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            item.code,
            style: TextStyle(
              color: Color(0xffcccccc),
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            item.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xff999999),
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }

  center() {
    return Container(
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '${item.value.toStringAsFixed(2)}',
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  right(BuildContext context) {
    var diff = item.value - item.previous;
    var percent = (item.value / item.previous - 1) * 100;
    return Container(
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        color: Color.fromARGB(255, 23, 143, 139),
      ),
      margin: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${diff.toStringAsFixed(4)}',
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${percent.toStringAsFixed(2)} %',
            style: TextStyle(
              color: Color(0xffeeeeee),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  goToDetail(BuildContext context, Rate rate) {
    Provider.of<RateProvider>(context, listen: false).setCurrentRate(rate);
    Navigator.of(context).push<void>(ScaleRoute(page: DetailScreen()));
  }
}
