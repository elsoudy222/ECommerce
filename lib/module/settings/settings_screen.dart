import 'package:conditional_builder/conditional_builder.dart';
import 'package:ecommerce/layout/cubit/home_cubit.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/components/constent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var model = HomeCubit.get(context).userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;


        return ConditionalBuilder(
          condition: model != null,
          fallback:(context)=> Center(child: CircularProgressIndicator()),
          builder:(context)=> Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is SuccessLoadingUpdateUserState)
                    LinearProgressIndicator(),
                    SizedBox(height: 20.0,),
                    CircleAvatar(
                      maxRadius: 70.0,
                      backgroundColor: Colors.transparent,
                      child: Image(
                        image: NetworkImage(model.data.image),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    defaultFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "Name must not be empty";
                        }
                        return null;
                      },
                      label: "Name",
                      prefix: Icons.person,
                    ),
                    SizedBox(height: 20.0,),
                    defaultFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "Email must not be empty";
                        }
                        return null;
                      },
                      label: "Email",
                      prefix: Icons.email,
                    ),
                    SizedBox(height: 20.0,),
                    defaultFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "Phone must not be empty";
                        }
                        return null;
                      },
                      label: "Phone",
                      prefix: Icons.phone,
                    ),
                    SizedBox(height: 20.0,),
                    defaultButton(
                        function: (){
                          if(formKey.currentState.validate()){
                            HomeCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }

                    }, text: "update"),
                    SizedBox(height: 20.0,),
                    defaultButton(function: (){
                      signOut(context);
                    }, text: "signout"),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
