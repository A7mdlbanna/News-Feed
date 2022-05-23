import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  // const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var business = AppCubit.get(context).business;
    return
        business.isEmpty ? const Center(child: CircularProgressIndicator(),):
        ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => articleBuilder(business[index], context),
      itemCount: business.length,
    );
  }
}
