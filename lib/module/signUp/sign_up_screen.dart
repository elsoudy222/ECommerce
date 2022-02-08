import 'package:conditional_builder/conditional_builder.dart';
import 'package:ecommerce/layout/home_layout.dart';
import 'package:ecommerce/module/signUp/register_cubit/register_cubit.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/components/constent.dart';
import 'package:ecommerce/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(RegisterInitialState()),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
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
                          "Register",
                          style:
                          Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text("Register to browse our hot offers"),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Please Enter Your Name";
                            }
                          },
                          label: "Name",
                          prefix: Icons.person,

                        ),


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
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Please Enter Your Phone";
                            }
                          },
                          label: "Phone",
                          prefix: Icons.phone,

                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          onSubmit: (String value){
                            if(formKey.currentState.validate()){
                              RegisterCubit.get(context).userRegister(
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
                          obscureText: RegisterCubit.get(context).obscureText,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPressed: (){
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context)=> defaultButton(
                              function: () {
                                if(formKey.currentState.validate()){
                                  RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }

                              },
                              text: "Register"),
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(" Have an account?"),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, SignUpScreen());
                                },
                                text: "Login"),
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
