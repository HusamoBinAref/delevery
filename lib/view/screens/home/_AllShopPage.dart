import 'package:cached_network_image/cached_network_image.dart';
import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/banner_controller.dart';
import 'package:efood_multivendor/controller/campaign_controller.dart';
import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/controller/notification_controller.dart';
import 'package:efood_multivendor/controller/product_controller.dart';
import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/theme/_style.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/home/web_home_screen.dart';
import 'package:efood_multivendor/view/screens/home/widget/banner_view.dart';
import 'package:efood_multivendor/view/screens/home/widget/item_campaign_view.dart';
import 'package:efood_multivendor/view/_Restorent/restaurant_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllShopPage extends StatefulWidget {
  AllShopPage({Key key}) : super(key: key);

  @override
  _AllShopPageState createState() => _AllShopPageState();
}

class _AllShopPageState extends State<AllShopPage>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  TabController tabController;

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = true;

  Future<void> _loadData(bool reload) async {
    await Get.find<BannerController>().getBannerList(reload);
    //await Get.find<CategoryController>().getCategoryList(reload);
    await Get.find<ProductController>().getPopularProductList(reload);

   // await Get.find<CampaignController>().getItemCampaignList(reload);

    //await Get.find<CampaignController>().getBasicCampaignList(reload, zoneID);
    await Get.find<RestaurantController>().getRestaurantList('1', reload);
    if (Get.find<AuthController>().isLoggedIn()) {
      await Get.find<UserController>().getUserInfo();
      await Get.find<NotificationController>().getNotificationList(reload);
    }
  }

  Widget _appBarLocation() {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 0),
      child: Center(
          child: Container(
        width: Dimensions.WEB_MAX_WIDTH,
        height: 50,
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(children: [
              Text(
                'موقعك الحالي',
                style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),//  HStyle.primaryTextColor
              ), 
              Expanded(
                  child: InkWell(
                onTap: () =>
                    Get.toNamed(RouteHelper.getAccessLocationRoute('home')),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_SMALL,
                    horizontal: ResponsiveHelper.isDesktop(context)
                        ? Dimensions.PADDING_SIZE_SMALL
                        : 0,
                  ),
                  child: GetBuilder<LocationController>(
                      builder: (locationController) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          locationController.getUserAddress().addressType ==
                                  'home'
                              ? Icons.home_filled
                              : locationController
                                          .getUserAddress()
                                          .addressType ==
                                      'office'
                                  ? Icons.work
                                  : Icons.location_on,
                          size: 20,
                          color: Theme.of(context).primaryColor, //Theme.of(context).textTheme.bodyText1.color
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            locationController.getUserAddress().address,
                            style: robotoRegular.copyWith(
                              color:
                                  Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                       /* Icon(Icons.arrow_drop_down,
                            color: Theme.of(context).textTheme.bodyText1.color),*/
                      ],
                    );
                  }),
                ),
              )),
            
            ]),
          ],
        ),
      )),
    );
  }

  Widget _viewer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Text(
            'عروض اليوم',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          GetBuilder<BannerController>(builder: (bannerController) {
            return bannerController.bannerImageList == null
                ? BannerView(bannerController: bannerController)
                : bannerController.bannerImageList.length == 0
                    ? SizedBox()
                    : BannerView(bannerController: bannerController);
          }),
        ],
      ),
    );
  }


List<String> depts=['مطاعم','سوبر ماركت ','صيدليات'];
int inxSelectDept=0;


  Widget deptView()=>
   Container(
     height: 50,
     child: Padding(
       padding: const EdgeInsets.all(2),
       child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: depts.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                      left: Dimensions.PADDING_SIZE_SMALL,
                                      //right: Dimensions.PADDING_SIZE_SMALL,
                                    ),
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return 
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              setState(() {

                                                 inxSelectDept=index;
                                                
                                              });

                                            await _loadData(true);
                                            },
                                                
                                            child:
                                             Material(
                                  color: index ==
                                                        inxSelectDept?Theme.of(context).primaryColor
                                                    : Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Center(
                                        child:  Text(
                                                      depts[index],
                                                      style: index ==
                                                             inxSelectDept
                                                          ? robotoMedium.copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall,
                                                              color: Colors.white

                                                              
                                                              )
                                                          : robotoRegular.copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall,
                                                              color: Theme.of(context)
                                                                  .primaryColor),
                                                    ),
                                    ),
                                  ),)
                                            
                                            
                                           
                                          ),
                                       SizedBox(
                                         width: 10,
                                       )
                                        ],
                                      );
                                    },
                                  ),
     ),
   );
                       



  final ScrollController _scrollController = ScrollController();

  

  Widget tab1(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)
        ? WebHomeScreen(scrollController: _scrollController)
        : Column(
            // controller: _scrollController,
            // physics: AlwaysScrollableScrollPhysics(),
            children: [
/*
                  // Search Button
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverDelegate(
                        child: Center(
                            child: Container(
                      height: 50,
                      width: Dimensions.WEB_MAX_WIDTH,
                      color: Theme.of(context).backgroundColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: InkWell(
                        onTap: () =>
                            Get.toNamed(RouteHelper.getSearchRoute()),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(
                                Dimensions.RADIUS_SMALL),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      Colors.grey[Get.isDarkMode ? 800 : 200],
                                  spreadRadius: 1,
                                  blurRadius: 5)
                            ],
                          ),
                          child: Row(children: [
                            Icon(Icons.search,
                                size: 25,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            Expanded(
                                child: Text('search_food_or_restaurant'.tr,
                                    style: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).hintColor,
                                    ))),
                          ]),
                        ),
                      ),
                    ))),
                  ),


*/
              Center(
                  child: SizedBox(
                      width: Dimensions.WEB_MAX_WIDTH,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //الفئاااات
                            /* GetBuilder<CategoryController>(
                                builder: (categoryController) {
                              return categoryController.categoryList == null
                                  ? CategoryView(
                                      categoryController:
                                          categoryController)
                                  : categoryController
                                              .categoryList.length ==
                                          0
                                      ? SizedBox()
                                      : CategoryView(
                                          categoryController:
                                              categoryController);
                            }),*/

                            //المنتجااات

/*
                            GetBuilder<ProductController>(
                                builder: (productController) {
                              return productController.popularProductList ==
                                      null
                                  ? PopularFoodView(
                                      productController: productController)
                                  : productController
                                              .popularProductList.length ==
                                          0
                                      ? SizedBox()
                                      : PopularFoodView(
                                          productController:
                                              productController);
                            }),*/


                            GetBuilder<CampaignController>(
                                builder: (campaignController) {
                              return campaignController.itemCampaignList == null
                                  ? ItemCampaignView(
                                      campaignController: campaignController)
                                  : campaignController
                                              .itemCampaignList.length ==
                                          0
                                      ? SizedBox()
                                      : ItemCampaignView(
                                          campaignController:
                                              campaignController);
                            }),

                            /*GetBuilder<CampaignController>(builder: (campaignController) {
                                   return campaignController.basicCampaignList == null ? BasicCampaignView(campaignController: campaignController)
                           : campaignController.basicCampaignList.length == 0 ? SizedBox() : BasicCampaignView(campaignController: campaignController);
                             }),*/

 //زر الفلترة 
/*
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 2, 0, 1),
                              child: GetBuilder<RestaurantController>(
                                  builder: (restaurantController) {
                                return Row(children: [
                                  Expanded(
                                      child: Text(' ', //'all_restaurants'.tr
                                          style: robotoMedium.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge))),

                                                 

                                  restaurantController.restaurantList != null
                                      ? PopupMenuButton(
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                  value: 'all',
                                                  child:
                                                      Text('all'.tr), //'all'.tr
                                                  textStyle:
                                                      robotoMedium.copyWith(
                                                    color: restaurantController
                                                                .restaurantType ==
                                                            'all'
                                                        ? Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .color
                                                        : Theme.of(context)
                                                            .disabledColor,
                                                  )),
                                              PopupMenuItem(
                                                  value: 'take_away',
                                                  child: Text('وجبات جاهزة'
                                                      .tr), //'take_away'.tr
                                                  textStyle:
                                                      robotoMedium.copyWith(
                                                    color: restaurantController
                                                                .restaurantType ==
                                                            'take_away'
                                                        ? Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .color
                                                        : Theme.of(context)
                                                            .disabledColor,
                                                  )),
                                              PopupMenuItem(
                                                  value: 'delivery',
                                                  child: Text('delivery'.tr),
                                                  textStyle:
                                                      robotoMedium.copyWith(
                                                    color: restaurantController
                                                                .restaurantType ==
                                                            'delivery'
                                                        ? Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .color
                                                        : Theme.of(context)
                                                            .disabledColor,
                                                  )),
                                            ];
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.RADIUS_SMALL)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                            child: Icon(Icons.filter_list_alt),
                                          ),
                                          onSelected: (value) =>
                                              restaurantController
                                                  .setRestaurantType(value),
                                        )
                                      : SizedBox(),
                                   /
                                ]);
                              }),
                            ),*/
 
                            RestaurantView(scrollController: _scrollController),
                          ]))),
            ],
          );
  }
  Widget _sizeWidget(
    String text,
    bool isSelected,
    int index, {
    Color color,
  }) {
    return InkWell(
        onTap: () {
          setState(() {
            selectSize = index;
          });
        },
        child: Ink(
            child: Container(
          padding: EdgeInsets.all(4),
          width: 59,
          decoration: BoxDecoration(
            border: Border.all(
                style: !isSelected ? BorderStyle.solid : BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: isSelected ? Colors.blue : Colors.white,
          ),
          child: Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              )),
        )));
  }

  int selectColor = 0;
  int selectSize = 0;
 /*void showMyDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      if (value != null) {
        //_scaffoldKey.currentState.showSnackBar(SnackBar(
        // content: Text('You selected: $value'),
        //  ));
      }
    });
  }*/

  double getPrice() {
    double price = 0;

    return price;
  }

  bool isGrid=false;

  @override
  Widget build(BuildContext context) {
    _loadData(false);

    return Builder(builder: (BuildContext context) {
      return Scaffold(
        appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
        backgroundColor: ResponsiveHelper.isDesktop(context)
            ? Theme.of(context).cardColor
            : null,
        body: RefreshIndicator(
          onRefresh: () async {
            await _loadData(true);
          },
          child:
          NestedScrollView(
           // scrollBehavior: ,
           // floatHeaderSlivers :true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
             toolbarHeight: 0,
             floating: true,
                    pinned: true,
                    snap: true,
              flexibleSpace:

              FlexibleSpaceBar(
                
                        centerTitle: true,
                        
                       
                        background:Column(
                    children: <Widget>[
                      _appBarLocation(),

                      _viewer(),

                      deptView()

                      //_categoryWidget(),
                    ],
                  )
                        ),
                        backgroundColor: Colors.white,
              
              
              
              
            ),
            SliverPersistentHeader(
              pinned: true,
            //  floating: true,
              delegate: StickyTabBarDelegate(
                child: TabBar(
                  labelColor: Colors.black,
                  controller: this.tabController,
                  tabs: <Widget>[
                    Tab(text: 'جميع المحلات'),
                    Tab(text: 'الأقرب'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
             Scaffold(
                              body: RefreshIndicator(
                                  onRefresh: () async {
                                    await _loadData(true);
                                  },
                                  child: tab1(context))

                              // tab1(),
                              ),
                          Scaffold(
                            body: Container(),
                          ),
          ],
        ),

        
      )
          
          /*
           SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _appBarLocation(),

                      _viewer(),

                      //_categoryWidget(),
                    ],
                  ),
                  _detailWidget(),
                ],
              ),
            ),
          ),
       
       */
        ),
        floatingActionButton: 
        
        /*FloatingActionButton(
            backgroundColor: Colors.black,
            child: Icon(Icons.camera_alt, size: 20,),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(70))
            ),
            onPressed: (){},
          ),*/
        
        
        FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor
                     ,
                  tooltip: 'change view way',
                  heroTag: "view",
                  child: Icon(isGrid ? Icons.view_list : Icons.view_module
                  ,color: Theme.of(context).cardColor,
                  
                  ),
                   shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(70))
            ),
                  onPressed: () {

Get.find<RestaurantController>().setisGrid();

                   /* setState(() {
                      isGrid = !isGrid;
                    });*/
                  }),
      );
    });
  }
}


class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}


///
///
///
///
///
///
///
//////
///
///
///