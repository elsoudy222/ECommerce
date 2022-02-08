import 'package:conditional_builder/conditional_builder.dart';
import 'package:ecommerce/layout/cubit/home_cubit.dart';
import 'package:ecommerce/model/favorites_model.dart';
import 'package:ecommerce/shared/components/colors.dart';
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
                  itemBuilder: (context, index) => buildFavoriteItem(
                    cubit.favoritesModel.data.data[index],
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

  Widget buildFavoriteItem(
    FavoritesData model,
    context,
  ) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product.image),
                    width: 120.0,
                    height: 120.0,
                    //fit: BoxFit.cover,
                  ),
                  if (model.product.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      color: Colors.red,
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.product.price.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.0, color: primaryColor),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        if (model.product.discount != 0)
                          Text(
                            model.product.oldPrice.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            HomeCubit.get(context)
                                .changeFavorites(model.product.id);
                          },
                          icon: CircleAvatar(
                            backgroundColor: HomeCubit.get(context)
                                    .favorites[model.product.id]
                                ? primaryColor
                                : Colors.grey,
                            radius: 15.0,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
