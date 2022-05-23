import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

//https://newsapi.org/v2/everything?q=tesla&from=2022-04-21&sortBy=publishedAt&apiKey=e02c66b5d73e4906803fe409a8538130
//https://newsapi.org/v2/everything?q=apple&from=2022-05-20&to=2022-05-20&sortBy=popularity&apiKey=e02c66b5d73e4906803fe409a8538130

class TechScreen extends StatelessWidget {
  // const TechScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List tech = AppCubit.get(context).tech;
    return tech.isEmpty ? const Center(child: CircularProgressIndicator(),)
    : ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => articleBuilder(tech[index], context),
      itemCount: tech.length,
    );
  }
}
