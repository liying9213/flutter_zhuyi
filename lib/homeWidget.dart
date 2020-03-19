import 'package:flutter/material.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:flutterzhuyi/home/hospital_item_widget.dart';
import 'home/function_type_Widget.dart';
import 'home/department_type_widget.dart';
import 'package:dio/dio.dart';
import 'register/hospitalViewWidget.dart';
import 'register/doctor_list_widget.dart';
import 'dart:convert';

class homeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _scaffold = Scaffold(
      appBar: AppBar(
        title: Text("首页",style: TextStyle(color: Color(0xff333333),fontSize: 18.0),),
        backgroundColor: Colors.white,
      ),
      body: listview()
    );
    return _scaffold;
  }
}

class listview extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var scroll = CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: content(),
        ),
        hospitalListView(),
      ],

    );
    return scroll;
  }
}



Widget _buildListItem(BuildContext context, int index){
  return ListTile(
      title: Text('list tile index $index')
  );
}

class content extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var _contetView = Column(
      children: <Widget>[
        bannerWidget(),
        function_type_Widget(
          callback: (index){
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>hospitalViewWidget()));
            print("======$index=======----");
          },
        ),
        department_type_widget(
          callback: (disease){
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>doctor_list_widget(disease)));
          },
        ),
        Container(
          padding: EdgeInsets.only(left: 16,bottom:16),
          alignment: Alignment.topLeft,
          child: Text("热门医院",style: TextStyle(color: Color(0xff333333),fontSize: 16),textAlign: TextAlign.start,),
        ),
      ],
    );
    return _contetView;
  }
}

class bannerWidget extends StatefulWidget {
  @override
  _bannerWidgetState createState() => _bannerWidgetState();
}

class _bannerWidgetState extends State<bannerWidget> {
  List<String> bannerList=new List();
  @override
  void initState() {
    super.initState();
    if(bannerList.length == 0) {
      getDepartment();
    }
  }
  void getDepartment() async{
    Dio request = Dio();
    Response data = await request.get("https://www.91985.com/users/api/app/banner.do");
    Map map = json.decode(data.data.toString());
    if (mounted) {
      setState(() {
        if (map["code"] == 0) {
          List list = map["attach"];
          for (int i = 0; i < list.length; i++) {
            bannerList.add(list[i]["url"]);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return getList();
  }

  Widget getList() {
    return BannerSwiper(
      //width  和 height 是图片的高宽比  不用传具体的高宽   必传
      height: 686,
      width: 258,
      //轮播图数目 必传
      length: bannerList.length,
      //轮播的item  widget 必传
      getwidget: (index) {
        return new GestureDetector(
            child: Image.network(
              bannerList[index % bannerList.length],
              fit: BoxFit.cover,
            ),
            onTap: () {
              //点击后todo
            });
      },
    );
  }
}

class hospitalListView extends StatefulWidget {
  @override
  _hospitalListViewState createState() => _hospitalListViewState();
}

class _hospitalListViewState extends State<hospitalListView> {
  List hospitalList=new List();
  @override
  void initState() {
    if(hospitalList.length == 0) {
      getHospitalList();
    }
    super.initState();
  }
  void getHospitalList() async{
    Dio request = Dio();
    Response data = await request.get("https://www.91985.com/users/api/doctor/hotHospital.do");
    Map map = json.decode(data.data.toString());;
    setState(() {
      if(map["code"] == 0){
        hospitalList = map["attach"];
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var listView = SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
            getHospitalItem,
            childCount: hospitalList.length,
        ),
        itemExtent:80.0,
    );
    return listView;
  }

  Widget getHospitalItem(BuildContext context, int index){
    var hospitalItem =  hospital_item_widget(hospitalList[index] as Map,callback: (String hospitalId){
        Navigator.push(context, MaterialPageRoute(builder: (context) => hospitalViewWidget()));
      },
    );
    return hospitalItem;
  }


}

