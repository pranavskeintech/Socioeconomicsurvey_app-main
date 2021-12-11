import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:socio_survey/dbHelper/dbHelper.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/components/textfield_container.dart';
import 'package:socio_survey/json%20data/phisicalInfra_data.dart';
import 'package:socio_survey/main.dart';
import 'package:socio_survey/models/PhisicalInfraQuestion.dart';
import 'package:socio_survey/pages/Transportation%20page/transportation_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:socio_survey/pages/social%20infrastructure%20page/social_infrastructure_page.dart';

import 'package:http/http.dart' as http;
import 'package:socio_survey/widgets/contant_widget.dart';
import 'package:socio_survey/widgets/contants_question.dart';

class PhysicalInfrastructurePage extends StatefulWidget {
  final String surveyId;

  PhysicalInfrastructurePage({Key key, this.surveyId}) : super(key: key);

  @override
  _PhysicalInfrastructurePageState createState() => _PhysicalInfrastructurePageState();
}

class _PhysicalInfrastructurePageState extends State<PhysicalInfrastructurePage> {
  TextEditingController typeComplientscontroller = TextEditingController();
  TextEditingController typeStreetLightcontroller = TextEditingController();
  TextEditingController householdWasteWatercontroller = TextEditingController();
  TextEditingController householdSolidWastecontroller = TextEditingController();

  List qtnCho1 = ["Well", "Hand pump", "Community Tap", "Municipal supply"];
  List qtnCho4 = ["< 1 Hrs.", "1 – 2 Hrs.", "2 – 3 Hrs.", "> 4 Hrs."];
  List qtnCho5 = ["Low", "Average", "Good", "Very Good."];
  List qtnCho7 = ["Quality", "Quantity", "No water", "Other, Specify"];
  List qtnCho8 = ["Within 24 Hrs.", "24 – 48 Hrs.", "More than 48 Hrs."];
  List qtnCho9 = ["Solar", "Private", "State supply connection"];
  List qtnCho10 = ["Metered", "Non-Metered"];
  List qtnCho14 = ["Closed Drainage", "Open Drainage", "No drainage"];
  List qtnCho17Yes = ["Daily", "Alternate Days", "Once in three days", "Once in a week"];
  List qtnCho17 = ["Door to Door Collection", "Open Dumping", "Roadside Bin", "Disposed in Drain", "If Others, Specify"];
  List qtnCho16 = ["On site R.W.H", "Directly to public drains", "Discharged to river / Pond / Nalla"];
  List qtnCho15 = ["Soak Pit", "Municipal Drainage", "Open drained", "If Others, Specify"];
  List qtnCho11 = ["0 Hrs.", "0 – 1 Hrs.", "1 – 2 Hrs.", "2 – 3 Hrs.", "More than 3 Hrs."];
  List qtnCho13 = ["LED", "Solar", "Halogen Bulb", "Other, Specify"];
  List qtnCho3 = ["Daily", "Twice in a day", "Alternate Days", "Once in three day"];
  List qtnChoYesNo = ["Yes", "No"];
  List qtnChoIfYes = ["Working Condition", "NonWorking Condition"];

  String qtnGrpVal1;
  String qtnGrpVal2;
  String qtnGrpVal3;
  String qtnGrpVal4;
  String qtnGrpVal5;
  String qtnGrpVal6;
  String qtnGrpVal8;
  String qtnGrpVal9;
  String qtnGrpVal10;
  String qtnGrpVal11;
  String qtnGrpVal12;
  String qtnGrpVal13;
  String qtnGrpVal14;
  String qtnGrpVal15;
  String qtnGrpVal16;
  String qtnGrpVal17;
  String qtnGrpVal18;
  String qtnGrpVal19;
  String qtnGrpValIfYes;
  String qtnGrpVal17Yes;
  List qtnGrpVal7 = [false, false, false, false];
  PhysicalInfrastructure physicalInfrastructure;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  TextEditingController othersSpcify = TextEditingController();

  String listToString;

  String combine;

  DeviceId deviceResponsePhyInfrastructure;
  bool showOthersQuis = false;
  Future futureData;

  @override
  void initState() {
    setData();
    setState(() {
      checkStatus();
    });
    // futureData = getDataById(widget.surveyId);
    print("Calling initState");
  }

  Future checkStatus() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final String statusOf = _pref.getString('survey_status');
    print(statusOf);
    if (_pref.getString("survey_id") != null) {
      final id = _pref.getString("survey_id");
      print("id====>${id}");
      try {
        final response = await http.get(Uri.parse("http://13.232.140.106:5000/rsi-field-force-api/survey/get-individual-survey-details?survey_id=$id"));
        if (response.statusCode == 200) {
          print("Response===-----${response.body}");
          deviceResponsePhyInfrastructure = DeviceId.fromJson(jsonDecode(response.body));
          print(deviceResponsePhyInfrastructure.data.length);
          print("test");
          print(deviceResponsePhyInfrastructure.data[0].surveyId);
          print(deviceResponsePhyInfrastructure.data[0]);
          print("-----${deviceResponsePhyInfrastructure.data[0].household_status}");
          if (statusOf == "pending_survey") {
            // setvaluesToForm();
          }
        } else {
          throw Exception('Failed to load Data');
        }
      } catch (e) {
        print("error" + e.toString());
      }
    }
  }

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/physicalInfrastructure_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      physicalInfrastructure.question[i].ans = val;
    });
  }

  getAns() {
    print(physicalInfrastructure.question);
    physicalInfrastructure.question.forEach((element) {
      print(element.ans);
    });
  }

  List<bool> userStatus = [false, false, false, false, false, false, false, false, false, false, false, false, false, false];

  var tmpArray = [];
  final String title = 'Physical infrastructure';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureData,
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
                child: CircularProgressIndicator(
              color: Colors.deepOrangeAccent,
              backgroundColor: Colors.blue,
              strokeWidth: 5.0,
            ));
          default:
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else
              //resss = snapshot.data;
              return PhysicalInfrastructurePage1();
        }
      },
    );
  }

  void setData() {
    if (widget.surveyId == null) {
      return;
    }

    qtnGrpVal1 = surveyModel.sourceOfDrinkingWaterPotableWater;
    qtnGrpVal2 = surveyModel.isConnectionAvailableWithinPremises;
    qtnGrpVal3 = surveyModel.frequencyOfMunicipalSupply;
    qtnGrpVal4 = surveyModel.durationOfSupply;
    qtnGrpVal5 = surveyModel.qualityOfWater;
    qtnGrpVal6 = surveyModel.areYouSatisfiedWithTheDrinkingWaterSupply;
    qtnGrpVal7 = enableCheckBoxValue(surveyModel.typeOfComplaints, qtnCho7, qtnGrpVal7);
    qtnGrpVal8 = surveyModel.complaintsRedressedTime;
    qtnGrpVal9 = surveyModel.sourceOfElectricity;
    qtnGrpVal10 = surveyModel.electricityConnection;
    qtnGrpVal11 = surveyModel.powerCutDuration;
    qtnGrpVal12 = surveyModel.availabilityOfStreetLights;
    qtnGrpValIfYes = surveyModel.ifYesConditionOfStreetLight;
    qtnGrpVal13 = surveyModel.typeOfStreetLights;
    qtnGrpVal14 = surveyModel.availabilityOfDrainageLine;
    qtnGrpVal15 = surveyModel.householdWasteWaterOutlet;
    qtnGrpVal16 = surveyModel.whereIsStormOrRainWaterCollected;
    qtnGrpVal17 = surveyModel.whereIsHouseholdSolidWasteDisposedOff;
    qtnGrpVal17Yes = surveyModel.ifDoorToDoorCollection;
    qtnGrpVal18 = surveyModel.isSolidWasteSegregationAtHouseholdLevel;
    qtnGrpVal19 = surveyModel.theBinsProvidedByMunicipality;
  }

  enableCheckBoxValue(
    String value,
    List qtnchoices,
    List qtnChoicesValue,
  ) {
    final lst = value.split(',');
    final a = List.generate(qtnchoices.length, (index) => false);
    for (int i = 0; i < qtnchoices.length; i++) {
      if (lst.contains(qtnchoices[i])) {
        a[i] = true;
      }
    }
    return a;
  }

  getCheckBoxValues(List qtnchoices, List qtnChoicesValue) {
    String cbVal = "";
    for (int i = 0; i < qtnchoices.length; i++) {
      if (qtnChoicesValue[i]) {
        cbVal = cbVal + qtnchoices[i] + ",";
      }
    }
    if (cbVal.endsWith(",")) {
      cbVal = cbVal.substring(0, cbVal.length - 1);
    }
    return cbVal;
  }

/*
  void alertTextField() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Please Fill textfield...!',
        style: TextStyle(fontSize: 15),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Hide',
        textColor: Colors.white,
        onPressed: scaffoldKey.currentState.hideCurrentSnackBar,
      ),
    ));
  }
*/

  Future postMethod() async {
    try {
      // var data = {
      //   "city": city.toString(),
      //   "device_id": deviceId.toString(),
      //   "survey_id": surveyId.toString(),
      //   "question": ques.toString(),
      //   "answer": ans.toString()
      // };
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      final deviceId = _preferences.getString('D_id');
      final surveyId = _preferences.getString('survey_id') ?? '${deviceId.toString()}' + 'S1';
      var data = {
        "survey_id": surveyId,
        "source_of_drinking_water_potable_water": qtnGrpVal1,
        "is_connection_available_within_premises": qtnGrpVal2,
        "frequency_of_municipal_supply": qtnGrpVal3,
        "duration_of_supply": qtnGrpVal4,
        "quality_of_water": qtnGrpVal5,
        "are_you_satisfied_with_the_drinking_water_supply": qtnGrpVal6,
        "type_of_complaints": getCheckBoxValues(qtnCho7, qtnGrpVal7),
        "complaints_redressed_time": qtnGrpVal8,
        "source_of_electricity": qtnGrpVal9,
        "electricity_connection": qtnGrpVal10,
        "power_cut_duration": qtnGrpVal11,
        "availability_of_street_lights": qtnGrpVal12,
        "if_yes_condition_of_street_light": qtnGrpValIfYes,
        "type_of_street_lights": qtnGrpVal13,
        "availability_of_drainage_line": qtnGrpVal14,
        "household_waste_water_outlet": qtnGrpVal15,
        "where_is_storm_or_rain_water_collected": qtnGrpVal16,
        "where_is_household_solid_waste_disposed_off": qtnGrpVal17,
        "if_door_to_door_collection": qtnGrpVal17Yes,
        "is_solid_waste_segregation_at_household_level": qtnGrpVal18,
        "the_bins_provided_by_municipality": qtnGrpVal19,
        "physical_infrastructure_status": "1"
      };
      print("F = ${data['type_of_complaints']}");
      var dataUpdate = {
        //"survey_id": surveyId,
        "source_of_drinking_water_potable_water": qtnGrpVal1,
        "is_connection_available_within_premises": qtnGrpVal2,
        "frequency_of_municipal_supply": qtnGrpVal3,
        "duration_of_supply": qtnGrpVal4,
        "quality_of_water": qtnGrpVal5,
        "are_you_satisfied_with_the_drinking_water_supply": qtnGrpVal6,
        "type_of_complaints": getCheckBoxValues(qtnCho7, qtnGrpVal7),
        "complaints_redressed_time": qtnGrpVal8,
        "source_of_electricity": qtnGrpVal9,
        "electricity_connection": qtnGrpVal10,
        "power_cut_duration": qtnGrpVal11,
        "availability_of_street_lights": qtnGrpVal12,
        "if_yes_condition_of_street_light": qtnGrpValIfYes,
        "type_of_street_lights": qtnGrpVal13,
        "availability_of_drainage_line": qtnGrpVal14,
        "household_waste_water_outlet": qtnGrpVal15,
        "where_is_storm_or_rain_water_collected": qtnGrpVal16,
        "where_is_household_solid_waste_disposed_off": qtnGrpVal17,
        "if_door_to_door_collection": qtnGrpVal17Yes,
        "is_solid_waste_segregation_at_household_level": qtnGrpVal18,
        "the_bins_provided_by_municipality": qtnGrpVal19,
        "physical_infrastructure_status": "1"
      };

      // var response = await http.post(
      //     Uri.parse(
      //         'http://13.232.140.106:5000/rsi-field-force-api/physical-infrastructure'),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: json.encode(data));

      // print(response.body);\

      var response;
      if (deviceResponsePhyInfrastructure.data[0].physical_infrastructure_status == "1" ||
          deviceResponsePhyInfrastructure.data[0].physical_infrastructure_status != null) {
        print("in if");
        print(dataUpdate);
        response = await http.put(Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/physical-infrastructure?survey_id=$surveyId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(dataUpdate));
        print(response.body);
      } else {
        print("in else");
        print(data);
        deviceResponsePhyInfrastructure.data[0].physical_infrastructure_status = "1";
        response = await http.post(Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/physical-infrastructure'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(data));
        print(response.body);
      }

      String id = response.body;
      print("Response====>$id");
    } catch (e) {
      print(e);
    }
  }

  /*void showSnackBar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Some fields are missing...!',
        style: TextStyle(fontSize: 15),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Hide',
        textColor: Colors.white,
        onPressed: scaffoldKey.currentState.hideCurrentSnackBar,
      ),
    ));
  }*/

  Widget PhysicalInfrastructurePage1() {
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
            child: QuestionBody(
          questionBody: Column(
            children: [
              const PageTitleWidget(
                title: PageTitle.physicalInfrastructure,
              ),
              /*------Qusetion1------*/
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.sourceOfDrinking),
                  for (var i = 0; i < qtnCho1.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho1[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho1[i].toString(),
                        groupValue: qtnGrpVal1,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal1 = val.toString();
                            print(qtnGrpVal1);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.isConnectionPremises),
                  for (var i = 0; i < qtnChoYesNo.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnChoYesNo[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnChoYesNo[i].toString(),
                        groupValue: qtnGrpVal2,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal2 = val.toString();
                            print(qtnGrpVal2);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.frequencyMunicipal),
                  for (var i = 0; i < qtnCho3.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho3[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho3[i].toString(),
                        groupValue: qtnGrpVal3,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal3 = val.toString();
                            print(qtnGrpVal3);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.durationSupply),
                  for (var i = 0; i < qtnCho4.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho4[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho4[i].toString(),
                        groupValue: qtnGrpVal4,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal4 = val.toString();
                            print(qtnGrpVal4);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.qualityOfWater),
                  for (var i = 0; i < qtnCho5.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho5[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho5[i].toString(),
                        groupValue: qtnGrpVal5,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal5 = val.toString();
                            print(qtnGrpVal5);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.areYouSatisfied),
                  for (var i = 0; i < qtnChoYesNo.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnChoYesNo[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnChoYesNo[i].toString(),
                        groupValue: qtnGrpVal6,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal6 = val.toString();
                            print(qtnGrpVal6);
                          });
                        }),
                ],
              )),
              //TODO:CheckBoxWithText-----//
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.typeOfComplaints),
                  for (var i = 0; i < qtnCho7.length; i++)
                    CheckboxListTile(
                        activeColor: Colors.deepOrangeAccent,
                        title: Text(
                          qtnCho7[i],
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnGrpVal7[i],
                        onChanged: (value) {
                          setState(() {
                            qtnGrpVal7[i] = value;
                          });
                          print(qtnGrpVal7[i]);
                        }),
                  (qtnGrpVal7[3] && qtnCho7.contains("Other, Specify"))
                      ? TextFieldContainer(
                          controller: typeComplientscontroller,
                          hint: "Enter Text",
                        )
                      : Container(),
                ],
              )),
              //TODO:CheckBox-----//
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.complaintsRedressedTime),
                  for (var i = 0; i < qtnCho8.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho8[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho8[i].toString(),
                        groupValue: qtnGrpVal8,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal8 = val.toString();
                            print(qtnGrpVal8);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.sourceOfElectricity),
                  for (var i = 0; i < qtnCho9.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho9[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho9[i].toString(),
                        groupValue: qtnGrpVal9,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal9 = val.toString();
                            print(qtnGrpVal9);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.electricityConnection),
                  for (var i = 0; i < qtnCho10.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho10[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho10[i].toString(),
                        groupValue: qtnGrpVal10,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal10 = val.toString();
                            print(qtnGrpVal10);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.powerCutDuration),
                  for (var i = 0; i < qtnCho11.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho11[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho11[i].toString(),
                        groupValue: qtnGrpVal11,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal11 = val.toString();
                            print(qtnGrpVal11);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.availabilityOfStreetLights),
                  for (var i = 0; i < qtnChoYesNo.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnChoYesNo[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnChoYesNo[i].toString(),
                        groupValue: qtnGrpVal12,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal12 = val.toString();
                            print(qtnGrpVal12);
                          });
                        }),
                ],
              )),
              qtnGrpVal12 == "Yes"
                  ? QuestionContainer(
                      child: Column(
                      children: [
                        const QuestionName(questionName: PhysicalInfrastructureQuestion.ifYes),
                        for (var i = 0; i < qtnChoIfYes.length; i++)
                          RadioListTile(
                              tileColor: Colors.orangeAccent,
                              selectedTileColor: Colors.orangeAccent,
                              activeColor: Colors.deepOrange,
                              title: Text(
                                qtnChoIfYes[i].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              value: qtnChoIfYes[i].toString(),
                              groupValue: qtnGrpValIfYes,
                              onChanged: (val) {
                                setState(() {
                                  qtnGrpValIfYes = val.toString();
                                  print(qtnGrpValIfYes);
                                });
                              }),
                      ],
                    ))
                  : Container(),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.typeOfStreetLights),
                  for (var i = 0; i < qtnCho13.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho13[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho13[i].toString(),
                        groupValue: qtnGrpVal13,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal13 = val.toString();
                            print(qtnGrpVal13);
                          });
                        }),
                  (qtnGrpVal13 == "Other, Specify")
                      ? TextFieldContainer(
                          controller: typeStreetLightcontroller,
                          hint: "Enter Text",
                        )
                      : Container(),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.availabilityOfDrainageLine),
                  for (var i = 0; i < qtnCho14.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho14[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho14[i].toString(),
                        groupValue: qtnGrpVal14,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal14 = val.toString();
                            print(qtnGrpVal14);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.householdWasteQater),
                  for (var i = 0; i < qtnCho15.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho15[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho15[i].toString(),
                        groupValue: qtnGrpVal15,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal15 = val.toString();
                            print(qtnGrpVal15);
                          });
                        }),
                  (qtnGrpVal15 == "If Others, Specify")
                      ? TextFieldContainer(
                          controller: householdWasteWatercontroller,
                          hint: "EnterText",
                        )
                      : Container(),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.stormRainWaterCollected),
                  for (var i = 0; i < qtnCho16.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho16[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho16[i].toString(),
                        groupValue: qtnGrpVal16,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal16 = val.toString();
                            print(qtnGrpVal16);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.whereisHouseholdSolidWaste),
                  for (var i = 0; i < qtnCho17.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnCho17[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnCho17[i].toString(),
                        groupValue: qtnGrpVal17,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal17 = val.toString();
                            print(qtnGrpVal17);
                          });
                        }),
                  (qtnGrpVal17 == "If Others, Specify")
                      ? TextFieldContainer(
                          controller: householdSolidWastecontroller,
                          hint: "EnterText",
                        )
                      : Container(),
                ],
              )),
              qtnGrpVal17 == "Door to Door Collection"
                  ? QuestionContainer(
                      child: Column(
                      children: [
                        const QuestionName(questionName: PhysicalInfrastructureQuestion.ifDoorToDoorCollection),
                        for (var i = 0; i < qtnCho17Yes.length; i++)
                          RadioListTile(
                              tileColor: Colors.orangeAccent,
                              selectedTileColor: Colors.orangeAccent,
                              activeColor: Colors.deepOrange,
                              title: Text(
                                qtnCho17Yes[i].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              value: qtnCho17Yes[i].toString(),
                              groupValue: qtnGrpVal17Yes,
                              onChanged: (val) {
                                setState(() {
                                  qtnGrpVal17Yes = val.toString();
                                  print(qtnGrpVal17Yes);
                                });
                              }),
                      ],
                    ))
                  : Container(),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.isSolidWasteSegregation),
                  for (var i = 0; i < qtnChoYesNo.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnChoYesNo[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnChoYesNo[i].toString(),
                        groupValue: qtnGrpVal18,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal18 = val.toString();
                            print(qtnGrpVal18);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: PhysicalInfrastructureQuestion.theBinsProvidedByMunicipality),
                  for (var i = 0; i < qtnChoYesNo.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          qtnChoYesNo[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: qtnChoYesNo[i].toString(),
                        groupValue: qtnGrpVal19,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal19 = val.toString();
                            print(qtnGrpVal19);
                          });
                        }),
                ],
              )),

              //------------------------------------------------
              /*submit button*/
              ButtonSaveAndContinue(
                onPress: () async {
                  print("dfghdgfhd");

                  // Navigator.pushNamed(context, "/socialInfrastructure_page");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SocialInfrastructurePage(
                            surveyId: widget.surveyId,
                          )));
                  await postMethod();
                },
              ),
              const SizedBox(
                height: 15,
              ),
              /*Back button*/
              ButtonBack(onPress: () async {
                SharedPreferences _pref = await SharedPreferences.getInstance();
                final String statusOf = _pref.getString('survey_status');
                if (statusOf == "pending_survey") {
                  // Navigator.pushNamed(context, '/transportation_page');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TransportationPage(
                            surveyId: widget.surveyId,
                          )));
                } else {
                  Navigator.pop(context);
                }
              }),
              const SizedBox(
                height: 15,
              ),
              /*Save And Exit button*/
              ButtonSaveAndExit(onPress: () {
                Navigator.pushNamed(context, '/landing_page');
              }),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
