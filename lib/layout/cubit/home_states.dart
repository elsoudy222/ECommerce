part of 'home_cubit.dart';



@immutable
abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class ChangeBottomNavBarState extends HomeStates{}

class LoadingHomeDataState extends HomeStates{}

class SuccessHomeDataState extends HomeStates{}

class ErrorHomeDataState extends HomeStates{}

class SuccessCategoriesState extends HomeStates{}

class ErrorCategoriesState extends HomeStates{}

class SuccessChangeFavoritesState extends HomeStates{
  final ChangeFavoritesModel model;

  SuccessChangeFavoritesState(this.model);
}
class ErrorChangeFavoritesState extends HomeStates{}
class SuccessFavoritesState extends HomeStates{}

class SuccessLoadingGetFavoritesState extends HomeStates{}
class SuccessGetFavoritesState extends HomeStates{}

class ErrorGetFavoritesState extends HomeStates{}


class SuccessLoadingUserDataState extends HomeStates{}
class SuccessUserDataState extends HomeStates{
  final LoginModel loginModel;
  SuccessUserDataState(this.loginModel);
}

class ErrorUserDataState extends HomeStates{}

class SuccessLoadingUpdateUserState extends HomeStates{}
class SuccessUpdateUserState extends HomeStates{
  final LoginModel loginModel;
  SuccessUpdateUserState(this.loginModel);
}

class ErrorUpdateUserState extends HomeStates{}