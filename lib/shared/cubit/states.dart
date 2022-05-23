abstract class AppStates{}

class AppInitialState extends AppStates{}

/////////////////HomeScreen////////////////////
class AppChangeNavBarState extends AppStates{}

//////////settings///////////
class ChangeAppThemeState extends AppStates{}
class SetChoosed extends AppStates{}
class DeleteChoosed extends AppStates{}

///////////////////////////////////
class AppGetSearchSuccessState extends AppStates{}
class AppGetSearchErrorState extends AppStates{}
class DeleteSearch extends AppStates{}
class BuildResults extends AppStates{}

////////////news///////////////////
class AppGetBusiness extends AppStates{}
class AppGetTech extends AppStates{}
class AppGetSport extends AppStates{}

class AppGetNews extends AppStates{}
class AppGetNewsLoadingState extends AppStates{}
class AppGetNewsSuccessState extends AppStates{}
class AppGetNewsErrorState extends AppStates{
  final String error;
  AppGetNewsErrorState(this.error);
}
