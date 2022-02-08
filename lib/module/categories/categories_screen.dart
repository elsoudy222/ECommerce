import 'package:ecommerce/layout/cubit/home_cubit.dart';
import 'package:ecommerce/model/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCartItem(HomeCubit.get(context).categoriesModel.data.data[index]),
          separatorBuilder: (context, index) => SizedBox(height: 10.0,),
          itemCount:HomeCubit.get(context).categoriesModel.data.data.length ,
        );
      },
    );
  }


  Widget buildCartItem(DataModel model) =>
      GestureDetector(
        onTap: (){},
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Image(
                height: 80.0,
                width: 80.0,
                fit: BoxFit.cover,
                image: NetworkImage(
                  model.image,
                ),
              ),
              SizedBox(width: 20.0,),
              Text(
                model.name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios))
            ],
          ),
        ),
      );
}
