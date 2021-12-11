import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/components/survey_id_model.dart';
import 'package:socio_survey/main.dart';
import 'package:socio_survey/models/survey_model.dart';
import 'package:socio_survey/pages/Coastal%20Page/coastal_page.dart';
import 'package:socio_survey/pages/Economy%20and%20Industries%20page/economy_and_indu_page.dart';
import 'package:socio_survey/pages/Landing%20page/starting_screen.dart';
import 'package:socio_survey/pages/Tourism%20Page/tourism_page.dart';
import 'package:socio_survey/pages/Transportation%20page/transportation_page.dart';
import 'package:socio_survey/pages/cultural%20and%20heritage%20page/cultural_and_heritage.dart';
import 'package:socio_survey/pages/householdprofilepage/household_profile_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:socio_survey/pages/physical%20infrastructure%20page/physical_infrastructure_page.dart';
import 'package:socio_survey/pages/slums%20page/slums_page.dart';
import 'package:socio_survey/pages/social%20infrastructure%20page/social_infrastructure_page.dart';
import 'package:socio_survey/pages/user%20details%20page/user_details_page.dart';

import 'completed_Sub_page.dart';
import '../../dbHelper/dbHelper.dart';

class ContinuePage extends StatefulWidget {
  ContinuePage({Key key}) : super(key: key);

  @override
  _ContinuePageState createState() => _ContinuePageState();
}

class _ContinuePageState extends State<ContinuePage> {
  Future futureData;
  List surveyResponse;

  @override
  void initState() {
    setState(() {
      getDeviceId();
      getId();
    });

    super.initState();
    // getDataById(id);
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
              style: GoogleFonts.quicksand(fontSize: 22, fontWeight: FontWeight.bold),
            )),
        body: FutureBuilder(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.data.length,
                  // ignore: missing_return
                  itemBuilder: (BuildContext context, index) {
                    final userData = snapshot.data.data;
                    if (userData[index].user_family_status != "1" && userData[index].household_status != "1" ||
                        userData[index].housing_status != "1" ||
                        userData[index].economy_status != "1" ||
                        userData[index].transportation_status != "1" ||
                        userData[index].physical_infrastructure_status != "1" ||
                        userData[index].social_infrastructure_status != "1" ||
                        userData[index].slums_status != "1" ||
                        userData[index].coastal_status != "1" ||
                        userData[index].cultural_heritage_status != "1" ||
                        userData[index].tourism_status != "1") {
                      return InkWell(
                          onTap: () async {
                            SharedPreferences _pref = await SharedPreferences.getInstance();
                            _pref.setString('survey_id', userData[index].surveyId);
                            surveyModel = SurveyModel.fromJson(surveyResponse[index]);
                            print("Checl == ${surveyModel.surveyId}");
                            if (userData[index].user_family_status != "1" || userData[index].user_family_status == null) {
                              print("1");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserDetailsBuilder(
                                            surveyId: surveyModel.surveyId,
                                          )));
                            } else if (userData[index].household_status != "1" || userData[index].household_status == null) {
                              print("2");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HouseHoldPofilePage(
                                            surveyId: surveyModel.surveyId,
                                          )));
                            } else if (userData[index].housing_status != "1" || userData[index].housing_status == null) {
                              print("3");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HousingPage(
                                            surveyId: surveyModel.surveyId,
                                          )));
                            } else if (userData[index].economy_status != "1" || userData[index].economy_status == null) {
                              print("4");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EconomyAndIndustriesPage(
                                            surveyId: surveyModel.surveyId,
                                          )));
                            } else if (userData[index].transportation_status != "1" || userData[index].transportation_status == null) {
                              print("5");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TransportationPage(
                                            surveyId: surveyModel.surveyId,
                                          )));
                            } else if (userData[index].physical_infrastructure_status != "1" || userData[index].physical_infrastructure_status == null) {
                              print("6");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhysicalInfrastructurePage(
                                            surveyId: surveyModel.surveyId,
                                          )));
                            } else if (userData[index].social_infrastructure_status != "1" || userData[index].social_infrastructure_status == null) {
                              print("7");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SocialInfrastructurePage(
                                            surveyId: surveyModel.surveyId,
                                          )));
                            } else if (userData[index].slums_status != "1" || userData[index].slums_status == null) {
                              print("8");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SlumsPage(
                                            surveyId: surveyModel.surveyId,
                                          )));
                            } else if (userData[index].coastal_status != "1" || userData[index].coastal_status == null) {
                              print("9");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CoastalPage(
                                            surveyId: surveyModel.surveyId,
                                          )));
                            } else if (userData[index].cultural_heritage_status != "1" || userData[index].cultural_heritage_status == null) {
                              print("10");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CulturalAndHeritage(
                                            surveyId: surveyModel.surveyId,
                                          )));
                            } else if (userData[index].tourism_status != "1" || userData[index].tourism_status == null) {
                              print("11");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TourismPage(
                                            surveyId: surveyModel.surveyId,
                                          )));
                            } else {
                              print("Error");
                            }

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SubPage(
                            //               index: userData[index].surveyId,
                            //             )));
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
                                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                                  ),
                                )),
                          ));
                    } else if (empty == "") {
                      EasyLoading.showInfo('No Pending Survey');
                    } else {
                      return Container();
                    }
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Empty...!', style: GoogleFonts.quicksand(fontSize: 25)),
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
      postMethod(deviceId: devId.toString(), surveyId: e['survey_id'].toString(), ques: e['question'].toString(), ans: e['answer'].toString());
      checkSynced.add(e);
    });
    await DbHelper.instance.deleteData();
  }

  Future postMethod({String deviceId, String surveyId, String ques, String ans}) async {
    try {
      var data = {"device_id": deviceId.toString(), "survey_id": surveyId.toString(), "question": ques.toString(), "answer": ans.toString()};
      var response = await http.post(Uri.parse('http://13.232.140.106:3030/rsi-field-force-api/user/post-survey'),
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

  Future getDataById(id) async {
    print("http://13.232.140.106:5000/rsi-field-force-api/survey/get-survey-details?devices_id=$id");
    final response = await http.get(Uri.parse("http://13.232.140.106:5000/rsi-field-force-api/survey/get-survey-details?devices_id=$id"));
    print("Response == ${response.statusCode}");
   // try {
      if (response.statusCode == 200) {
        print("Response -- ${response.body}");
        surveyResponse = (json.decode(response.body))['data'];
        return DeviceId.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load Data');
      }
    /*} catch (e) {
      print("Errror = $e");
    }*/
  }
}
