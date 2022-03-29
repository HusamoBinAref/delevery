import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewWidget extends StatelessWidget {
  PhotoViewWidget({Key key, this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {

    return  Container(
          color: Colors.transparent,
      child:

       Stack(
         children: [
          
           PhotoView.customChild(
            backgroundDecoration: BoxDecoration(color:Colors.transparent ),
            enableRotation: true,
            tightMode: true,
            basePosition: Alignment.center,
            enablePanAlways: true,


              child: HCachedNetworkImage(
                fit: BoxFit.fill,

            image: url,
            height: MediaQuery.of(context).size.height/2,
            width:  MediaQuery.of(context).size.width,
      )),
      Material(
        child: IconButton(
                              icon: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).cardColor),
                                alignment: Alignment.center,
                                child: Icon(Icons.cancel_sharp,
                                size: 40,
                                    color: Theme.of(context).primaryColor),
                              ),
                              onPressed: () => Get.back(),
                            ),
         
      )
       ],
       ),
    );
  }
}
