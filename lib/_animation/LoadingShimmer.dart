
import 'package:efood_multivendor/util/images.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '_widgetAnimator.dart';

class LoadingShimmer_ extends StatelessWidget {
  final String text;
  LoadingShimmer_({this.text});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: Colors.transparent,
      highlightColor: Colors.white,
      enabled: true,
      child: Container(
        width: width,
        height: height,
        color: Colors.transparent,
        padding: EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(Images.logo, height: height * 0.2),
            WidgetAnimator(
                Text("يتم تحميل البيانات..", style: TextStyle(fontSize: height * 0.02)))
          ],
        )),
      ),
    );
  }
}
