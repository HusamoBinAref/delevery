import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/data/model/response/address_model.dart';
import 'package:efood_multivendor/data/model/response/config_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/_Restorent/restorent_loc/resCard.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/_Restorent/restaurant_view.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'dart:ui';

class MapRestorentPage extends StatefulWidget {

   Restaurant selectRestaurent;

 

  
  
  MapRestorentPage(
      {@required this.selectRestaurent,
      
     
      
      });

  @override
  _MapRestorentPageState createState() => _MapRestorentPageState();
}

class _MapRestorentPageState extends State<MapRestorentPage> {
  LatLng _latLng;
  Set<Marker> _markers = Set.of([]);
  GoogleMapController _mapController;

    List<Restaurant> _restaurents;
     AddressModel _address;


     void ChangeMark()
     {

       

setState(() {



   _latLng = LatLng(double.parse(_address.latitude),
        double.parse(_address.longitude));
});

   _setMarker();

     }

  @override
  void initState() {
    super.initState();
    Get.put(RestaurantController);

       _address=AddressModel(
                                          id: widget.selectRestaurent.id,
                                          address: widget.selectRestaurent.address,
                                          latitude: widget.selectRestaurent.latitude,
                                          longitude: widget.selectRestaurent.longitude,
                                          contactPersonNumber: '',
                                          contactPersonName: '',
                                          addressType: '',
                                        ) ;

    RestaurantController cc=Get.find();
    _restaurents=cc.restaurantList;
    ChangeMark();

    
  }


  Widget listR(){
   int   _length = _restaurents.length;

    double _w = MediaQuery.of(context).size.width;

BaseUrls _baseUrls = Get.find<SplashController>().configModel.baseUrls;

    return AnimationLimiter(
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
                    margin: EdgeInsets.only(bottom: 4,right: 4,left: 4 ),
                    height: _w / 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: 
                    
                    InkWell(
                      onTap: (){
                        setState(() {
                          widget.selectRestaurent=_restaurents[index];

                          _address=AddressModel(
                                          id: _restaurents[index].id,
                                          address: _restaurents[index].address,
                                          latitude: _restaurents[index].latitude,
                                          longitude: _restaurents[index].longitude,
                                          contactPersonNumber: '',
                                          contactPersonName: '',
                                          addressType: '',
                                        ) ;

                       
                        });
                         ChangeMark();
                      },
                      child: Card(
                        child: Container(
                          width: 150,
                          height: 150,
                          child: 
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                               GestureDetector(
        
            child: HCachedNetworkImage(
              image:
                  '${ _baseUrls.restaurantImageUrl}'
                  '/${_restaurents[index].logo}',
              height: 80,
              width: 75,
              fit: BoxFit.cover,
            )),



                               Text(_restaurents[index].name),
                              
                            ],
                          )
                          
                         
                        ),
                      ),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }






  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: CustomAppBar(
          title:  '${widget.selectRestaurent.name}'),
      body: Center(
        child: Container(
          width: Dimensions.WEB_MAX_WIDTH,
          child: Stack(children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: _latLng, zoom: 17),
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              indoorViewEnabled: true,
              markers: _markers,
              onMapCreated: (controller) => _mapController = controller,
            ),
            Positioned(
              left: 1, // Dimensions.PADDING_SIZE_LARGE
              right: 1, // Dimensions.PADDING_SIZE_LARGE
              bottom: Dimensions.PADDING_SIZE_LARGE,
              child: InkWell(
                onTap: () {
                  if (_mapController != null) {
                    _mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(target: _latLng, zoom: 17)));
                  }
                },
                child: Container(
                  // padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          spreadRadius: 3,
                          blurRadius: 10)
                    ],
                  ),
                  child: 
                       Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Container(
                                height: 120,
                              
                                child:
                                _restaurents.length>0 ?

                                listR():
                              
                                
                                 Container()
                                
                                
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme.of(context).primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[300],
                                        spreadRadius: 3,
                                        blurRadius: 10)
                                  ],
                                ),
                                child: Text(
                                  _address.address,
                                  style: robotoMedium.copyWith(
                                      color: Theme.of(context).cardColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ])
                            ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _setMarker() async {
    Uint8List destinationImageData = await convertAssetToUnit8List(
        Images.location_marker,
      width: 140,
    );

    _markers = Set.of([]);
    _markers.add(Marker(
      markerId: MarkerId('marker'),
      position: _latLng,
      icon: BitmapDescriptor.fromBytes(destinationImageData),
    ));

    setState(() {});
  }

  Future<Uint8List> convertAssetToUnit8List(String imagePath,
      {int width = 50}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
}
