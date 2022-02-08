import 'dart:core';

import 'package:ecommerce/model/categories_model.dart';
import 'package:ecommerce/model/change_favorites_model.dart';
import 'package:ecommerce/model/favorites_model.dart';
import 'package:ecommerce/model/home_model.dart';
import 'package:ecommerce/model/login_model.dart';
import 'package:ecommerce/module/categories/categories_screen.dart';
import 'package:ecommerce/module/favorites/favorites_screen.dart';
import 'package:ecommerce/module/products/products_screen.dart';
import 'package:ecommerce/module/settings/settings_screen.dart';
import 'package:ecommerce/shared/components/constent.dart';
import 'package:ecommerce/shared/network/end_points.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: "Categories",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorite",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ];

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  Map<int, bool> favorites = {};


  HomeModel homeModel;

  void getHomeData() {
    emit(LoadingHomeDataState());
    DioHelper.get(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element)
      {
        favorites.addAll({
          element.id: element.inFavorites
        });
      });

      print(favorites.toString());

      emit(SuccessHomeDataState());

    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeDataState());
    });
  }

// GET CATEGORIES ....
  CategoriesModel categoriesModel;
  void getCategories() {
    DioHelper.get(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCategoriesState());
    });
  }


// CHANGE FAVORITES STATE ...
 ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(SuccessFavoritesState());

    DioHelper.post(
        url: FAVORITES,
        data: {
      "product_id": productId,
    },
      token: token,
    ).then((value){

      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(!changeFavoritesModel.status){
        favorites[productId] = !favorites[productId];
      }else{
        getFavorites();
      }
      printFullText(value.data.toString());
      emit(SuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error){
      favorites[productId] = !favorites[productId];

      emit(ErrorChangeFavoritesState());
            });
  }


// GET FAVORITES ....
  FavoritesModel favoritesModel;
  void getFavorites() {
    emit(SuccessLoadingGetFavoritesState());
    DioHelper.get(
      url: FAVORITES,
      token: token,

    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //print(value.data.toString());
      emit(SuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetFavoritesState());
    });
  }


// GET UESR DATA
  LoginModel userModel;
  void getUserData() {
    emit(SuccessLoadingUserDataState());
    DioHelper.get(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      printFullText(userModel.data.name);
      emit(SuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUserDataState());
    });
  }
}
