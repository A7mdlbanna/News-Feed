import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed/shared/Network/local/cached_helper.dart';
import 'package:news_feed/shared/Network/remote/dio_helper.dart';
import 'package:news_feed/shared/bloc_observer.dart';
import 'package:news_feed/shared/cubit/app_theme_cubit.dart';
import 'package:news_feed/shared/cubit/theme_states.dart';
import 'homescreen.dart';
import 'package:intl/intl_standalone.dart';
// import 'src/country_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getBoolean(key: 'isDark');
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key) : super(key: key);

  late bool isDark;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ThemeCubit()..changeTheme(fromShared: isDark),
      child: BlocConsumer<ThemeCubit, ThemeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'News Feed',
            theme: ThemeData(
              // primaryColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                unselectedIconTheme: IconThemeData(color: Colors.grey.shade700)
              ),
              textTheme:  TextTheme(
                headline1: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black,),
                headline2: TextStyle(color: Colors.grey.shade800, fontSize: 14,),
                bodyText1: const TextStyle(fontSize: 14.0, color: Colors.black,),
                bodyText2: TextStyle(fontSize: 14.0, color: Colors.grey.shade700,),
                headline3: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold,),
                ),
            ),
            darkTheme: ThemeData(
              primaryColor: Color(0xFF0E122F),
              scaffoldBackgroundColor: Color(0xFF0E122F),
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor:  Color(0xFF020315),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
                backgroundColor: Color(0xFF080E21),
                unselectedIconTheme: IconThemeData(color: Colors.grey),
                  unselectedLabelStyle: TextStyle(color: Color(0xFF080E21))
              ),
              textTheme: const TextTheme(
                headline1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white,),
                headline2: TextStyle(color: Colors.grey, fontSize: 14,),
                bodyText1: TextStyle(fontSize: 14.0, color: Colors.white,),
                bodyText2: TextStyle(color: Colors.grey, fontSize: 14,),
                headline3: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold,),
              ),
            ),
            themeMode:  ThemeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
