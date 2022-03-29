import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/_Restorent/_restorentList_view.dart';
import 'package:efood_multivendor/view/_Restorent/restorentGrid_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantView extends StatelessWidget {
  final ScrollController scrollController;
 
  RestaurantView({this.scrollController });

  @override
  Widget build(BuildContext context) {
    Get.find<RestaurantController>().setOffset(1);
    scrollController?.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent
          && Get.find<RestaurantController>().restaurantList != null
          && !Get.find<RestaurantController>().isLoading) {
        int pageSize = (Get.find<RestaurantController>().popularPageSize / 10).ceil();
        if (Get.find<RestaurantController>().offset < pageSize) {
          Get.find<RestaurantController>().setOffset(Get.find<RestaurantController>().offset+1);
          print('end of the page');
          Get.find<RestaurantController>().showBottomLoader();
          Get.find<RestaurantController>().getRestaurantList(Get.find<RestaurantController>().offset.toString(), false);
        }
      }
    });
    return GetBuilder<RestaurantController>(builder: (restController) {
      return 
      !restController.isGrid
      ?
      Column(children: [

        RestorentListView(
         
          restaurants: restController.restaurantList,
         /* padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
            vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
          ),*/ 
          
         // inRestaurant: true,
        ),

        
      /*  ProductView(
          isRestaurant: true, products: null, restaurants: restController.restaurantList,
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
            vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
          ),
        ),*/

        restController.isLoading ? Center(child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
        )) : Divider(),
      //  SizedBox(),
      ])
      :
      RestorentGridView( restaurants: restController.restaurantList,)
      
      ;
    });
  }
}
