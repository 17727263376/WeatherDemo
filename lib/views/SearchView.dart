import 'package:flutter/material.dart';

class SearchView extends StatefulWidget{
  @override
  _SearchView createState() => _SearchView();
}

class _SearchView extends State<SearchView>{
  TextEditingController controller = new TextEditingController();

  List<String> data = ["北京","上海","广州","深圳","天津","杭州","东莞","宁波","西安","成都","重庆","南京","苏州","武汉","厦门","福州","昆明","沈阳",
  "长春","大连","济南","青岛","郑州","兰州","太原","合肥","哈尔滨","长沙","石家庄","南昌","珠海","香港","澳门","台北"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 55, 128, 205),
        title: TextField(
          controller: controller,
          autofocus: true,
          onSubmitted: (value){
            Navigator.of(context).pop(controller.text);
          },
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),color: Colors.white,onPressed: (){
            Navigator.of(context).pop(controller.text);
          },)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10,),
          Text("热门城市"),
          SizedBox(height: 10,),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: _getHotCity(),
            ),
          )
          ],
        ),
      )
    );
  }

  List<Widget> _getHotCity(){
    List<Widget> result = new List();

    for(int i = 0; i < this.data.length; i++){
      result.add(RaisedButton(
        color: Color.fromARGB(255, 55, 128, 205),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Text(this.data[i], style: TextStyle(color: Colors.white),),
        onPressed: (){
          Navigator.of(context).pop(this.data[i]);
        },
      ),);
    }
    return result;
  }
}