import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class StartingScreen extends StatefulWidget {
  static const String route = "/starting_screen";
  StartingScreen({Key key}) : super(key: key);

  @override
  _StartingScreenState createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/1.png'),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            right: 22,
            bottom: 10,
            child: Container(
              height: 250,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Color(0xffFAFAFA)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("RSI FieldForce",
                      style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 35))),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      getDeviceId();
                      Navigator.pushNamed(context, '/landing_page');
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0XFF7070B8)),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future getDeviceId() async {
    print("diopost");
    SharedPreferences _pref = await SharedPreferences.getInstance();
    if(_pref.getString('D_id')== null){
      var url = 'http://13.232.140.106:5000/rsi-field-force-api/device/generate-device-id';
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        print("response.data"+response.body);
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["device_id"];
        print(data[0]["device_id"]);
        var deviceID = data[0]["device_id"];
        print(deviceID);
        _pref.setString('D_id',deviceID);
      }
    }

  }

}
