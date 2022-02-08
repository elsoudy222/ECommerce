// ignore_for_file: missing_return

import 'package:conditional_builder/conditional_builder.dart';
import 'package:ecommerce/layout/home_layout.dart';
import 'package:ecommerce/module/signUp/sign_up_screen.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/components/constent.dart';
import 'package:ecommerce/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_cubit/login_cubit.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginCubit(LoginInitialState()),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState){
            if(state.loginModel.status){
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                  key: "token",
                  value:state.loginModel.data.token
              ).then((value) {
                token = state.loginModel.data.token;
                navigateToAndFinish(context, HomeLayout());
              });


            }else{
              print(state.loginModel.message);
              showToast(
                  msg: state.loginModel.message,
                  toastStates: ToastStates.ERROR
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style:
                              Theme.of(context).textTheme.headline4.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text("Login to browse our hot offers"),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Please Enter Your Email";
                            }
                          },
                          label: "Email",
                          prefix: Icons.email_outlined,

                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          onSubmit: (String value){
                            if(formKey.currentState.validate()){
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return " Please Enter Your password";
                            }
                          },
                          label: "Password",
                          prefix: Icons.lock_outline,
                          obscureText: LoginCubit.get(context).obscureText,
                          suffix: LoginCubit.get(context).suffix,
                          suffixPressed: (){
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context)=> defaultButton(
                              function: () {
                                if(formKey.currentState.validate()){
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }

                              },
                              text: "login"),
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
                          ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\'t have an account"),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, SignUpScreen());
                                },
                                text: "Sign Up"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
