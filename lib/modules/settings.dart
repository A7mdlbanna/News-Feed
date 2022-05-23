import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed/shared/cubit/app_theme_cubit.dart';
import 'package:news_feed/shared/cubit/theme_states.dart';

import '../shared/cubit/cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeStates>(
      listener: (context, state) {},
      builder: (context, state) {
      ThemeCubit cubit = ThemeCubit.get(context);
        return  Scaffold(
          backgroundColor: cubit.isDark ? Colors.black54 : Colors.white,
          body: Center(
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () => cubit.changeTheme(),
                  elevation: 5.0,
                  color: cubit.isDark ? const Color(0xFF4C4F5E) : Colors.white,
                  child: Text(cubit.isDark ? 'Light Mode' : 'Dark Mode ', style: Theme.of(context).textTheme.headline1,),
                ),
                MaterialButton(
                  elevation: 5.0,
                  onPressed: () {
                    showCountryPicker(
                      textFieldStyle: cubit.isDark ? TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                      countryFilter: AppCubit.get(context).countries,
                      favorite: <String>[AppCubit.get(context).choosed],
                      context: context,
                      countryListTheme: CountryListThemeData(
                        bottomSheetHeight: 500,
                        inputDecoration: InputDecoration(
                          labelText:'Search',
                          hintText: 'Search countries',
                          labelStyle: TextStyle(color: cubit.fillColor),
                          hintStyle: TextStyle(color: cubit.hintColor),
                          floatingLabelStyle: const TextStyle(color: Colors.blue),
                          prefixIcon: Icon(Icons.search, color: cubit.isDark ? Colors.grey.shade500 : Colors.grey,),
                          border: OutlineInputBorder(borderSide: const BorderSide(), borderRadius: BorderRadius.circular(40.0)),
                        ),
                        backgroundColor: cubit.isDark ? const Color(0xFF393C4B) : Colors.white,
                        textStyle: TextStyle(color: cubit.isDark ?Colors.white : Colors.black,),
                      ),
                      onSelect: (value) {
                        AppCubit.get(context).deleteCountry(value.countryCode);
                        AppCubit.get(context).setChoosed(value.countryCode);
                        AppCubit.get(context).changeIndex(context, 0);
                        AppCubit.get(context).animate(0);

                      },
                    );
                  },
                  color:  cubit.isDark ? const Color(0xFF4C4F5E) : Colors.white,
                    child: Text('Change Country', style: Theme.of(context).textTheme.headline1,),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}