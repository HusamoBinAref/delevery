import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:get/get.dart';

class PriceConverter {
  static String convertPrice(double price, {double discount, String discountType, int asFixed = 0}) 
  
  {
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = price - discount;
      }else if(discountType == 'percent') {
        price = price - ((discount / 100) * price);
      }
    }
    bool _isRightSide = Get.find<SplashController>().configModel.currencySymbolDirection == 'right';

String pricetext='${_isRightSide ? '' : Get.find<SplashController>().configModel.currencySymbol+' '}'
        '${(price).toStringAsFixed(asFixed).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        '${_isRightSide ? ' '+Get.find<SplashController>().configModel.currencySymbol : ''}';


        

        

    return pricetext;
  }

  static double convertWithDiscount(double price, double discount, String discountType) {
    if(discountType == 'amount') {
      price = price - discount;
    }else if(discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount') {
      calculatedAmount = discount * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : Get.find<SplashController>().configModel.currencySymbol} OFF';
  }
}