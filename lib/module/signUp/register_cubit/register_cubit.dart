import 'package:ecommerce/model/login_model.dart';
import 'package:ecommerce/shared/network/end_points.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'register_state.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(RegisterInitialState RegisterInitialStates) : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }){

    emit(RegisterLoadingState());
    DioHelper.post(
        url: REGISTER,
     data:{
       'email':email,
       'password':password,
       'phone':phone,
       'name':name,
     }
     ).then((value){
       print(value.data);
       loginModel = LoginModel.fromJson(value.data);
       print(loginModel.data.token);
       emit(RegisterSuccessState(loginModel));
     }).catchError((error){
       emit(RegisterErrorState(error.toString()));
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
