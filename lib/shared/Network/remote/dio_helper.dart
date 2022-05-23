import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//  https://newsapi.org/
//  v2/top-headlines?
//  country=us&category=business&apiKey=e02c66b5d73e4906803fe409a8538130
class DioHelper {
  static Dio? dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',

        // connectTimeout: 10000,
        // receiveTimeout: 10000,
        receiveDataWhenStatusError: true,
      )
    );
  }
  static Future<Response?> getData({required String url, required query})async{
    return await dio?.get(url, queryParameters: query);
  }
}