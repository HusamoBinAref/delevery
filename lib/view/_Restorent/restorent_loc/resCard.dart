import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class RestorentCardH extends StatelessWidget {
  final List<Restaurant> restaurants;
  
  
  final Restaurant selectRestaurent;


  RestorentCardH({
    @required this.restaurants,

    this.selectRestaurent
  });

  @override
  Widget build(BuildContext context) {
    int _length = 0;

    _length = restaurants.length;

    double _w = MediaQuery.of(context).size.width;

    return 
    
    AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _length,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: Duration(milliseconds: 2500),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 2500),
                child: Container(
                    margin: EdgeInsets.only(bottom: 4),
                    height: _w / 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Card(
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Text(restaurants[index].name),
                      ),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
