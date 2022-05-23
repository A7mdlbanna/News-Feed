import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/shared/cubit/cubit.dart';

import '../shared/cubit/app_theme_cubit.dart';

void search(context) {
  AppCubit cubit = AppCubit.get(context);
  var list = cubit.search;

  var searchController = TextEditingController();
  final device = MediaQuery.of(context).size.height;
  final statusBarHeight = MediaQuery.of(context).padding.top;
  final height = device - (statusBarHeight * 2);

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                blurRadius: 25.0,
                blurStyle: BlurStyle.outer),
          ],
          borderRadius: BorderRadius.circular(40.0),
          color: Color(0xFF3B4059),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              AutoDirection(
                text: cubit.text,
                child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Search countries',
                      labelStyle:
                          TextStyle(color: ThemeCubit.get(context).fillColor),
                      hintStyle:
                          TextStyle(color: ThemeCubit.get(context).hintColor),
                      floatingLabelStyle: const TextStyle(color: Colors.blue),
                      prefixIcon: Icon(
                        Icons.search,
                        color: ThemeCubit.get(context).isDark
                            ? Colors.grey.shade500
                            : Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(60.0)),
                    ),
                    onChanged: (String value) {
                      cubit.getSearch(value);
                      cubit.updateSearch();
                    },
                    style: ThemeCubit.get(context).isDark
                        ? TextStyle(color: Colors.white)
                        : TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  height: height - (kToolbarHeight * 1.78),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFF3B4059),
                  ),
                  child: cubit.results,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ).whenComplete(() => cubit.deleteSearch());
}
