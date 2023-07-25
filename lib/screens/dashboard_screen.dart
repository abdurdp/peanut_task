// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peanut_task/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import '../classes/shimmer.dart';
import '../permissions/connectivity/online.dart';
import '../providers/profile_provider.dart';
import '../utils/application_utils.dart';
import '../utils/colors.dart';
import '../utils/dialog_utils.dart';
import '../utils/dimensions.dart';

class DashboardScreen extends StatefulWidget {

  DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List titleList = ["Profile", "Trades"];
  int _pageIndex = 0;
  List _openTradesDataList = [];
  bool _hasData = false;
  bool _loadingData = true;

  var profit= 0.0;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    if (mounted) {

    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Online(
      child: WillPopScope(
        onWillPop: DialogUtils.applicationClose,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          key: _scaffoldKey,
          backgroundColor: CustomColor.whiteColor,
          bottomNavigationBar: BottomNavigationBar(
            unselectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold),
            currentIndex: _pageIndex,
            selectedItemColor: CustomColor.appColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: (index) {
              setState(() {
                _pageIndex = index;
                if (index == 1) {
                  _fetchOpenTradesData();
                }
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_open),
                label: 'Trades',
              ),
            ],
          ),
          body: SafeArea(
            child: Container(
                child: buildTwoPageViewChildren().elementAt(_pageIndex)),
          ),
        ),
      ),
    );
  }

  List<Widget> buildTwoPageViewChildren() {
    return <Widget>[
      ProfileScreen(),
      openTradesWidget(context),
    ];
  }

  Widget openTradesWidget(BuildContext context) {
    return Stack(
      children:[
        Container(
        child: _openTradesDataList.isNotEmpty
            ? ListView.builder(
          shrinkWrap: true,
          itemCount: _openTradesDataList.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
              margin:EdgeInsets.fromLTRB(0, 50, 0, 0) ,
              padding: EdgeInsets.all(
                Dimensions.extraSmallSize * 2,
              ),
              decoration: BoxDecoration(
                color: CustomColor.whiteColor,
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: CustomColor.dividerColor,
                  ),
                ),
              ),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      ListTile(
                        dense: true,
                        title: Text('currentPrice'),
                        subtitle: Text(_openTradesDataList[index]['currentPrice'].toString()),

                      ),
                      ListTile(
                        dense: true,
                        title: Text('comment'),
                        subtitle: Text(_openTradesDataList[index]['comment'].toString()),

                      ),
                      ListTile(
                        dense: true,
                        title: Text('digits'),
                        subtitle: Text(_openTradesDataList[index]['digits'].toString()),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('login'),
                        subtitle: Text(_openTradesDataList[index]['login'].toString()),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('openPrice'),
                        subtitle: Text(_openTradesDataList[index]['openPrice'].toString()),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('openTime'),
                        subtitle: Text(_openTradesDataList[index]['openTime'].toString()),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('profit'),
                        subtitle: Text(_openTradesDataList[index]['profit'].toString()),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('swaps'),
                        subtitle: Text(_openTradesDataList[index]['swaps'].toString()),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('symbol'),
                        subtitle: Text(_openTradesDataList[index]['symbol'].toString()),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('tp'),
                        subtitle: Text(_openTradesDataList[index]['tp'].toString()),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('ticket'),
                        subtitle: Text(_openTradesDataList[index]['ticket'].toString()),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('type'),
                        subtitle: Text(_openTradesDataList[index]['type'].toString()),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('volume'),
                        subtitle: Text(_openTradesDataList[index]['volume'].toString()),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        )
            : _loadingData
            ? NotificationDataShimmer()
            : !_hasData
            ? Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          padding: EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          width: double.infinity,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.crisis_alert_outlined,
                  size: 56,
                  color: CustomColor.labelColor,
                ),
                SizedBox(height: 12.0),
                Text(
                  'NO DATA AVAILABLE',
                  style: TextStyle(
                    color: CustomColor.labelColor,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        )
            : SizedBox.shrink(),
      ),
        Container(
          height: 50,
          child: Card(
            elevation: 10,
            color: CustomColor.greenColor,
            // shadowColor: CustomColor.primaryColor,
            surfaceTintColor: CustomColor.bgColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "profit:",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                SizedBox(
                  width: Dimensions.extraSmallSize,
                ),
                Text(
                  profit.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 15,
          bottom: 15,
          child: ElevatedButton(onPressed: () async {
            setState(() {
              profit = 0.0;
            });
            _fetchOpenTradesData();
          }, child: Text("Refresh")),
        )
      ]
    );
  }


  void _fetchOpenTradesData() async {
    List dataList = [];
    try {
      List data =
      await Provider.of<ProfileProvider>(context, listen: false)
          .getOpenTrades();
      Map map = data.asMap();
    map.forEach((key, value) {
    Map maps = {
    'currentPrice': map[key]['currentPrice'],
    'comment': map[key]['comment'],
    'digits': map[key]['digits'],
    'login': map[key]['login'],
    'openPrice': map[key]['openPrice'],
    'openTime': map[key]['openTime'],
    'profit': map[key]['profit'],
    'sl': map[key]['sl'],
    'swaps': map[key]['swaps'],
    'symbol': map[key]['symbol'],
    'tp': map[key]['tp'],
    'ticket': map[key]['ticket'],
    'type': map[key]['type'],
    'volume': map[key]['volume'],
    };
    dataList.add(maps);
    });
    } catch (err) {
    print(err);
    }
    if (mounted)
    setState(() {
    dataList.forEach((element) {
      if(element['profit']!= null) {
        profit =  double.parse(element['profit'].toString()) + profit;
      }
    });
    _openTradesDataList = dataList;
    _loadingData = false;
    _hasData = _openTradesDataList.length > 0 ? true : false;
    });
  }
}
