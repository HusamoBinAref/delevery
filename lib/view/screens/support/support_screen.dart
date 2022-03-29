import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/screens/support/widget/support_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'الدعم الفني'.tr), //'help_support'.tr
      body: Scrollbar(child: SingleChildScrollView(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(children: [
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        /*  Image.asset(Images.support_image, height: 120),
          SizedBox(height: 30),*/

          Image.asset(Images.logo, width: 100),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          Image.asset(Images.logo_name, width: 100),

          /*Text(AppConstants.APP_NAME, style: robotoBold.copyWith(
            fontSize: 20, color: Theme.of(context).primaryColor,
          )),*/
          SizedBox(height: 30),

          SupportButton(
            icon: Icons.location_on, title: 'العنوان'.tr, color: Colors.blue, //'address'.tr
            info: Get.find<SplashController>().configModel.address,
            onTap: () {},
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          SupportButton(
            icon: Icons.call, title: 'اتصل الان'.tr, color: Colors.red,
            info: Get.find<SplashController>().configModel.phone,
            onTap: () async {
              if(await canLaunch('tel:${Get.find<SplashController>().configModel.phone}')) {
                launch('tel:${Get.find<SplashController>().configModel.phone}');
              }else {
                showCustomSnackBar('${'can_not_launch'.tr} ${Get.find<SplashController>().configModel.phone}');
              }
            },
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          SupportButton(
            icon: Icons.mail_outline, title: 'email_us'.tr, color: Colors.teal,
            info: Get.find<SplashController>().configModel.email,
            onTap: () {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: Get.find<SplashController>().configModel.email,
              );
              launch(emailLaunchUri.toString());
            },
          ),

           SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          SupportButton(
            icon: FontAwesomeIcons.whatsapp, title: 'واتس اب'.tr, color: Colors.green,
            info: '771683590',
            onTap: () {
                launch('https://wa.me/+967-771683590');
            },
          ),


        ]))),
      )),
    );
  }
}
