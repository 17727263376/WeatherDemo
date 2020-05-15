import 'package:flutter/material.dart';
import 'package:weather_demo/Tools.dart';
import 'package:weather_demo/beans/Weather.dart';
import 'package:weather_demo/models/WeatherModel.dart';
import 'package:weather_demo/views/BaseView.dart';


class BasePresenter{

  BaseView baseView;
  WeatherModel model;

  /**
   * 构造函数，传入参数View，与View建立关联
   */
  BasePresenter(BaseView baseView){
    this.baseView = baseView;
    model = new WeatherModel();
  }

  void queryWeather(String cityId) async{
    if(cityId != Tool.EOR){
      model.queryWeather(cityId, (flag, result) async {
        /**
         * 处理查询结果
         */
        if(flag){
          Weather weather = new Weather(result);
          await this.baseView.update(weather);
        }
      });
    }
  }

  Future<void> initCity()async{
    print("presenter initCity");
    model.intiCity((){
      Tool.findCityCode("北京").then((value){
        queryWeather(value);
      });
    });
  }
}