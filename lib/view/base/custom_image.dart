import 'package:cached_network_image/cached_network_image.dart';
import 'package:efood_multivendor/theme/_style.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit fit;
  final String placeholder;
  CustomImage({@required this.image, this.height, this.width, this.fit, this.placeholder});






  @override
  Widget build(BuildContext context) {
    return 

    CachedNetworkImage(
                height: height, width: width,
                 
               fit:fit,
               imageUrl: image,
               placeholder: (context, url) =>
                   Center(child: SpinKitThreeBounce(
                                  color:  HStyle.primaryLiteColor,
                                  size: 15,
                                 )),

fadeInCurve: Curves.easeInCirc,
            errorWidget: (context, error, _) {
              return Image.asset(Images.logo);
            },
           
             );
    
    
    
  }
}





class HCachedNetworkImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit fit;
  final String placeholder;
  HCachedNetworkImage({@required this.image, this.height, this.width, this.fit, this.placeholder});



  @override
  Widget build(BuildContext context) {
    return 

     Hero(
             tag: image,
             child: CachedNetworkImage(
                height: height, width: width,
                 
               fit:fit,
               imageUrl: image,
               placeholder: (context, url) =>
                   Center(child: SpinKitThreeBounce(
                                  color: HStyle.primaryLiteColor,
                                  size: 15,
                                   duration: Duration(milliseconds: 1000),
                                 )),

fadeInCurve: Curves.easeInCirc,
            errorWidget: (context, error, _) {
              return Image.asset(Images.logo);
            },
             ),
           );
      
    
    FadeInImage.assetNetwork(
      placeholder: Images.placeholder, height: height, width: width, fit: fit,
      image: image,
      imageErrorBuilder: (c, o, s) => Image.asset(
        placeholder != null ? placeholder : Images.placeholder,
        height: height, width: width, fit: fit,
      ),
    );
  }
}
