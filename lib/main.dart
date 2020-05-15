import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_demo/Routes.dart';
import 'package:weather_demo/Tools.dart';
import 'package:weather_demo/beans/Weather.dart';
import 'package:weather_demo/presenters/BasePresenter.dart';
import 'package:weather_demo/views/BaseView.dart';


void main() async{

  runApp(MyApp());

}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: MainActivity(),
      onGenerateRoute: GenerateRoute,
    );
  }
}

/**
 * Home界面
 */
class MainActivity extends StatefulWidget{
  _MainActivity createState()=> _MainActivity();
}
class _MainActivity extends State<MainActivity> implements BaseView{

  Weather weather;
  BasePresenter presenter;
  String imageUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1581096025711&di=47134dd5d174d624394c35a4949fe2e9&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201809%2F15%2F20180915232230_pwgup.thumb.700_0.jpeg";
  Color bgColor = Color.fromARGB(255, 24, 10, 33);
  Color containerColor = Color.fromARGB(200, 24, 10, 33);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weather = new Weather(null);
    presenter = new BasePresenter(this);
    presenter.initCity();
    this._getLocationInfo();
  }

  Widget _getForecastInfo(int index){
    return InkWell(
      child: Stack(
        children: <Widget>[
          Align(
            child: Text(weather.list[index].date,style: TextStyle(color: Colors.white,fontSize: 13),),
            alignment: Alignment.centerLeft,
          ),
          Align(
            child: Text(weather.list[index].type,style: TextStyle(color: Colors.white,fontSize: 13),),
            alignment: Alignment(-0.2,0),
          ),
          Align(
            child: Text("${weather.list[index].low}~${weather.list[index].high}",style: TextStyle(color: Colors.white,fontSize: 13),),
            alignment: Alignment.centerRight,
          )
        ],
        ),
      onTap: (){
        print(this.weather.list[index].date);
        Navigator.of(context).pushNamed("/detailed",arguments: this.weather.list[index]);
      });
  }

  Widget _showToast(String info){
    return new AlertDialog(
      title: new Text('提示'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text(info),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('确定'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Future<void> _getLocationInfo()async{
    print("开始定位。。。");
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.location]);
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
    ServiceStatus serviceStatus = await PermissionHandler().checkServiceStatus(PermissionGroup.location);
// 单次定位
    if(serviceStatus==ServiceStatus.enabled){
      if (permission==PermissionStatus.granted) {
        print("取得定位权限");
        final location = await AmapLocation.fetchLocation();
        location.city.then((val){
          Tool.findCityCode(val).then((id){
            this.presenter.queryWeather(id);
          });
        });
      }else{
        print("未取得定位权限");
        showDialog(
            context: context,
            builder: (context){
              return _showToast("定位失败，请检查定位");
            }
        );
      }
    }else{
      print("未开启定位");
      showDialog(
          context: context,
          builder: (context){
            return _showToast("定位失败，请检查定位");
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: this.bgColor,
        title: Text(
          weather.name,
          style: TextStyle(
            fontSize: 32
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,size: 30,),
            onPressed: (){
              /**
               * 搜索功能
               */
              Navigator.of(context).pushNamed('/search').then((value){
                Tool.findCityCode(value).then((value){
                  if(value != Tool.EOR){
                    this.presenter.queryWeather(value);
                  }else{
                    print("未搜索到城市");
                    showDialog(
                      context: context,
                      builder: (context){
                        return _showToast("未搜索到城市");
                      }
                    );
                  }
                });
              });
            }),
          IconButton(
            icon: Icon(Icons.location_on, color: Colors.white,size: 30,),
            onPressed: (){
              /**
               * 定位功能
               */
              print("测试定位功能");
              this._getLocationInfo();
            })
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(this.imageUrl),fit: BoxFit.cover),
          //color: Color.fromARGB(255, 0, 22, 63),
        ),
        child: RefreshIndicator(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  height: 300,
                  decoration: BoxDecoration(
                    //image: DecorationImage(image: NetworkImage("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1581095667754&di=a91f3760f8c280f1c43cb6887a5dc55c&imgtype=0&src=http%3A%2F%2Fdpic.tiankong.com%2Fwt%2F0j%2FQJ8863531772.jpg"),fit: BoxFit.cover),
                    color: this.containerColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            weather.wendu == ""?"正在加载..":this.weather.wendu+"℃",
                            style: TextStyle(
                                fontSize: 32,
                                color: Colors.white
                            ),),
                          IconButton(
                            icon: Icon(Icons.chevron_right,color: Colors.white,size: 30,),
                            onPressed: (){
                              /**
                               * 查看当天天气详情
                               */
                              Navigator.of(context).pushNamed("/detailed",arguments: this.weather.list[0]);
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(
                        weather.tianqi,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white
                      ),),
                      SizedBox(height: 10,),
                      Text(
                        weather.kongqi == ""?"":"空气质量："+weather.kongqi,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white
                      ),),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                _getForecastInfo(1),
                Divider(),
                SizedBox(height: 10,),
                _getForecastInfo(2),
                Divider(),
                SizedBox(height: 10,),
                _getForecastInfo(3),
                Divider(),
                SizedBox(height: 10,),
                _getForecastInfo(4),
                Divider(),
                SizedBox(height: 10,),
                _getForecastInfo(5),
                Divider(),
                SizedBox(height: 10,),
                _getForecastInfo(6),
                Divider(),
                SizedBox(height: 10,),
                _getForecastInfo(7),
              ],
            ),
            onRefresh: ()async{
              this._getLocationInfo();
            }
        ),
      )
    );
  }

  @override
  void update(Weather value) {
    // TODO: implement update
    String type = value.list[0].type;
    print("天气类型"+type);
    setState(() {
      this.weather = value;
      if(type.contains("雨")){
        this.bgColor = Color.fromARGB(255, 87, 85, 101);
        this.containerColor = Color.fromARGB(150, 87, 85, 101);
        this.imageUrl = "http://n.sinaimg.cn/sinacn/w600h423/20171206/fccc-fypikwu2086114.jpg";
      }else if (type.contains("云") || type.contains("阴")){
        this.bgColor = Color.fromARGB(255, 91, 104, 139);
        this.containerColor = Color.fromARGB(150, 91, 104, 139);
        this.imageUrl = "http://n.sinaimg.cn/sinacn/w640h380/20180304/ae3f-fxipenm7906410.jpg";
      }else if (type.contains("晴")){
        this.bgColor = Color.fromARGB(255, 55, 128, 205);
        this.containerColor = Color.fromARGB(150, 55, 128, 205);
        this.imageUrl = "http://i3.bbswater.fd.zol-img.com.cn/t_s480x480/g4/M0A/01/09/Cg-4WVO0shiIOyY7ACXDnNj_NTEAAPN9wC8q0EAJcO0793.jpg";
      }else{
        this.bgColor = Color.fromARGB(255, 24, 10, 33);
        this.containerColor = Color.fromARGB(200, 24, 10, 33);
        this.imageUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1581096025711&di=47134dd5d174d624394c35a4949fe2e9&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201809%2F15%2F20180915232230_pwgup.thumb.700_0.jpeg";
      }
    });
    print("update");
  }
}