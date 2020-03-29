import 'package:flutter/material.dart';
import 'home/hospital_item_widget.dart';
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'register/hospitalViewWidget.dart';
import 'dart:convert';

class registerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _scaffold = Scaffold(
      appBar: AppBar(
        title: Text("预约挂号",style: TextStyle(color: Color(0xff333333),fontSize: 18.0),),
        backgroundColor: Colors.white,
      ),

      body: hospitalListView(),
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
  RefreshController _refreshController = RefreshController(initialRefresh: true);
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
    super.initState();
  }
  void getHospitalList() async{
    Dio request = Dio();
    Response data = await request.get("https://www.91985.com/users/api/doctor/getHospitalList.do?page=$pageIndex");
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
        var hospitalItem =  hospital_item_widget(hospitalList[index] as Map,callback: (String hospitalId){
          Navigator.push(context, MaterialPageRoute(builder: (context) => hospitalViewWidget(hospitalList[index])));
          },
        );
        return hospitalItem;
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

    var scroll = Scrollbar(
      child: refresher,
//      height: 711,
    );
    return scroll;
  }
}

