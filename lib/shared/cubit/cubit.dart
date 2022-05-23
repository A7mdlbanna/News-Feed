import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed/shared/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Network/remote/dio_helper.dart';
import '../components.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);



  List<String> titles = [
    'Latest Tech news in US}',
    'Latest Business news in US',
    'Latest Sport news in US',
    'Settings',
  ];
  var item = 0;
  void changeIndex(ctx, index){
    item = index;
    if(index == 0) {
      getTech(ctx);
    }
    if(index == 1) {
      getBusiness(ctx);
    }
    if(index == 2) {
      getSport(ctx);
    }
    emit(AppChangeNavBarState());
  }
  void urlLauncher(URL) async {
  final Uri url = Uri.parse(URL['url']);
    if (!await launchUrl(url)) throw 'Could not launch $url';
  //   WebView(
  //     initialUrl: URL['url'],
  //   );
  }


  var pageController = PageController(initialPage: 0);
  void animate(index){
    pageController.animateToPage(index, duration: const Duration(microseconds: 500), curve: Curves.ease);
  }
/////////////////////date/////////////////////////

  getDate(category){
    var date = DateTime.now().difference(DateTime.parse(category['publishedAt'].substring(0, category['publishedAt'].length - 1)+'+00:00'));
    if(date.inDays > 0)return '${date.inDays} days ago';
    if(date.inDays == 0 && date.inHours > 0)return '${date.inHours} hours ago';
    if(date.inDays == 0 && date.inHours == 0 && date.inMinutes > 0)return '${date.inMinutes} minutes ago';
    if(date.inDays == 0 && date.inHours == 0 && date.inMinutes == 0)return '${date.inSeconds} seconds ago';
  }
  duration(news){
    return news["urlToImage"] != null ? getDate(news) : '';
  }

  ///////////////////countries////////////////////
  late String choosed= 'US';
  void setChoosed(value){
    choosed = value;
    emit(SetChoosed());
  }
  String prevCountry = '';
  List<String> countries = ["AE", "AR", "AT", "AU", "BE", "BG", "BR", "CA", "CH", "CN", "CO", "CU", "CZ", "DE", "EG", "FR", "GB", "GR", "HK", "HU", "ID", "IE", "IL", "IN", "IT", "JP", "KR", "LT", "LV", "MA", "MX", "MY", "NG", "NL", "NO", "NZ", "PH", "PL", "PT", "RO", "RS", "RU", "SA", "SE", "SG", "SI", "SK", "TH", "TR", "TW", "UA", "US", "VE", "ZA",];
  void deleteCountry (value){
    countries.add(choosed);
    prevCountry = choosed;
    countries.remove(value);
    emit(DeleteChoosed());
  }

///////////////////////////////////////////////

  String text = '';
  List<dynamic> search = [];
  ListView results = Container() as ListView;

  void getSearch(String val){
    text = val;
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': val,
          'apiKey': '9d532252ba564b2eb7ae3cd94831cbad'
        })
        .then((value) {
          search = value?.data["articles"];
          emit(AppGetSearchSuccessState());
    }).catchError((error) {
      print('Found error while getting the data: ${error.toString()}');
      emit(AppGetSearchErrorState());
    });
  }
  void updateSearch(){
    results = ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return searchItemBuilder(context, search[index]);
      },
      itemCount: search.length,
    );
    emit(BuildResults());
  }
  void deleteSearch(){
    search = [];
    emit(DeleteSearch());
  }
  //////////////////////////////////////////////

  List<dynamic> tech = [];
  List<dynamic> business = [];
  List<dynamic> sports = [];

  getTech(ctx) => getNews(ctx, 'technology', tech);
  getSport(ctx) => getNews(ctx, 'sports', sports);
  getBusiness(ctx) => getNews(ctx, 'business', business);

  void getNews(context, String categoryName,  category){
      emit(AppGetNews());
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': choosed,
            'category': categoryName,
            'apiKey': '9d532252ba564b2eb7ae3cd94831cbad'
          })
          .then((value) {
        if(category==tech) {
          tech = value?.data["articles"];
          emit(AppGetTech());
        } else if(category==sports) {
          sports= value?.data["articles"];
          emit(AppGetSport());
        } else if(category==business) {
          business= value?.data["articles"];
          emit(AppGetBusiness());
        }
      }).catchError((error) {
        print('Found error while getting the data: ${error.toString()}');
        emit(AppGetNewsErrorState(error.toString()));
      });
  }
}