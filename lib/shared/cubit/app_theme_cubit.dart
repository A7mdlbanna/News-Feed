import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed/shared/cubit/theme_states.dart';

import '../Network/local/cached_helper.dart';


class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitialState());

  static ThemeCubit get(context) => BlocProvider.of(context);

  bool isDark = true;
  Color fillColor =  Colors.white;
  Color hintColor =  Colors.grey.shade500;
  // Color focusColor =  Colors.white;
  void changeTheme({fromShared}){
    if(fromShared != null)isDark = fromShared;
    else {
      isDark = !isDark;
      CacheHelper.putBoolean('isDark', isDark).then((value){
        emit(ChangeAppThemeState());
      });
    }
    fillColor = isDark ? Colors.white : Colors.black;
    hintColor = isDark ? Colors.grey.shade500 : Colors.grey;
    emit(ChangeAppThemeState());

  }


}