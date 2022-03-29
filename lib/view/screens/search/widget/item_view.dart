import 'package:efood_multivendor/controller/search_controller.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/_Restorent/_restorentList_view.dart';
import 'package:efood_multivendor/view/_product/product_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemView extends StatelessWidget {
  final bool isRestaurant;
  ItemView({@required this.isRestaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchController>(builder: (searchController) {
        return SingleChildScrollView(
          child: Center(
            child: 
          SizedBox(width: Dimensions.WEB_MAX_WIDTH,
           child: 
           isRestaurant?
           RestorentListView(
            //isRestaurant: isRestaurant,
            
             restaurants: searchController.searchRestList,
            // inRestaurant: true,
          ):
           //
           ProductView(
            //isRestaurant: isRestaurant,
             products: searchController.searchProductList,
            
          ))),
        );
      }),
    );
  }
}
