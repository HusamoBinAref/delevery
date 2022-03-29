


import 'package:efood_multivendor/_animation/_widgetAnimator.dart';
import 'package:efood_multivendor/theme/_style.dart';
import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  final Color titleColor;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsets margin;

  const CButton({
    key,
    this.title,
    this.titleColor,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(top: 20.0, bottom: 9.0),
      //decoration: BoxDecoration(border: Border.all(color: borderColor ?? StyleRso.secondaryColor,width: 2,)),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              backgroundColor ?? HStyle.secondaryColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? HStyle.secondaryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(
            right: 25.0,
            left: 25.0,
          ),
          padding: EdgeInsets.only(
            top: 15,
            bottom: 15,
            right: 7,
            left: 7,
          ),
          child: 
          WidgetAnimator(
             Text(
            title,
            style: TextStyle(
              //fontSize: height * 0.023,
              color: titleColor ?? HStyle.secondaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          )
          
          
        
        ),
      ),
    );
  }
}





class CTextRestent extends StatelessWidget {
 
  final String title;
  
   Color background;
   Color forground;
  final EdgeInsets margin;


   CTextRestent({
   
    this.title,
  this.background = HStyle.secondaryColor1,
this.forground=HStyle.primaryTextColor,
  
   
    this.margin,
   
    
  }) ;

  @override
  Widget build(BuildContext context) {
    return 
      Container(
      
                margin: EdgeInsets.only(bottom: 0,left: 9,right: 10,top: 0),
                
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child:
                 
                  Container(
                    padding: EdgeInsets.symmetric(vertical:3,horizontal: 12),
                    color:  background,
                    child: 
                  
                  
                  Text(title,
                   textAlign: TextAlign.center,
                  style: TextStyle(
                    
                    fontSize: 12,
                    color: forground,

                 // fontWeight: FontWeight.bold
                  ),))

                
                ))
      
    
    ;
  }
}


////////
///
///
///
///
///
///