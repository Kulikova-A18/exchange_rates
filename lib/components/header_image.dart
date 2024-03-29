import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  final double height;
  final Widget child;

  HeaderImage({required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/adobe-mountains-nature-simple-wallpaper-preview.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
