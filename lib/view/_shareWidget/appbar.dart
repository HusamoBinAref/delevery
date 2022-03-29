import 'dart:math';

import 'package:efood_multivendor/controller/notification_controller.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/theme/_style.dart';
import 'package:efood_multivendor/view/base/cart_widget.dart';
import 'package:efood_multivendor/view/screens/menu/menu_screen.dart';
import 'package:efood_multivendor/view/screens/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';



import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

Widget appBarPage(context, String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: HStyle.secondaryTextColor,
      ),
    ),
    backgroundColor: Theme.of(context).primaryColor,
    leading: IconButton(
      padding: EdgeInsets.all(0.0),
      icon: Icon(
        Icons.arrow_back_ios,
        color: HStyle.secondaryTextColor,
      ),
      onPressed: () => Navigator.pop(context),
    ),
  );
}

Widget appBarMain(context, String title) {
  return AppBar(
     backgroundColor: Theme.of(context).primaryColor,// Colors.white,
    brightness: Brightness.light,
    elevation: 0,
    title: Text('خدمات'),
    actions: [
      InkWell(
        onTap: () {
          Get.to(MenuScreen());

//Get.bottomSheet(MenuScreen(), backgroundColor: Colors.transparent, isScrollControlled: true);
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Icon(CupertinoIcons.person_crop_circle, size: 25),
        ),
      ),
         MyPlugin(),
      InkWell(
                child: GetBuilder<NotificationController>(
                    builder: (notificationController) {
                  bool _hasNewNotification = false;
                  if (notificationController.notificationList != null) {
                    _hasNewNotification =
                        notificationController.notificationList.length !=
                            notificationController.getSeenNotificationCount();
                  }
                  return
                  
                  Padding(
          padding: const EdgeInsets.all(15),
                     child: Stack(children: [
                      Icon(Icons.notifications,
                          size: 25,
                         // color: Theme.of(context).textTheme.bodyText1.color
                          ),
                      _hasNewNotification
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1,
                                      color: Theme.of(context).cardColor),
                                ),
                              ))
                          : SizedBox(),
                  ]),
                   );
                }),
                onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
              ),
      
   
      
    ],
  );
  /* AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: HStyle.secondaryTextColor,
      ),
    ),
    backgroundColor: Theme.of(context).primaryColor,
    actions: [

      Container(
        padding: EdgeInsets.only(top: 9,right: 20,left: 25,bottom: 9),
        
        child: CartWidget(color: Theme.of(context).cardColor, size: 30))
    ],
   /* leading: IconButton(
      padding: EdgeInsets.all(0.0),
      icon: Icon(
        Icons.arrow_back_ios,
        color: HStyle.secondaryTextColor,
      ),
      onPressed: () => Navigator.pop(context),
    ),*/
  );*/
}
//////////
///
///
///
///
///////
///
///
///
///
///
///




class MyPlugin extends StatefulWidget {
  @override
  _MyPluginState createState() => _MyPluginState();
}

class _MyPluginState extends State<MyPlugin> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: OpenContainer(
          closedBuilder: (_, openContainer) {
            return Container(
            //  height: 20,
             // width: 20,
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: openContainer,
                icon: Icon(
                  CupertinoIcons.search,
                  size: 25,
                  
                ),
              ),
            );
          },
          openColor: Colors.transparent,
          closedElevation: 50.0,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          closedColor: Colors.transparent,
          openBuilder: (_, closeContainer) {
            return SearchScreen();
            
             /*Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: Text("Go back"),
                leading: IconButton(
                  onPressed: closeContainer,
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              body: SearchScreen(),
            );*/
          },
        ))
      ;
  }
}