import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:news_feed/shared/Network/remote/dio_helper.dart';
import 'package:news_feed/shared/components.dart';
import 'package:news_feed/shared/cubit/app_theme_cubit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:news_feed/modules/tech.dart';
import 'package:news_feed/modules/sports.dart';
import 'package:news_feed/modules/business.dart';
import 'package:news_feed/modules/settings.dart';
import 'package:news_feed/shared/cubit/cubit.dart';
import 'package:news_feed/shared/cubit/states.dart';

import 'modules/search_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Database database;
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => AppCubit()..changeIndex(context, 0),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
        },
        builder: (context, state){
          // if(state == Search())
          //   const Center(child: CircularProgressIndicator(),);

          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            // backgroundColor: Color(0xFF0E122F),
            appBar: AppBar(
                // backgroundColor: Color(0xFF020315),
                title: Text(
                  cubit.titles[cubit.item],
                ),
              titleSpacing: 20.0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () => search(context),
                      icon: const Icon(Icons.search_sharp)),
                )
              ],
            ),
            body: PageView(
              controller: cubit.pageController,
              onPageChanged: (pageIndex){
                cubit.changeIndex(context, pageIndex);
              },
              children: [
                TechScreen(),
                BusinessScreen(),
                SportsScreen(),
                SettingsScreen(),
              ]) ,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.item,
              onTap: (index) {
                cubit.changeIndex(context,index);
                cubit.animate(index);
              },
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.computer_outlined), label: 'Tech'),
                BottomNavigationBarItem(icon: Icon(Icons.business_center_outlined), label: 'Business'),
                BottomNavigationBarItem(icon: Icon(Icons.sports_volleyball), label: 'Sports'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          );
        }
      ),
    );
  }
}