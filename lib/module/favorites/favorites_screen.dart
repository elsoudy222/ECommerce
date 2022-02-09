import 'package:conditional_builder/conditional_builder.dart';
import 'package:ecommerce/layout/cubit/home_cubit.dart';
import 'package:ecommerce/model/favorites_model.dart';
import 'package:ecommerce/shared/components/colors.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return cubit.favoritesModel.data.data.length != 0
            ? ConditionalBuilder(
                condition: state is! SuccessLoadingGetFavoritesState,
                builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildListProduct(
                    cubit.favoritesModel.data.data[index].product,
                    context,
                  ),
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    width: 1,
                    color: Colors.grey,
                  ),
                  itemCount: cubit.favoritesModel.data.data.length,
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_outlined,
                      size: 100.0,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sorry You Don\'t Have Any Favorites Yet Please Add Some',
                    ),
                  ],
                ),
              );
      },
    );
  }


}
