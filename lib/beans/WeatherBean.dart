class WeatherBean{
  String _date = "";//年月日  （新增）
  String _week = "";//星期 （新增）
  String _sunRise = ""; //日出
  String _high = "";//当天最高温
  String _low = ""; //当天最低温
  String _sunSet = ""; //日落
  int _aqi = 0;//空气指数
  String _fx = "";//风向
  String _fl = "";//风力
  String _type = "";//天气
  String _notice = "";

  String get date => _date;

  set date(String value) {
    _date = value;
  } //天气描述


  WeatherBean(Map map){
    if(map != null){
      this._date = map["ymd"];
      this._week = map["week"];
      this._sunRise = map["sunrise"];
      this._high = map["high"];
      this._low = map["low"];
      this._sunSet = map["sunset"];
      this._aqi = map["aqi"];
      this._fx = map["fx"];
      this._fl = map["fl"];
      this._type = map["type"];
      this._notice = map["notice"];
    }
  }

  String get week => _week;

  String get notice => _notice;

  set notice(String value) {
    _notice = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get fl => _fl;

  set fl(String value) {
    _fl = value;
  }

  String get fx => _fx;

  set fx(String value) {
    _fx = value;
  }

  int get aqi => _aqi;

  set aqi(int value) {
    _aqi = value;
  }

  String get sunSet => _sunSet;

  set sunSet(String value) {
    _sunSet = value;
  }

  String get low => _low;

  set low(String value) {
    _low = value;
  }

  String get high => _high;

  set high(String value) {
    _high = value;
  }

  String get sunRise => _sunRise;

  set sunRise(String value) {
    _sunRise = value;
  }

  set week(String value) {
    _week = value;
  }

  void show(){
    print(this._date);
  }
}