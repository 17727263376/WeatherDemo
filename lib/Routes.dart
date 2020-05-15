import 'package:flutter/material.dart';
import 'package:weather_demo/views/DetailedView.dart';
import 'package:weather_demo/views/SearchView.dart';


final rount = {
  '/detailed': (context,{argument}) => DetailedView(weatherBean: argument,),
  '/search': (context,{argument}) => SearchView(),
};

Function GenerateRoute = (RouteSettings setting){
  final name = setting.name;
  final argument = setting.arguments;
  final PageChangeFunction = rount[name];

  if(PageChangeFunction != null){
    if(argument != null){
      Route route = MaterialPageRoute(
        builder: (context)=>PageChangeFunction(context, argument:argument)
      );
      return route;
    }else{
      Route route = MaterialPageRoute(
          builder: (context)=>PageChangeFunction(context)
      );
      return route;
    }
  }
};