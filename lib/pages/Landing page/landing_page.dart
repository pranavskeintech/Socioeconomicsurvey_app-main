import 'dart:async';
import 'dart:convert' as cnv;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/pages/Landing%20page/completed_page.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:socio_survey/components/getdevice_id.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/pages/user%20details%20page/user_details_page.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/pages/user%20details%20page/userdetails_api.dart';

import 'continue_page.dart';

class LandingPage extends StatefulWidget {
  static String route = "/splashscreen";
  LandingPage({Key key}) : super(key: key);

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  Timer _timer;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  Dio _dio = Dio();
  var deviceID;
  bool newUser = false;
  @override
  void initState() {

   // connectivityCheck.startMonitoring();
    //dioPost();

    // EasyLoading.addStatusCallback((status) {
    //   print('EasyLoading Status $status');
    //   if (status == EasyLoadingStatus.dismiss) {
    //     _timer?.cancel();
    //   }
    // });
  }


  Future getId() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final surveyID = _pref.getInt("userid");
    if (surveyID != null) {
      final deviceId = _pref.getString('D_id');
      int userId = _pref.get("userid");
     // String surveyId = "${deviceId + "S" + userId.toString()}";
      //_pref.setString("survey_id", surveyId);
      final sID = _pref.getString('survey_id');
      print("Survey Id Is :$sID");
      // print("Survey ID is: $surveyID");
    } else {
      _pref.setInt("userid", 1);
      print("New Survey ID Created: $surveyID");
    }
  }


  @override
  Widget build(BuildContext context) {
    return
      new WillPopScope(
        onWillPop: () async => false,
        child:
      Scaffold(body: Container(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Center(child: Image.asset('assets/images/splash.png')),

              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.grey,
                ),
                child: FlatButton(
                    onPressed: () async {
                      //dioPost();
                      SharedPreferences _pref =
                      await SharedPreferences.getInstance();
                      _pref.setString(
                          'survey_status', "new_survey");
                      Navigator.pushNamed(context, '/cities_page');
                    },
                    height: 50,
                    minWidth: 250,
                    textColor: Colors.white,
                    child: Text(
                      "Take New Survey",
                      style: TextStyle(fontSize: 20),
                    )),
              ),

              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.grey,
                ),
                child: FlatButton(
                    onPressed: () async {

                      SharedPreferences _pref =
                          await SharedPreferences.getInstance();
                      // final userPref = _pref.getString('userid');
                      final devicePref = _pref.getString('D_id');

                            _pref.setString(
                                'survey_status', "pending_survey");
                      if (newUser == true) {
                        await EasyLoading.showInfo(
                            'You Are New User \nYou Need to Take Survey');
                      } else if (devicePref != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContinuePage()));
                      } else {
                        await EasyLoading.showInfo(
                            'Device ID Must Generate\n Connect Internet and restart the app');
                        // setState(() {
                        //  deviceId();
                        // });
                      }
                    },
                    height: 50,
                    minWidth: 250,
                    textColor: Colors.white,
                    child: Text(
                      "Continue Survey",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.grey,
                ),
                child: FlatButton(
                    onPressed: () async {
                      SharedPreferences _pref =
                          await SharedPreferences.getInstance();
                      // final userPref = _pref.getString('userid');
                      final devicePref = _pref.getString('D_id');
                            _pref.setString(
                                'survey_status', "completed_survey");

                      if (newUser == true) {
                        await EasyLoading.showInfo(
                            'You Are New User \nYou Need to Take Survey');
                      } else if (devicePref != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompletedTaskPage()));
                      } else {
                        await EasyLoading.showInfo(
                            'Device ID Must Generate\n Connect Internet and restart the app');
                        // setState(() {
                        //  deviceId();
                        // });
                      }
                    },
                    height: 50,
                    minWidth: 250,
                    textColor: Colors.white,
                    child: Text(
                      "Completed Survey",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      )),
    ));
  }

  Future dioPost() async {
    print("diopost");
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final get_device_id = _pref.getString('D_id');
   // _pref.setString( "D_id", "D24");
    if (get_device_id != null) {
      print("Device is Id Already..!\n Device Id $get_device_id");
    } else {
      print("else");

          var url = 'http://13.232.140.106:5000/rsi-field-force-api/device/generate-device-id';
          var response = await http.post(Uri.parse(url));
              if (response.statusCode == 200) {
            print("response.data"+response.body);
            Map<String, dynamic> map = json.decode(response.body);
            List<dynamic> data = map["device_id"];
            print(data[0]["device_id"]);

            deviceID = data[0]["device_id"];
             print("Device Id is : ${deviceID.toString()}");
             getId();
             _pref.setString('D_id', deviceID);
             newUser = true;
      }
      ;
    }
  }
}
