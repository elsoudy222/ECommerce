import 'package:ecommerce/layout/cubit/home_cubit.dart';
import 'package:ecommerce/model/favorites_model.dart';
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


Widget buildListProduct(
     model,
    context,
    {bool isOldPrice = true}
    ) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                  //fit: BoxFit.cover,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    color: Colors.red,
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.0, color: primaryColor),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          HomeCubit.get(context)
                              .changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor: HomeCubit.get(context)
                              .favorites[model.id]
                              ? primaryColor
                              : Colors.grey,
                          radius: 15.0,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

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