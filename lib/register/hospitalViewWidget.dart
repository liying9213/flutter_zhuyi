import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'doctor_department_list_widget.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class hospitalViewWidget extends StatelessWidget {
  Map _hospialMap ;

  hospitalViewWidget(Map hospital){
    _hospialMap = hospital;
  }

  @override
  Widget build(BuildContext context) {
    var view = Scaffold(
      appBar: AppBar(
        title: Text("医院详情",style: TextStyle(color: Color(0xff333333),fontSize: 18.0),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          hospital_header_widget(_hospialMap),
          Container(
            padding: EdgeInsets.only(left: 0,right: 0,top: 0),
            color: Color(0xffEEEEEE),
            height: 1,
          ),
          Expanded(
            child: hospital_deparment_widget(_hospialMap["id"].toString()),
          ),
        ],
      ),
    );
    return view;
  }
}


class hospital_header_widget extends StatelessWidget {
  Map _hospitalMap ;
  hospital_header_widget(Map hospital){
    _hospitalMap = hospital;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8,top: 16),
            child: CachedNetworkImage(
              imageUrl: _hospitalMap["imageUrl"],
              height: 60,
              width: 80,
              placeholder: (context,url)=>Image.asset("image/hospitalDefault.png",width: 80,height: 60,),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8,top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(_hospitalMap["hospitalName"],style: TextStyle(color: Color(0xff333333),fontSize: 14),),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0,top: 2),
                  alignment: Alignment.topLeft,
                  height: 18,
                  child: Chip(
                    padding: EdgeInsets.only(top: -16,bottom: 0),
                    label: Text(_hospitalMap["hosRank"],style: TextStyle(color: Color(0xff45C45A),fontSize: 10),),
                    backgroundColor: Color(0xffE5F3E7),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0,top: 6,right: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("预约量：",style: TextStyle(color: Color(0xff999999),fontSize: 10),),
                      Text(_hospitalMap["appointNum"].toString(),style: TextStyle(color: Color(0xff45C45A),fontSize: 10)),
                      Text("  距离：",style: TextStyle(color: Color(0xff999999),fontSize: 10)),
                      Text("0.0km",style: TextStyle(color: Color(0xff45C45A),fontSize: 10)),
                      Text("  评分：",style: TextStyle(color: Color(0xff999999),fontSize: 10)),
                      Text(_hospitalMap["score"].toString(),style: TextStyle(color: Color(0xff45C45A),fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class hospital_deparment_widget extends StatefulWidget {
  String _hospitalId;
  hospital_deparment_widget(String hosptialId){
    _hospitalId = hosptialId;
  }
  @override
  _hospital_deparment_widgetState createState() => _hospital_deparment_widgetState(_hospitalId);
}

class _hospital_deparment_widgetState extends State<hospital_deparment_widget> {
  String _hospitalId;
  _hospital_deparment_widgetState(String hosptialId){
    _hospitalId = hosptialId;
  }
  List _deparmentList = new List();
  Map _hospitalInfo = new Map();
  int _leftSelectIndex = 0;

  @override
  void initState() {
    get_hospital_info();
    super.initState();
  }

  void get_hospital_info() async{
    Dio request = Dio();
    Response response = await request.get("https://www.91985.com/users/api/doctor/hospitalDetail.do?id=$_hospitalId");
    Map map = json.decode(response.data.toString());
    setState(() {
      if(map["code"] == 0){
        _deparmentList = map["attach"]["deptList"] as List;
        _hospitalInfo = map["attach"]["hospital"] as Map;
      }
    });
  }

  void doctorList(String hospitalId,String departmentId,String secDepartmentId){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>doctor_department_list_widget(hospitalId,departmentId,secDepartmentId)));
  }

  @override
  Widget build(BuildContext context) {

    var leftView = ListView.builder(
      itemBuilder: (BuildContext context ,int index){
        var view = Container(
          padding: EdgeInsets.only(left: 8),
          alignment: Alignment.centerLeft,
          child: Text(_deparmentList[index]["name"],style: TextStyle(fontSize: 14,color: Color(0xff333333)),textAlign: TextAlign.start,),
          color: _leftSelectIndex == index ? Color(0xffffffff) : Color(0xfff5f5f5),
        );
        var gestureDetector = GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: view,
          onTap: (){
            setState(() {
              _leftSelectIndex = index;
            });
          },
        );
        return gestureDetector;
      },
      itemCount:_deparmentList.length,
      itemExtent: 60,
    );

    var rightView = ListView.builder(
      itemBuilder: (BuildContext context ,int index){
        var view = Container(
          padding: EdgeInsets.only(left: 8),
          alignment: Alignment.centerLeft,
          child: Text(_deparmentList[_leftSelectIndex]["secDeptList"][index]["name"],style: TextStyle(fontSize: 14,color: Color(0xff333333)),textAlign: TextAlign.start,),
          color: Color(0xffffffff),
        );
        var gestureDetector = GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: view,
          onTap: (){
            setState(() {
              doctorList(
                  _hospitalInfo["id"].toString(),_deparmentList[_leftSelectIndex]["id"],_deparmentList[_leftSelectIndex]["secDeptList"][index]["id"]);
            });
          },
        );
        return gestureDetector;
      },
      itemCount:_deparmentList.length >0 ?(_deparmentList[_leftSelectIndex]["secDeptList"] as List).length :0,
      itemExtent: 60,
    );

    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: leftView,
        ),
        Expanded(
            child: rightView,
            flex: 2
        ),
      ],
    );
  }
}



