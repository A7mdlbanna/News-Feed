import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class SportsScreen extends StatelessWidget {
  // const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sports = AppCubit
        .get(context)
        .sports;
    return
      sports.isEmpty ? const Center(child: CircularProgressIndicator(),) :
      ListView.builder(
        itemBuilder: (context, index) => articleBuilder(sports[index], context),
        itemCount: sports.length,
      );
  }
}
