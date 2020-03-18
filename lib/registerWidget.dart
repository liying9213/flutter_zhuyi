import 'package:flutter/material.dart';
import 'home/hospital_item_widget.dart';
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:convert';

class registerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _scaffold = Scaffold(
      appBar: AppBar(
        title: Text("预约挂号",style: TextStyle(color: Color(0xff333333),fontSize: 18.0),),
        backgroundColor: Colors.white,
      ),

      body: Container(
        color: Color(0xfff5f5f5),
        child: Column(
          children: <Widget>[
            hospitalListView(),
          ],
        ),
      ),
    );
    return _scaffold;
  }
}

class hospitalListView extends StatefulWidget {
  @override
  _hospitalListViewState createState() => _hospitalListViewState();
}

class _hospitalListViewState extends State<hospitalListView> {
  List hospitalList=new List();
  int pageIndex = 1;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onRefresh() async{
    this.pageIndex = 1;
    // monitor network fetch
    getHospitalList();
    // if failed,use refreshFailed()
  }

  void _onLoading() async{
    this.pageIndex += 1;
    getHospitalList();
    // monitor network fetch
  }


  @override
  void initState() {
    if(hospitalList.length == 0) {
      getHospitalList();
    }
    super.initState();
  }
  void getHospitalList() async{
    Dio request = Dio();
    Response data = await request.get("https://www.91985.com/users/api/doctor/getHospitalList.do?page=$pageIndex");
    print(data.data.toString());
    Map map = json.decode(data.data.toString());
    setState(() {
      if(map["code"] == 0){
        if(pageIndex>1){
          hospitalList.addAll(map["attach"]);
        }
        else{
          hospitalList = map["attach"];
        }
      }
    });

    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {

    var _listView = ListView.builder(
      itemBuilder: (BuildContext context, int index){
        return hospital_item_widget(hospitalList[index] as Map);
      },
      itemCount: hospitalList.length,
    );

    var refresher =  SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: ClassicFooter(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: _listView,
    );

    var scroll = Container(
      child: refresher,
      height: 711,
    );



    return scroll;
  }
}

