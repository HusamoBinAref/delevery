import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '__restorent_shimmer.dart';
import '_restorent_CardLine.dart';

class RestorentListView extends StatelessWidget {
 // final List<Product> products;
  final List<Restaurant> restaurants;
 // final bool inRestaurant;
  final EdgeInsetsGeometry padding;
  final bool isScrollable;
  final int shimmerLength;
  final String noDataText;
  final bool isCampaign;
 


  RestorentListView({@required this.restaurants,
  // @required this.inRestaurant, 
  this.isScrollable = false,
    this.shimmerLength = 20, this.padding = const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL), this.noDataText,
    this.isCampaign = false
    
   
    });

  @override
  Widget build(BuildContext context) {
    bool _isNull = true;
    int _length = 0;
   
      _isNull = restaurants == null;
      if(!_isNull) {
        _length = restaurants.length;
      
    }

     double _w = MediaQuery.of(context).size.width;

    return !_isNull ? _length > 0 ? 

     
      AnimationLimiter(
        child: ListView.builder(
          shrinkWrap: isScrollable ? false : true,
        
      itemCount: _length,
      padding: padding,
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        
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
                      /*boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],*/
                    ),
                    child: RestorentCardLine(
          
          restaurant:  restaurants[index] ,
           index: index,
            length: _length, 
           isCampaign:  isCampaign,
         // inRestaurant: inRestaurant,
        ),
                  ),
                ),
              ),
            );
          },
        ),
      
    ) : NoDataScreen(
      text: noDataText != null ? noDataText :  'no_restaurant_available'.tr ,
    ) : GridView.builder(
      key: UniqueKey(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
        mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_LARGE : 0.01,
        childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 4,
        crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
      ),
      physics: isScrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
      shrinkWrap: isScrollable ? false : true,
      itemCount: shimmerLength,
      padding: padding,
      itemBuilder: (context, index) {
        return 
       
        
      RestorentShimmer(isEnabled: _isNull, isRestaurant: true, hasDivider: index != shimmerLength-1);
      },
    );
  
    
    /*
    GridView.builder(
      key: UniqueKey(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
        mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_LARGE : 0.01,
        childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 4,
        crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
      ),
      physics: isScrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
      shrinkWrap: isScrollable ? false : true,
      itemCount: _length,
      padding: padding,
      itemBuilder: (context, index) {
        return 
      
        RestorentWidget(
          
          restaurant:  restaurants[index] ,
           index: index,
            length: _length, 
           isCampaign:  isCampaign,
          inRestaurant: inRestaurant,
        );
      },
    ) : NoDataScreen(
      text: noDataText != null ? noDataText :  'no_restaurant_available'.tr ,
    ) : GridView.builder(
      key: UniqueKey(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
        mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_LARGE : 0.01,
        childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 4,
        crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
      ),
      physics: isScrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
      shrinkWrap: isScrollable ? false : true,
      itemCount: shimmerLength,
      padding: padding,
      itemBuilder: (context, index) {
        return 
       
        
      ProductShimmer(isEnabled: _isNull, isRestaurant: true, hasDivider: index != shimmerLength-1);
      },
    );*/
  }
}
