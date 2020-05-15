import 'package:flutter/material.dart';
import 'package:weather_demo/beans/WeatherBean.dart';

class DetailedView extends StatefulWidget{
  WeatherBean weatherBean;
  DetailedView({this.weatherBean});

  @override
  _DetailedView createState ()=> _DetailedView(weatherBean: this.weatherBean);
}

class _DetailedView extends State<DetailedView>{
  WeatherBean weatherBean;
  _DetailedView({this.weatherBean});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("详细天气", style: TextStyle(
          fontSize: 22,
          color: Colors.white
        ),),
        backgroundColor: Color.fromARGB(255, 55, 128, 205),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          ListTile(
            title: Text("推荐"),
            subtitle: Text(weatherBean.notice),
          ),
          Divider(),
          ListTile(
            title: Text("空气指数"),
            subtitle: Text("${weatherBean.aqi}"),
          ),
          Divider(),
          ListTile(
            title: Text("风向"),
            subtitle: Text(weatherBean.fx),
          ),
          Divider(),
          ListTile(
            title: Text("风力"),
            subtitle: Text(weatherBean.fl),
          ),
          Divider(),
          SizedBox(height: 10,),
          Stack(
            children: <Widget>[
              Align(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.wb_sunny, color: Colors.black45,),
                    SizedBox(height: 5,),
                    Text("日出"),
                    SizedBox(height: 5,),
                    Text(weatherBean.sunRise, style: TextStyle(color: Colors.black45),),
                  ],
                ),
                alignment: Alignment(-0.5, 0),
              ),
              Align(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.brightness_2, color: Colors.black45,),
                    SizedBox(height: 5,),
                    Text("日落"),
                    SizedBox(height: 5,),
                    Text(weatherBean.sunSet, style: TextStyle(color: Colors.black45),),
                  ],
                ),
                alignment: Alignment(0.5,0),
              ),
            ],),
        ],
      ),
    );
  }
}