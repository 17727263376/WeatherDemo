
import 'WeatherBean.dart';

class Weather{

  List<WeatherBean> list = null;
  String name = "";
  String wendu = "";
  String kongqi = "";
  String tianqi = "";

  Weather(Map map){
    if(map != null){
      this.name = map["cityInfo"]["city"];
      this.wendu = map["data"]["wendu"];
      this.kongqi = map["data"]["quality"];
      this.tianqi = map["data"]["forecast"][0]["type"];
      this.list = new List();
      List temp = map["data"]["forecast"];
      temp.forEach((value){
        this.list.add(new WeatherBean(value));
      });
    }else{
      this.list = new List();
      for(int i = 0; i < 14; i++) list.add(new WeatherBean(null));
    }
  }


  void show(){

    print(this.name);
    this.list.forEach((value){
      value.show();
    });
  }
}