// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:socio_survey/components/get_data.dart';
// import 'package:http/http.dart' as http;

// import 'completed_Sub_page.dart';
// import '../../dbHelper/dbHelper.dart';

// class CompletedTaskPage extends StatefulWidget {
//   CompletedTaskPage({Key key}) : super(key: key);

//   @override
//   _CompletedTaskPageState createState() => _CompletedTaskPageState();
// }

// class _CompletedTaskPageState extends State<CompletedTaskPage> {
//   Future<DeviceId> futureData;
//   @override
//   void initState() {
//     setState(() {
//       getDeviceId();
//       getId();
//     });

//     super.initState();
//   }

//   var empty = '';

//   Future getDeviceId() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     final deviceId = preferences.getString('D_id');
//     futureData = getDataById(deviceId);

//     setState(() {
//       deviceID = deviceId;
//     });
//   }

//   Future getId() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     final deviceId = preferences.getString('D_id');
//     setState(() {
//       id = deviceId;
//     });
//   }

//   String deviceID;
//   var id;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             actions: [
//               IconButton(
//                   onPressed: () async {
//                     await syncFromLocalDb();
//                     if (checkSynced.length == 0) {
//                       await EasyLoading.showInfo('No data to Sync...!');
//                     } else {
//                       await EasyLoading.showInfo('Local Data Synced...!');
//                     }
//                   },
//                   icon: Icon(Icons.sync))
//             ],
//             backgroundColor: Color(0xfff89d4cf),
//             title: Text(
//               "Device-$id",
//               style: GoogleFonts.quicksand(
//                   fontSize: 22, fontWeight: FontWeight.bold),
//             )),
//         body: FutureBuilder<DeviceId>(
//           future: futureData,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                   itemCount: snapshot.data.data.length,
//                   // ignore: missing_return
//                   itemBuilder: (BuildContext context, index) {
//                     final userData = snapshot.data.data;
//                     if (userData[index].tourism_status == "1") {
//                       return InkWell(
//                           onTap: () {
//                             print(userData[index].user_family_status);

//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SubPage(
//                                           index: userData[index].surveyId,
//                                         )));
//                           },
//                           child: Container(
//                             width: 200,
//                             height: 100,
//                             child: Card(
//                                 shadowColor: Colors.blueAccent,
//                                 elevation: 5,
//                                 child: Center(
//                                   child: ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text(
//                                       "Survey ${userData[index].surveyId.toString()}",
//                                       style: GoogleFonts.quicksand(
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                     trailing:
//                                         Icon(Icons.arrow_forward_ios_rounded),
//                                   ),
//                                 )),
//                           ));
//                     } else if (empty == "") {
//                       empty = "No Completed Survey";

//                       EasyLoading.showInfo('No Completed Survey');
//                     } else {
//                       return Container();
//                     }
//                   });
//             } else if (snapshot.hasError) {
//               print(snapshot.hasError);
//               return Center(
//                 child: Text('Empty...!',
//                     style: GoogleFonts.quicksand(fontSize: 25)),
//               );
//             }

//             return Center(child: const CircularProgressIndicator());
//           },
//         ));
//   }

//   List checkSynced = [];
//   Future syncFromLocalDb() async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     final devId = _pref.getString('D_id');
//     var dataList = await DbHelper.instance.userMapList();

//     dataList.forEach((e) {
//       postMethod(
//           deviceId: devId.toString(),
//           surveyId: e['survey_id'].toString(),
//           ques: e['question'].toString(),
//           ans: e['answer'].toString());
//       checkSynced.add(e);
//     });
//     await DbHelper.instance.deleteData();
//   }

//   Future postMethod(
//       {String deviceId, String surveyId, String ques, String ans}) async {
//     try {
//       var data = {
//         "device_id": deviceId.toString(),
//         "survey_id": surveyId.toString(),
//         "question": ques.toString(),
//         "answer": ans.toString()
//       };
//       var response = await http.post(
//           Uri.parse(
//               'http://13.232.140.106:3030/rsi-field-force-api/user/post-survey'),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: json.encode(data));

//       // print(response.body);
//       String id = response.body;
//       print("Response====>$id");
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<DeviceId> getDataById(id) async {
//     final response = await http.get(Uri.parse(
//         "http://13.232.140.106:5000/rsi-field-force-api/survey/get-survey-details?devices_id=$id"));
//     if (response.statusCode == 200) {
//       print("Response===${response.body}");
//       return DeviceId.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load Data');
//     }
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:http/http.dart' as http;

import 'completed_Sub_page.dart';
import '../../dbHelper/dbHelper.dart';

class CompletedTaskPage extends StatefulWidget {
  CompletedTaskPage({Key key}) : super(key: key);

  @override
  _CompletedTaskPageState createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  Future<DeviceId> futureData;
  @override
  void initState() {
    setState(() {
      getDeviceId();
      getId();
    });

    super.initState();
  }

  var empty = '';

  Future getDeviceId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final deviceId = preferences.getString('D_id');
    futureData = getDataById(deviceId);

    setState(() {
      deviceID = deviceId;
    });
  }

  Future getId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final deviceId = preferences.getString('D_id');
    setState(() {
      id = deviceId;
    });
  }

  String deviceID;
  var id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () async {
                    await syncFromLocalDb();
                    if (checkSynced.length == 0) {
                      await EasyLoading.showInfo('No data to Sync...!');
                    } else {
                      await EasyLoading.showInfo('Local Data Synced...!');
                    }
                  },
                  icon: Icon(Icons.sync))
            ],
            backgroundColor: Color(0xfff89d4cf),
            title: Text(
              "Device-$id",
              style: GoogleFonts.quicksand(
                  fontSize: 22, fontWeight: FontWeight.bold),
            )),
        body: FutureBuilder<DeviceId>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.data.length,
                  // ignore: missing_return
                  itemBuilder: (BuildContext context, index) {
                    final userData = snapshot.data.data;
                    if (userData[index].tourismStatus == "1") {
                      return InkWell(
                          onTap: () {
                            print(userData[index].user_family_status);
                            print("userData[index].tourismStatus${userData[index].surveyId}");
                            print("userData[index].tourismStatus${userData[index].tourismStatus}");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubPage(
                                      index: userData[index].surveyId,
                                    )));
                          },
                          child: Container(
                            width: 200,
                            height: 100,
                            child: Card(
                                shadowColor: Colors.blueAccent,
                                elevation: 5,
                                child: Center(
                                  child: ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(
                                      "Survey ${userData[index].surveyId.toString()}",
                                      style: GoogleFonts.quicksand(
                                        fontSize: 20,
                                      ),
                                    ),
                                    trailing:
                                    Icon(Icons.arrow_forward_ios_rounded),
                                  ),
                                )),
                          ));
                    }
                    // else if (empty == "") {
                    //   empty = "No Completed Survey";
                    //
                    //   // EasyLoading.showInfo('No Completed Survey');
                    // }
                    else {
                      return Container();
                    }
                  });
            } else if (snapshot.hasError) {
              print(snapshot.hasError);
              return Center(
                child: Text('Empty...!',
                    style: GoogleFonts.quicksand(fontSize: 25)),
              );
            }

            return Center(child: const CircularProgressIndicator());
          },
        ));
  }

  List checkSynced = [];
  Future syncFromLocalDb() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final devId = _pref.getString('D_id');
    var dataList = await DbHelper.instance.userMapList();

    dataList.forEach((e) {
      postMethod(
          deviceId: devId.toString(),
          surveyId: e['survey_id'].toString(),
          ques: e['question'].toString(),
          ans: e['answer'].toString());
      checkSynced.add(e);
    });
    await DbHelper.instance.deleteData();
  }

  Future postMethod(
      {String deviceId, String surveyId, String ques, String ans}) async {
    try {
      var data = {
        "device_id": deviceId.toString(),
        "survey_id": surveyId.toString(),
        "question": ques.toString(),
        "answer": ans.toString()
      };
      var response = await http.post(
          Uri.parse(
              'http://13.232.140.106:3030/rsi-field-force-api/user/post-survey'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(data));

      // print(response.body);
      String id = response.body;
      print("Response====>$id");
    } catch (e) {
      print(e);
    }
  }

  Future<DeviceId> getDataById(id) async {
    final response = await http.get(Uri.parse(
        "http://13.232.140.106:5000/rsi-field-force-api/survey/get-survey-details?devices_id=$id"));
    if (response.statusCode == 200) {
      print("Response===${response.body}");
      return DeviceId.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}