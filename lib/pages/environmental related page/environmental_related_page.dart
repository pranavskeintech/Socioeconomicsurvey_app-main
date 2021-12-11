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
import 'package:socio_survey/json%20data/environmentalRelated_data.dart';
import 'package:socio_survey/main.dart';
import 'package:socio_survey/models/EnvironmentalQuestion.dart';
import 'package:socio_survey/pages/Coastal%20Page/coastal_page.dart';
import 'package:socio_survey/pages/cultural%20and%20heritage%20page/cultural_and_heritage.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/pages/slums%20page/slums_page.dart';
import 'package:socio_survey/widgets/contant_widget.dart';
import 'package:socio_survey/widgets/contants_question.dart';

class EnvironmentalRelatedPage extends StatefulWidget {
  EnvironmentalRelatedPage({Key key, this.data, this.surveyId}) : super(key: key);
  final String data;
  final String surveyId;

  @override
  _EnvironmentalRelatedPageState createState() => _EnvironmentalRelatedPageState();
}

class _EnvironmentalRelatedPageState extends State<EnvironmentalRelatedPage> {
  EnvironmentalRelated environmentalRelated;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();

  Future futureData;
  DeviceId deviceResponseEnvironment;

  @override
  void initState() {
    setData();
    var json = environmentalData;
    environmentalRelated = EnvironmentalRelated.fromJson(json);
    setState(() {
      connectivityCheck.startMonitoring();
      page();
      print(environmentalRelated?.toJson());
      futureData = checkStatus();
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
          deviceResponseEnvironment = DeviceId.fromJson(jsonDecode(response.body));
          print(deviceResponseEnvironment.data.length);
          print("test");
          print(deviceResponseEnvironment.data[0].surveyId);
          print(deviceResponseEnvironment.data[0]);
          print("-----${deviceResponseEnvironment.data[0].household_status}");
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
    preferences.setString("page", "/environmentalRelated_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      environmentalRelated.question[i].ans = val;
    });
  }

  getAns() {
    print(environmentalRelated.question);
    environmentalRelated.question.forEach((element) {
      print(element.ans);
    });
  }

  bool _isLoading = false;
  final String title = 'Environment Related page';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController whichDisesSpecifycontroller = TextEditingController();
  TextEditingController majorCousePollutioncontroller = TextEditingController();
  TextEditingController doYouFaceIssueRainycontroller = TextEditingController();
  TextEditingController doesTrafficMovementController = TextEditingController();
  TextEditingController anyFurtherSuggestionController = TextEditingController();
  TextEditingController anyFurtherSuggestionImprovementController = TextEditingController();
  List qtnCho3 = ["Transportation", "Industries", "Mining", "If Other, Specify"];
  List qtnChoIfYes = ["Within 3 Days", "Within a Week", "7 – 15 Days", "More than 2 weeks"];
  List qtnChoYesNo = ["Yes", "No"];

  String qtnGrpVal1;
  String qtnGrpVal2;
  String qtnGrpValGover;
  String qtnGrpVal3;
  String qtnGrpVal4;
  String qtnGrpVal5;
  String qtnGrpVal6;
  String qtnGrpVal8;
  String qtnGrpVal7;
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
  String qtnGrpValSchool;

  @override
  Widget build(BuildContext context) {
    print("data----> ${widget.data}");
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
              return EnvironmentalWidget();
        }
      },
    );
  }

  void setData() {
    if (widget.surveyId == null) {
      return;
    }

    qtnGrpVal1 = surveyModel.familyOrNearbyPersonSufferedFromDiseasesInLastFewYears;
    whichDisesSpecifycontroller.text = surveyModel.ifYesWhichDiseasesSpecify;
    qtnGrpVal2 = surveyModel.doYouOrFamilyMemberFaceAnyProblemInBreathing;
    qtnGrpVal3 = surveyModel.majorCauseOfPollution;
    qtnGrpVal4 = surveyModel.doYouFaceAnyIssuesDuringTheRainySeason;

    doYouFaceIssueRainycontroller.text = surveyModel.ifYesSpecifyIssuesFacedInRainySeason;
    qtnGrpVal5 = surveyModel.whetherTheAreaIsProneToFloodingDueToRains;
    qtnGrpValIfYes = surveyModel.ifYesHowManyDaysItTakesToNormalCondition;
    qtnGrpVal6 = surveyModel.duringFloodingIsRehabilitationCentresAvailable;
    qtnGrpVal7 = surveyModel.whetherAnyFundsGrantedToYouForSuchDisaster;
    qtnGrpVal8 = surveyModel.doHoardingsCreateAnyVisualDisturbanceWhileDriving;

    qtnGrpVal9 = surveyModel.doesTrafficMovementAndNoiseAnIssueForYourLocality;

    anyFurtherSuggestionController.text = surveyModel.ifYesSuggestionForImprovementInTrafficIssue;

    qtnGrpVal10 = surveyModel.whetherTheWasteDisposedOffInANearbyRiverOrWaterBody;
    anyFurtherSuggestionImprovementController.text = surveyModel.anyFurtherSuggestionForImprovementInEnvironment;
  }

  Future postMethod() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    final deviceId = _preferences.getString('D_id');
    final surveyId = _preferences.getString('survey_id') ?? '${deviceId.toString()}' + 'S1';
    try {
      var data = {
        "survey_id": surveyId,
        "family_or_nearby_person_suffered_from_diseases_in_last_few_years": qtnGrpVal1,
        "if_yes_which_diseases_specify": whichDisesSpecifycontroller.text,
        "do_you_or_family_member_face_any_problem_in_breathing": qtnGrpVal2,
        "major_cause_of_pollution": qtnGrpVal3,
        "do_you_face_any_issues_during_the_rainy_season": qtnGrpVal4,
        "if_yes_specify_issues_faced_in_rainy_season": doYouFaceIssueRainycontroller.text,
        "whether_the_area_is_prone_to_flooding_due_to_rains": qtnGrpVal5,
        "if_yes_how_many_days_it_takes_to_normal_condition": qtnGrpValIfYes,
        "during_flooding_is_rehabilitation_centres_available": qtnGrpVal6,
        "whether_any_funds_granted_to_you_for_such_disaster": qtnGrpVal7,
        "do_hoardings_create_any_visual_disturbance_while_driving": qtnGrpVal8,
        "does_traffic_movement_and_noise_an_issue_for_your_locality": qtnGrpVal9,
        "if_yes_suggestion_for_improvement_in_traffic_issue": anyFurtherSuggestionController.text,
        "whether_the_waste_disposed_off_in_a_nearby_river_or_water_body": qtnGrpVal10,
        "any_further_suggestion_for_improvement_in_environment": anyFurtherSuggestionImprovementController.text,
        "environmental_related_status": "1"
      };
      var dataUpdate = {
        // "survey_id": surveyId,
        "family_or_nearby_person_suffered_from_diseases_in_last_few_years": qtnGrpVal1,
        "if_yes_which_diseases_specify": whichDisesSpecifycontroller.text,
        "do_you_or_family_member_face_any_problem_in_breathing": qtnGrpVal2,
        "major_cause_of_pollution": qtnGrpVal3,
        "do_you_face_any_issues_during_the_rainy_season": qtnGrpVal4,
        "if_yes_specify_issues_faced_in_rainy_season": doYouFaceIssueRainycontroller.text,
        "whether_the_area_is_prone_to_flooding_due_to_rains": qtnGrpVal5,
        "if_yes_how_many_days_it_takes_to_normal_condition": qtnGrpValIfYes,
        "during_flooding_is_rehabilitation_centres_available": qtnGrpVal6,
        "whether_any_funds_granted_to_you_for_such_disaster": qtnGrpVal7,
        "do_hoardings_create_any_visual_disturbance_while_driving": qtnGrpVal8,
        "does_traffic_movement_and_noise_an_issue_for_your_locality": qtnGrpVal9,
        "if_yes_suggestion_for_improvement_in_traffic_issue": anyFurtherSuggestionController.text,
        "whether_the_waste_disposed_off_in_a_nearby_river_or_water_body": qtnGrpVal10,
        "any_further_suggestion_for_improvement_in_environment": anyFurtherSuggestionImprovementController.text,
        "environmental_related_status": "1"
      };

      // var response = await http.post(
      //     Uri.parse(
      //         'http://13.232.140.106:5000/rsi-field-force-api/environmental-related'),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: json.encode(data));

      // print(response.body);

      var response;
      if (deviceResponseEnvironment.data[0].environmental_related_status == "1" || deviceResponseEnvironment.data[0].environmental_related_status != null) {
        print("in if");
        print(dataUpdate);
        response = await http.put(Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/environmental-related?survey_id=$surveyId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(dataUpdate));
        print(response.body);
      } else {
        print("in else");
        print(data);
        deviceResponseEnvironment.data[0].environmental_related_status = "1";
        response = await http.post(Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/environmental-related'),
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
        'Some Fields are Missing...!',
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

  Widget EnvironmentalWidget() {
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
              const PageTitleWidget(title: PageTitle.environmentalRelated),
              /*------Qusetion1------*/
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: EnvironmentalQuestion.doesFamilyOrPerson),
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
                        groupValue: qtnGrpVal1,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal1 = val.toString();
                            print(qtnGrpVal1);
                          });
                        }),
                ],
              )),
              qtnGrpVal1 == "Yes"
                  ? QuestionContainer(
                      child: Column(
                      children: [
                        const QuestionName(questionName: EnvironmentalQuestion.ifYesWhichDiseases),
                        TextFieldContainer(
                          controller: whichDisesSpecifycontroller,
                          hint: "Enter Text",
                        )
                      ],
                    ))
                  : Container(),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: EnvironmentalQuestion.doYouFamilyMemberProblemBrething),
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
                  const QuestionName(questionName: EnvironmentalQuestion.majorCausePollution),
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
                  (qtnGrpVal3 == "If Other, Specify") ? TextFieldContainer(controller: majorCousePollutioncontroller, hint: "Enter Text") : Container(),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: EnvironmentalQuestion.doYouFaceIssuesDuringRainy),
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
                        groupValue: qtnGrpVal4,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal4 = val.toString();
                            print(qtnGrpVal4);
                          });
                        }),
                ],
              )),
              qtnGrpVal4 == "Yes"
                  ? QuestionContainer(
                      child: Column(
                      children: [
                        const QuestionName(questionName: EnvironmentalQuestion.ifYesSpecify),
                        TextFieldContainer(
                          controller: doYouFaceIssueRainycontroller,
                          hint: "Enter Text",
                        )
                      ],
                    ))
                  : Container(),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: EnvironmentalQuestion.whetherTheAreProne),
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
                        groupValue: qtnGrpVal5,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal5 = val.toString();
                            print(qtnGrpVal5);
                          });
                        }),
                ],
              )),
              qtnGrpVal5 == "Yes"
                  ? QuestionContainer(
                      child: Column(
                      children: [
                        const QuestionName(questionName: EnvironmentalQuestion.ifYesHowManyDaysNormal),
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
                  const QuestionName(questionName: EnvironmentalQuestion.duringFlooding),
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
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: EnvironmentalQuestion.whetherAnyFunds),
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
                        groupValue: qtnGrpVal7,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal7 = val.toString();
                            print(qtnGrpVal7);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: EnvironmentalQuestion.doHoardings),
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
                  const QuestionName(questionName: EnvironmentalQuestion.doesTrafficMovement),
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
                        groupValue: qtnGrpVal9,
                        onChanged: (val) {
                          setState(() {
                            qtnGrpVal9 = val.toString();
                            print(qtnGrpVal9);
                          });
                        }),
                ],
              )),
              qtnGrpVal9 == "Yes"
                  ? QuestionContainer(
                      child: Column(
                      children: [
                        const QuestionName(questionName: EnvironmentalQuestion.ifAnySuggestionImprovement),
                        TextFieldContainer(controller: anyFurtherSuggestionController, hint: "Enter Text"),
                      ],
                    ))
                  : Container(),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: EnvironmentalQuestion.whetherWasteDisposed),
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
                  QuestionName(questionName: EnvironmentalQuestion.anyFurtherSuggestionImprovment),
                  TextFieldContainer(
                    controller: anyFurtherSuggestionImprovementController,
                    hint: "Enter Text",
                  ),
                ],
              )),

//------------------------------------------------
/*submit button*/
              ButtonSaveAndContinue(
                onPress: () {
                  // Navigator.pushNamed(context, "/culturalAndHeritage");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CulturalAndHeritage(surveyId: widget.surveyId,)));
                  postMethod();
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
                  if (widget.data == "hi") {
                    // Navigator.pushNamed(context, '/slums_page');
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SlumsPage(surveyId: widget.surveyId,)));
                  } else {
                    // Navigator.pushNamed(context, '/coastal_page');
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CoastalPage(surveyId: widget.surveyId,)));
                  }
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

// sendEnvironmentData() async {
//   try {
//     var response = await http.post(
//         Uri.parse(
//             'http://192.168.12.69:3000/socio-economic-survey-api/user/environment-related'),
//         body: {
//           "family_nearby_person_suffer_from_diseases_in_last_few_years":
//               environmentalRelated.question[0].ans,
//           "diseases": environmentalRelated.question[1].ans,
//           "family_member_face_any_problem_in_breathing":
//               environmentalRelated.question[2].ans,
//           "major_cause_of_pollution": environmentalRelated.question[3].ans,
//           "face_any_issues_during_rainy_season":
//               environmentalRelated.question[4].ans,
//           "issues_in_rainy_season": environmentalRelated.question[5].ans,
//           "whether_the_area_is_prone_to_flooding_due_to_rains":
//               environmentalRelated.question[6].ans,
//           "how_many_days_it_takes_to_normal_condition":
//               environmentalRelated.question[7].ans,
//           "during_flooding_is_rehabilitation_center_available":
//               environmentalRelated.question[8].ans,
//           "whether_any_funds_granted_to_you_for_such_disaster":
//               environmentalRelated.question[9].ans,
//           "do_hoardings_create_any_visual_disturbance_while_driving":
//               environmentalRelated.question[10].ans,
//           "does_traffic_movement_noise_an_issue_for_your_locality":
//               environmentalRelated.question[11].ans,
//           "suggestion_for_improvement_in_reduction_of_traffic_noise":
//               environmentalRelated.question[12].ans,
//           "whether_the_waste_disposed_off_in_nearby_river":
//               environmentalRelated.question[13].ans,
//           "suggesstion_for_improvement_in_waste_disposed_off_issue":
//               environmentalRelated.question[14].ans
//         });
//     print(response);
//   } catch (e) {
//     print(e);
//   }
// }
}
