import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../home/doctor_item_widget.dart';
import 'package:dio/dio.dart';
import 'doctor_detail_widget.dart';
import 'dart:convert';

class doctor_department_list_widget extends StatelessWidget {
  var _departmentId;
  var _secdepartmentId;
  var _hospitalId;
  doctor_department_list_widget(String hospitalId,String departmentId,String secdepartmentId){
    _hospitalId = hospitalId;
    _departmentId = departmentId;
    _secdepartmentId = secdepartmentId;
  }
  @override
  Widget build(BuildContext context) {
    var _scaffold = Scaffold(
      appBar: AppBar(
        title: Text(
          "医生列表", style: TextStyle(color: Color(0xff333333), fontSize: 18.0),),
        backgroundColor: Color(0xffffffff),
        centerTitle: true,
      ),
      body: doctor_list(_hospitalId,_departmentId,_secdepartmentId),
    );
    return _scaffold;
  }
}

class doctor_list extends StatefulWidget {
  var _departmentId;
  var _secdepartmentId;
  var _hospitalId;
  doctor_list(String hospitalId,String departmentId,String secdepartmentId){
    _hospitalId = hospitalId;
    _departmentId = departmentId;
    _secdepartmentId = secdepartmentId;
  }
  @override
  _doctor_listState createState() => _doctor_listState(_hospitalId,_departmentId,_secdepartmentId);
}

class _doctor_listState extends State<doctor_list> {
  var _hospitalId;
  var _departmentId;
  var _secdepartmentId;
  _doctor_listState(String hospitalId,String departmentId,String secdepartmentId){
    _hospitalId = hospitalId;
    _departmentId = departmentId;
    _secdepartmentId = secdepartmentId;
  }
  List _doctorList = new List();
  int _pageIndex = 1;
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
  }

  void reloadData(){
    _pageIndex = 1;
    getDoctorList();
  }

  void loadMoreData(){
    _pageIndex += 1;
    getDoctorList();
  }

  void getDoctorList() async{
    Dio request = Dio();
    Response response = await request.get("https://www.91985.com/users/api/doctor/doctorList.do?hospitalId=$_hospitalId&priDepHosId=$_departmentId&secDepHosId=$_secdepartmentId&page=$_pageIndex");
    Map map = json.decode(response.data.toString());
    setState(() {
      if(map["code"] == 0){
        if(_pageIndex == 1){
          _doctorList = map["attach"];
        }
        else{
          _doctorList.addAll(map["attach"]);
        }
      }
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {

    var _list = ListView.builder(
      itemBuilder: (BuildContext context,int index){
        var doctoritem = doctor_item_widget(_doctorList[index] as Map,callback: (String doctorId){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>doctor_detail_widget()));
        },);
        return doctoritem;
      },
      itemCount: _doctorList.length,
      itemExtent: 93,
    );

    var _refresher = SmartRefresher(
      controller: _refreshController,
      onLoading: loadMoreData,
      onRefresh: reloadData,
      header: WaterDropHeader(),
      footer: ClassicFooter(),
      enablePullDown: true,
      enablePullUp: true,
      child: _list,
    );

    var _scroll = Scrollbar(
      child: _refresher,
    );

    return _scroll;
  }
}
