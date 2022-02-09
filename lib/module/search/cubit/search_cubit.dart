import 'package:bloc/bloc.dart';
import 'package:ecommerce/model/search_model.dart';
import 'package:ecommerce/shared/components/constent.dart';
import 'package:ecommerce/shared/network/end_points.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=> BlocProvider.of(context);


  SearchModel model;

  void search(String text){
    emit(SearchLoadingState());
    DioHelper.post(
      url: SEARCH,
      token: token,
      data:
      {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
    });
  }
}
