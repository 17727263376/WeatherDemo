import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_demo/Tools.dart';
import 'package:weather_demo/beans/Weather.dart';

class WeatherModel{

  final String url_weather = "http://t.weather.sojson.com/api/weather/city/";
  final String url_city = "http://121.40.244.57/最新_city.json";
  /**
   * 查询天气信息，并通过Callback回调给Presenter
   */
  void queryWeather(String cityId, Function(bool, Map value) callback) async{
    try {
      Response response = await Dio().get(url_weather+cityId);
      if(response.statusCode == 200){
        print("请求天气数据成功");
        //print(response.toString());
        var map = json.decode(response.toString());
        callback(true, map);
      }else{
        print("请求天气数据失败");
        callback(false, null);
      }
    } catch (e) {
      print(e.toString());
      callback(false, null);
    }
  }

  /**
   * 查询城市信息，并通过Callback回调给Presenter
   */
  Future<Map> _queryCity() async{
    Map<String, String> map = new Map();
    try {
      Response response = await Dio().get(url_city);
      if(response.statusCode == 200){
        print("请求城市数据成功");
        map = Tool.analysisCityJson(response.toString().trim());
      }else{
        print("请求城市数据失败");
        return null;
      }
    } catch (e) {
      print("请求城市数据异常:"+e.toString());
      return null;
    }
    return map;
  }

  Future<void> intiCity(Function() callback) async {
    print("Model initCity");
    /**
     * 初始化本地城市信息,将_queryCity()获得的数据处理后存储到本地
     */
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map result;
    if(!sharedPreferences.containsKey("success")){
      //不存在本地存储
      print("不存在本地存储");
      result = await _queryCity();
      if(result != null){
        sharedPreferences.setStringList("city", result.keys.toList());
        sharedPreferences.setStringList("code", result.values.toList());
        sharedPreferences.setBool("success", true);
      }else{
        print("result == null");
      }
    }else{
      print("已存在本地存储");
      print(sharedPreferences.getStringList("city").length);
      print(sharedPreferences.getStringList("code").length);
    }
    callback();
  }
}