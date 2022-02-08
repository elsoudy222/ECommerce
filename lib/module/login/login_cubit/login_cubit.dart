import 'package:ecommerce/model/login_model.dart';
import 'package:ecommerce/shared/network/end_points.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'login_state.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(LoginInitialState loginInitialStates) : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  }){

    emit(LoginLoadingState());
    DioHelper.post(url: LOGIN,
     data:{
       'email':email,
       'password':password,
     }
     ).then((value){
       print(value.data);
       loginModel = LoginModel.fromJson(value.data);
       print(loginModel.data.token);
       emit(LoginSuccessState(loginModel));
     }).catchError((error){
       emit(LoginErrorState(error.toString()));
     });

  }

  IconData suffix = Icons.visibility_outlined;
  bool obscureText = true;

  void changePasswordVisibility(){
    obscureText = !obscureText;
    suffix = obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
