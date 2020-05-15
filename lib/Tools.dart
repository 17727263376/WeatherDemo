import 'package:shared_preferences/shared_preferences.dart';

class Tool{
  static final String EOR = "NOF";
/**
 * 解析城市Json数据
 */
  static Map<String, String> analysisCityJson(String response){
    String data = response;
    Map<String, String> map = new Map();
    print(data);
    List<String> temp = data.split(',');
    List<String> city = new List();
    List<String> code = new List();
    temp.forEach((String v){
      if(v.contains("city_code")){
        List<String> t = v.split(':');
        code.add(t[1].trim());
      }
      if(v.contains("city_name")){
        List<String> t = v.split(':');
        city.add(t[1].trim());
      }
    });
    print("city:${city.length}----code:${code.length}");
    for(int i = 0; i < city.length; i++){
      if(code[i] != ""){
        map[city[i]] = code[i];
      }
    }
    return map;
  }

  static Future<String> findCityCode(String cityName)async{
    print("Tool.findCityCode");
    String result = Tool.EOR;
    if(cityName != ""){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      List<String> city = sharedPreferences.getStringList("city");
      List<String> code = sharedPreferences.getStringList("code");
      if(city!=null && code!=null){
        for(int i = 0; i < city.length; i++){
          if(city[i].contains(cityName) || cityName.contains(city[i])){
            result = code[i];
            print(city[i]);
            return result;
          }
        }
      }else{
        print("findCityCode:city.isEmpty && code.isEmpty");
        return result;
      }
    }
    return result;
  }

}