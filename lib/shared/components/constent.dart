import 'dart:io';

import 'package:ecommerce/module/login/login_screen.dart';
import 'package:ecommerce/shared/network/local/cache_helper.dart';


import 'components.dart';

String getOS(){
  return Platform.operatingSystem;
}



void printFullText(String text){

  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}


void signOut(context){
  CacheHelper.removeData(key: "token",).then((value){
    if(value){
      navigateToAndFinish(context, LoginScreen());
    }
  });
  
}

String token = "1Lg8qC7FgMuyYBfAVMGAr1sMmSaWThRIpHTy74KsGgeNxbp3fLrTk86RDydslSiZgZXAZ0";