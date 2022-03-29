import 'dart:async';

import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/_shareWidget/appbar.dart';
import 'package:efood_multivendor/view/base/cart_widget.dart';

import 'package:efood_multivendor/view/screens/cart/cart_screen.dart';
import 'package:efood_multivendor/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:efood_multivendor/view/screens/favourite/favourite_screen.dart';
import 'package:efood_multivendor/view/screens/home/home_screen.dart';
import 'package:efood_multivendor/view/screens/menu/menu_screen.dart';
import 'package:efood_multivendor/view/screens/order/order_screen.dart';
import 'package:efood_multivendor/view/screens/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      CartScreen(fromNav: true),
      FavouriteScreen(),

      // OrderScreen(),
    ];

    /*if(GetPlatform.isMobile) {
      NetworkInfo.checkConnectivity(_scaffoldKey.currentContext);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (_canExit) {
            return true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr,
                  style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            _canExit = true;
            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: appBarMain(context, 'خدمات'),

        /* floatingActionButton: ResponsiveHelper.isDesktop(context) ? null : 
        FloatingActionButton(
          elevation: 5,
          backgroundColor: _pageIndex == 2 ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
          onPressed: () => _setPage(2),
          child: CartWidget(color: _pageIndex == 2 ? Theme.of(context).cardColor : Theme.of(context).disabledColor, size: 30),
        ),*/
        floatingActionButtonLocation: ResponsiveHelper.isDesktop(context)
            ? null
            : FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: ResponsiveHelper.isDesktop(context)
            ? SizedBox()
            : 
            Container(
                height: size.width * .130 //50

                ,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          _setPage(0);
                        },
                        child: bottomIcon(0, size, 'خدمات')),
                    InkWell(
                        onTap: () {
                          _setPage(1);
                        },
                        child: bottomIcon(1, size, 'السلة',iscard: true)),
                    InkWell(
                        onTap: () {
                          _setPage(2);
                        },
                        child: bottomIcon(2, size, 'المفضلة')),
                    /* InkWell(
                        onTap: () {
                          _setPage(3);
                        },
                        child: bottomIcon(3, size,'بحث')),*/
                  ],
                ),
              ),

/*

          Container(
                margin: EdgeInsets.only(bottom: 0,left: 5,right: 5,top: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
                   BottomNavigationBar(
                    currentIndex: _pageIndex,
                    onTap: _onChanged,
                    type: BottomNavigationBarType.fixed,
                    showUnselectedLabels: true,
                    backgroundColor: Theme.of(context).primaryColor,
                    fixedColor: Colors.white,
                    
                    unselectedItemColor: Colors.white70,
                    unselectedFontSize: 13,
                    selectedFontSize: 14,
                    items: [
                      BottomNavigationBarItem(
                        icon: Container(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.home,
                            size: 26,
                          ),
                        ),
                        label: 'خدمات',

                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.favorite,
                            size: 26,
                          ),
                        ),
                        label: 'المفضلة',
                      ),
                      BottomNavigationBarItem(
                        icon:CartWidget(color: _pageIndex == 2 ? Theme.of(context).cardColor : Theme.of(context).disabledColor, size: 30),
                        label: 'السلة',
                      ),
                       BottomNavigationBarItem(
                        icon: BottomNavItem(iconData: Icons.shopping_bag, isSelected: _pageIndex == 3, onTap: () => _setPage(3)),
                        label: 'طلباتي',
                      ),
/*
                      BottomNavigationBarItem(
                        icon:BottomNavItem(iconData: Icons.menu, isSelected: _pageIndex == 4, onTap: () {
                Get.bottomSheet(MenuScreen(), backgroundColor: Colors.transparent, isScrollControlled: true);
              }),
                        label: 'الحساب',
                      ),*/
                      
                    ],
                  ),
                ),
              ),
        */
        /*
         BottomAppBar(
          elevation: 5,
          notchMargin: 5,
          shape: CircularNotchedRectangle(),

          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Row(children: [
              BottomNavItem(iconData: Icons.home, isSelected: _pageIndex == 0, onTap: () => _setPage(0)),
              BottomNavItem(iconData: Icons.favorite, isSelected: _pageIndex == 1, onTap: () => _setPage(1)),
              Expanded(child: SizedBox()),
              BottomNavItem(iconData: Icons.shopping_bag, isSelected: _pageIndex == 3, onTap: () => _setPage(3)),
              BottomNavItem(iconData: Icons.menu, isSelected: _pageIndex == 4, onTap: () {
                Get.bottomSheet(MenuScreen(), backgroundColor: Colors.transparent, isScrollControlled: true);
              }),
            ]),
          ),
        )*/

        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  Widget bottomIcon(int index, Size size, String txt,{bool iscard=false}) {

    var pr=Theme.of(context).primaryColor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 1500),
          curve: Curves.fastLinearToSlowEaseIn,
          margin: EdgeInsets.only(
            bottom: index == _pageIndex ? 0 : size.width * .020,
            right: size.width * .0422,
            left: size.width * .0422,
          ),
          width: size.width * .128,
          height: index == _pageIndex ? size.width * .002 : 0,
          decoration: BoxDecoration(
            color: pr,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(5),
            ),
          ),
        ),
        !iscard? 
        Icon(
          listOfIcons[index],
          size: size.width * .055,
          color: index == _pageIndex ? pr : Colors.black87,
        ):


Image.asset('assets/image/ic_cart.png',height: 20,width: 20,
color: index == _pageIndex ?pr : Colors.black87,
),

        //SizedBox(height: size.width * .02),
        Text(
          txt,
          style: TextStyle(
              color: index == _pageIndex ? Colors.blueAccent : Colors.black87,
              fontSize: index == _pageIndex ? 13 : 12),
        )
      ],
    );
  }

  List<IconData> listOfIcons = [
    CupertinoIcons.home,
    CupertinoIcons.cart,
    CupertinoIcons.heart,
  ];
}
