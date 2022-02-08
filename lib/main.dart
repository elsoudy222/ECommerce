import 'package:ecommerce/shared/network/local/cache_helper.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit/home_cubit.dart';
import 'layout/home_layout.dart';
import 'module/login/login_cubit/login_cubit.dart';
import 'module/login/login_screen.dart';
import 'module/onBoarding/on_boarding_screen.dart';
import 'shared/components/themes.dart';


//// SoudyJr ..........

void main() async{
  // Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: "onBoarding");
  String token = CacheHelper.getData(key: "token");
  print(token);

  if(onBoarding != null){
    if(token != null){
      widget = HomeLayout();
    }else{
      widget = LoginScreen();
    }
  }else{
    widget = OnBoardingScreen();
  }


  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  const MyApp(this.startWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context)=> HomeCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
          ),
          BlocProvider(create: (context)=> LoginCubit(LoginInitialState())),
        ],
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightMode,
              title: 'ECOMMERCE APP',
              home: startWidget,
            );
          },
        )
    );
  }
}



