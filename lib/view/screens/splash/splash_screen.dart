import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/cart_controller.dart';
import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/wishlist_controller.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    Get.find<CartController>().getCartData();
    _route();

  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if(isSuccess) {
        Timer(Duration(seconds: 1), () async {
          int _minimumVersion = 0;
          if(GetPlatform.isAndroid) {
            _minimumVersion = Get.find<SplashController>().configModel.appMinimumVersionAndroid;
          }else if(GetPlatform.isIOS) {
            _minimumVersion = Get.find<SplashController>().configModel.appMinimumVersionIos;
          }
          if(AppConstants.APP_VERSION < _minimumVersion || Get.find<SplashController>().configModel.maintenanceMode) {
            Get.offNamed(RouteHelper.getUpdateRoute(AppConstants.APP_VERSION < _minimumVersion));
          }else {
            if (Get.find<AuthController>().isLoggedIn()) {
              Get.find<AuthController>().updateToken();
              await Get.find<WishListController>().getWishList();
              if (Get.find<LocationController>().getUserAddress() != null) {
                Get.offNamed(RouteHelper.getInitialRoute());
              } else {
                Get.offNamed(RouteHelper.getAccessLocationRoute('splash'));
              }
            } else {
              //اخيتار اللغة يعرض مرة واحدة فقط
              /*if (Get.find<SplashController>().showIntro()) {
                Get.offNamed(RouteHelper.getLanguageRoute('splash'));
              }
               */
               
                
                Get.offNamed(RouteHelper.getInitialRoute());
               // Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
              
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
     double height = MediaQuery.of(context).size.height;
     
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _globalKey,
      body: Center(
        child: 


        Shimmer.fromColors(
      baseColor: Colors.transparent,
      highlightColor: Colors.white,
      enabled: true,
      child: Container(
       // width: width,
      //  height: height,
        color: Colors.transparent,
        padding: EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Image.asset(Images.logo, height: height * 0.2), 
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
           // Image.asset(Images.logo_name, width: 150),
            /*SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: 25)),*/
          ],
        )),
      ),
    )
        
        
        
        
      ),
    );
  }
}
