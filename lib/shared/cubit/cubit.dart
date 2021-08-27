import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter_app/modules/business/business_screen.dart';
import 'package:news_flutter_app/modules/science/science_screen.dart';
import 'package:news_flutter_app/modules/sports/sports_screen.dart';
import 'package:news_flutter_app/shared/cubit/states.dart';
import 'package:news_flutter_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];

  void onClickBottomNav(int index) {
    currentIndex = index;
    if(index == 0)
      getBusinessData();
    else if(index == 1)
      getScienceData();
    else if (index == 2)
      getSportsData();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusinessData(){
    emit(NewsGetBusinessLoadingState());
    if(business.length==0){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'eg',
        'category':'business',
        'apiKey':'b8873eb2539d47b287a4df3f788f5ba7',
      }).then((value) {
        business = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }else{
      emit(NewsGetBusinessSuccessState());
    }

  }

  List<dynamic> sports = [];
  void getSportsData(){
    emit(NewsGetSportsLoadingState());
    if(sports.length==0){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'b8873eb2539d47b287a4df3f788f5ba7',
      }).then((value) {

        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science = [];
  void getScienceData(){
    emit(NewsGetScienceLoadingState());
    if(science.length==0){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'eg',
        'category':'science',
        'apiKey':'b8873eb2539d47b287a4df3f788f5ba7',
      }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    print('hello');
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': 'b8873eb2539d47b287a4df3f788f5ba7',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search.length);
      emit(NewsGetSearchSuccessState());
    }).catchError((e) {
      print('error DioHelper getData ' + e.toString());
      emit(NewsGetSearchErrorState(e.toString()));
    });
  }
  // void getSearch(String value){
  //   emit(NewsGetSearchLoadingState());
  //    DioHelper.getDate(url: 'v2/everything', query: {
  //     'q':'$value',
  //     'apiKey':'b8873eb2539d47b287a4df3f788f5ba7',
  //   }).then((value) {
  //     search = value.data['articles'];
  //     emit(NewsGetSearchState());
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(NewsGetSearchErrorState(error.toString()));
  //   });
  //
  // }

}
