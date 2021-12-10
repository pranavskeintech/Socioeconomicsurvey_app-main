import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/pages/user%20details%20page/user_details_page.dart';
import 'package:socio_survey/pages/user%20details%20page/user_details_page.dart';

class Cities extends StatefulWidget {
  Cities({Key key}) : super(key: key);

  @override
  _CitiesState createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  String valueChoose;
  SharedPreferences sharedPreferences;
  int addToShared;
  List cities = [
    "HOWRAH MUNICIPAL CORPORATION",
    "RAJPUR-SONARPUR",
    "MAHESHTALA",
    "SANTIPUR",
    "BALURGHAT",
    "SILIGURI MUNICIPAL CORPORATION",
    "JALPAIGURI",
    "DARJEELING"
  ];
  Future cityPref(String city) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("city", city);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getDeviceId();
  }

  getDeviceId() async {
    //int addToShared;
    int dataLength;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final deviceId = preferences.getString('D_id');
    print("deviceId");
    print(deviceId);

    final response = await http.get(Uri.parse(
        "http://13.232.140.106:5000/rsi-field-force-api/survey/get-survey-id?devices_id=$deviceId"));
    if (response.statusCode == 200) {
      print("Response--${response.body}");
      var res = jsonDecode(response.body);
      print(res["status"]);
      if(res["status"]){
        if (res["data"] == null) {
          dataLength = 0;
        } else {
          dataLength = res["data"].length;
          print(res["data"].length);
        }
        setState(() {
          addToShared = dataLength + 1;
        });
        //var sample = getDataById(deviceId);
        print(deviceId);
        print(dataLength);
        int len = dataLength + 1;
        SharedPreferences _pref = await SharedPreferences.getInstance();
        String surveyId = "${deviceId + "S"}$len";
        _pref.setString("survey_id", surveyId);
      }else{
        SharedPreferences _pref = await SharedPreferences.getInstance();
        String surveyId = "${deviceId }"+"S1";
        _pref.setString("survey_id", surveyId);
        print(_pref.getString("survey_id"));
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xfff6e45e1), Color(0xfff89d4cf)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: Container(
        margin: EdgeInsets.only(top: 150, bottom: 150, left: 15, right: 15),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "AMRUT CITIES IN WEST BENGAL",
              style: GoogleFonts.quicksand(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButton(
                  hint: Text("Select Cities"),
                  value: valueChoose,
                  onChanged: (value) {
                    setState(() {
                      valueChoose = value;
                      cityPref(valueChoose);
                    });
                    // setState(() {
                    //   valueChoose = value;
                    //   print(valueChoose);
                    // });
                  },
                  items: cities.map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList()),
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
                    if (valueChoose != null) {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      var printValue = preferences.getString("city");
                      print(
                          "Choosen Value Strored in sharedPreferences is =$printValue");
                      //Navigator.pushNamed(context, "/user_details");
                      getDeviceId();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserDetailsBuilder()));
                    } else {
                      await EasyLoading.showInfo("Please Select City");
                    }
                  },
                  height: 50,
                  minWidth: 250,
                  textColor: Colors.white,
                  child: Text("Next",
                      style: GoogleFonts.quicksand(fontSize: 22.0))),
            ),
          ],
        ),
      ),
    );
  }

  // getDataById(id) async {
  //   final response = await http.get(Uri.parse(
  //       "http://13.232.140.106:5000/rsi-field-force-api/survey/get-survey-id?devices_id=$id"));
  //   if (response.statusCode == 200) {
  //     print("Response===${response.body}");
  //     var res = jsonDecode(response.body);
  //     print(res["data"].length);
  //     var dataLength = res["data"].length;
  //     int addToShared = dataLength + 1;

  //     return addToShared;
  //   } else {
  //     throw Exception('Failed to load Data');
  //   }
  // }
}
