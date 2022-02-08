import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';

void navigateToAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}



Widget defaultButton(
        {Color background = primaryColor,
        double width = double.infinity,
        double radius = 0.0,
        @required Function function,
        @required String text,
        bool isUpperCase = true}) =>
    Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType keyboardType,
  ValueChanged<String> onSubmit,
  ValueChanged<String> onChange,
  VoidCallback onTap,
  bool obscureText = false,
  FormFieldValidator<String>  validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  VoidCallback suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      cursorColor: primaryColor,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );



Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
      ),
    );


void showToast(
{
 @required String msg,
  @required ToastStates toastStates,

})=> Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:chooseToastColor(toastStates) ,
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS, ERROR, WARNING}
Color color;
Color chooseToastColor(ToastStates toastStates){
  switch(toastStates){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}




// Logout Button:-
// TextButton(
// onPressed: () {
// CacheHelper.removeData(key: "token").then((value) {
// if (value) {
// navigateToAndFinish(context, LoginScreen());
// }
// });
// },
// child: Text("Sign Out",
// style: TextStyle(
// color: primaryColor,
// fontSize: 20.0
// ),),
// ),