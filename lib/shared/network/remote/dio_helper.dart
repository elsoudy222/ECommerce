
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{
  static Dio dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,


      ),
    );
  }

  static Future<Response> get({
    @required String url,
    Map<String, dynamic> parameters,
    Map<String, dynamic> headers,
    String lang = "en",
    String token,
  }) async {
    dio.options.headers = {
      "lang" : lang,
      "Content-Type" : "application/json",
      "Authorization" : token??"",
    };
    return await dio.get(
      url,
      queryParameters: parameters,
    );
  }

  static Future<Response> post({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> parameters,
    Map<String, dynamic> headers,
    String lang = "en",
    String token,
  }) async {
    dio.options.headers = {
      "lang" : lang,
      "Content-Type" : "application/json",
      "Authorization" : token,
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: parameters,
    );
  }

  static Future<Response> put({
    @required String path,
    Map<String, dynamic> headers,
    @required Map<String, dynamic> data,
  }) async {
    dio.options.headers = headers;
    return await dio.put(
      path,
      data: data,
    );
  }

}

