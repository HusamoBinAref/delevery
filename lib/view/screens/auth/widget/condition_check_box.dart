import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConditionCheckBox extends StatelessWidget {
  final AuthController authController;
  ConditionCheckBox({@required this.authController});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
        activeColor: Theme.of(context).primaryColor,
        value: authController.acceptTerms,
        onChanged: (bool isChecked) => authController.toggleTerms(),
      ),
      Text('لقد قرأت ووافقت على ', style: robotoRegular),
      InkWell(
        onTap: () => Get.toNamed(RouteHelper.getHtmlRoute('terms-and-condition')),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Text('الشروط والاحكام وسياسة الخصوصية',
          maxLines: 1, overflow: TextOverflow.ellipsis
          , style: robotoMedium.copyWith(color: Colors.blue)),
        ),
      ),
    ]);
  }
}
