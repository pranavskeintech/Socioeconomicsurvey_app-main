import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:socio_survey/components/skip_page.dart';
import 'package:socio_survey/dbHelper/dbHelper.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/components/textfield_container.dart';
import 'package:socio_survey/json%20data/coastal_data.dart';
import 'package:socio_survey/main.dart';
import 'package:socio_survey/models/CoastalQuestion.dart';
import 'package:socio_survey/pages/environmental%20related%20page/environmental_related_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/widgets/contant_widget.dart';
import 'package:socio_survey/widgets/contants_question.dart';

var colorTemp = false;

class CoastalPage extends StatefulWidget {
  final surveyId;

  CoastalPage({Key key, this.surveyId}) : super(key: key);

  @override
  _CoastalPageState createState() => _CoastalPageState();
}

class _CoastalPageState extends State<CoastalPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  Coastal coastal;
  Future futureData;
  DeviceId deviceResponseCoastal;

  @override
  void initState() {
    setData();
    var json = costalData;
    coastal = Coastal.fromJson(json);
    setState(() {
      connectivityCheck.startMonitoring();
      page();
      print(coastal?.toJson());
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
          deviceResponseCoastal = DeviceId.fromJson(jsonDecode(response.body));
          print(deviceResponseCoastal.data.length);
          print("test");
          print(deviceResponseCoastal.data[0].surveyId);
          print(deviceResponseCoastal.data[0]);
          print("-----${deviceResponseCoastal.data[0].household_status}");
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
    preferences.setString("page", "/coastal_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      coastal.question[i].ans = val;
    });
  }

  getAns() {
    print(coastal.question);
    coastal.question.forEach((element) {
      print(element.ans);
    });
  }

  bool _isLoading = false;
  final String title = 'Coastal';
  TextEditingController purposeBoatController = TextEditingController();
  TextEditingController ifYesSpecifySellerController = TextEditingController();
  TextEditingController activitesApartFromFishingController = TextEditingController();
  TextEditingController informationRelatedThreatsController = TextEditingController();
  TextEditingController majorDemageController = TextEditingController();
  TextEditingController anyFurtherSuggestionController = TextEditingController();

  List q1Cho = ["Yes", "No"];
  String q1V;
  List q2Cho = ["Fishing", "Passenger Movement", "Goods Movement", "If other, Specify"];
  String q2V;
  List q3Cho = ["Yes", "No"];
  String q3V;
  List q5Cho = ["Yes", "No"];
  String q5V;

  List q7Cho = ["Risk", "Opportunity"];
  String q7V;
  List q8Cho = ["Newspaper", "TV", "Radio", "Local Administration Announcement", "NGO", "If other, Specify"];
  String q8V;
  List q9Cho = ["Home", "Govt.disaster shelter"];
  String q9V;
  List q10Cho = [">10", "10-30", "<30"];
  String q10V;
  List q11Cho = ["Roads", "Electric Poles", "Mobile Towers", "Life stocks", "Houses", "If Others, Specify"];
  String q11V;
  List q12Cho = ["Self stock", "Govt aided supply"];
  String q12V;
  List q13Cho = ["Yes", "No"];
  String q13V;
  List q14Cho = ["Yes", "No"];
  String q14V;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureData, // async work
      builder: (BuildContext context, snapshot) {
        return FutureBuilder(
          future: futureData, // async work
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading....');
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return CoastalWidget();
            }
          },
        );
      },
    );
  }

  void setData() {
    if (widget.surveyId) {
      return;
    }
    q1V = surveyModel.doYouHaveBoats;
    q2V = surveyModel.ifYesThePurposeOfUsingBoats;

    q3V = surveyModel.areYouAssociatedWithFishingRelatedActivities;

    ifYesSpecifySellerController.text = surveyModel.ifYesThenSpecifyAsSellerCatcherSupplierOrOther;

    q5V = surveyModel.haveYouBeenEngagedInOtherActivitiesApartFromFishing;
    activitesApartFromFishingController.text = surveyModel.ifYesSpecifyTheActivities;

    q7V = surveyModel.doYouThinkLivingInCoastalRegionIsThreatOrOpportunity;
    q8V = surveyModel.howDoYouGetTheInformationRelatedToNaturalThreats;
    q9V = surveyModel.safePlaceDuringNaturalEvents;
    q10V = surveyModel.afterNaturalDisasterHowManyDaysTakeComeToNormal;
    q11V = surveyModel.majorDamagesDuringNaturalCalamities;
    q12V = surveyModel.availabilityOfRationDuringTheNaturalDisaster;
    q13V = surveyModel.whetherAnyFundAreaGrantedForTheFloodProneArea;
    q14V = surveyModel.doesThisRegionHaveAnyTourismOpportunities;
    anyFurtherSuggestionController.text = surveyModel.anyFurtherSuggestionsOrIssuesInCoastalRegion;
  }

  Future postMethod() async {
    print("post method called");
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    final deviceId = _preferences.getString('D_id');
    final surveyId = _preferences.getString('survey_id') ?? '${deviceId.toString()}' + 'S1';
    try {
      var data = {
        "survey_id": surveyId,
        "do_you_have_boats": q1V,
        "if_yes_the_purpose_of_using_boats": q2V,
        "are_you_associated_with_fishing_related_activities": q3V,
        "if_yes_then_specify_as_seller_catcher_supplier_or_other": ifYesSpecifySellerController.text,
        "have_you_been_engaged_in_other_activities_apart_from_fishing": q5V,
        "if_yes_specify_the_activities": activitesApartFromFishingController.text,
        "do_you_think_living_in_coastal_region_is_threat_or_opportunity": q7V,
        "how_do_you_get_the_information_related_to_natural_threats": q8V,
        "safe_place_during_natural_events": q9V,
        "after_natural_disaster_how_many_days_take_come_to_normal": q10V,
        "major_damages_during_natural_calamities": q11V,
        "availability_of_ration_during_the_natural_disaster": q12V,
        "whether_any_fund_area_granted_for_the_flood_prone_area": q13V,
        "does_this_region_have_any_tourism_opportunities": q14V,
        "any_further_suggestions_or_issues_in_coastal_region": anyFurtherSuggestionController.text,
        "coastal_status": "1"
      };
      var dataUpdate = {
        //"survey_id": surveyId,
        "do_you_have_boats": q1V,
        "if_yes_the_purpose_of_using_boats": q2V,
        "are_you_associated_with_fishing_related_activities": q3V,
        "if_yes_then_specify_as_seller_catcher_supplier_or_other": ifYesSpecifySellerController.text,
        "have_you_been_engaged_in_other_activities_apart_from_fishing": q5V,
        "if_yes_specify_the_activities": activitesApartFromFishingController.text,
        "do_you_think_living_in_coastal_region_is_threat_or_opportunity": q7V,
        "how_do_you_get_the_information_related_to_natural_threats": q8V,
        "safe_place_during_natural_events": q9V,
        "after_natural_disaster_how_many_days_take_come_to_normal": q10V,
        "major_damages_during_natural_calamities": q11V,
        "availability_of_ration_during_the_natural_disaster": q12V,
        "whether_any_fund_area_granted_for_the_flood_prone_area": q13V,
        "does_this_region_have_any_tourism_opportunities": q14V,
        "any_further_suggestions_or_issues_in_coastal_region": anyFurtherSuggestionController.text,
        "coastal_status": "1"
      };
      // var response = await http.post(
      //     Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/coastal'),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: json.encode(data));
      print("Print check");
      var response;
      if (deviceResponseCoastal.data[0].coastal_status == "1" || deviceResponseCoastal.data[0].coastal_status != null) {
        print("in if");
        print(dataUpdate);
        print(json.encode(data));
        response = await http.put(Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/coastal?survey_id=$surveyId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(dataUpdate));
        print(response.body);
      } else {
        print("in else");
        print(data);
        deviceResponseCoastal.data[0].coastal_status = "1";
        response = await http.post(Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/coastal'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(data));
        print(response.body);
      }

      // print(response.body);
      String id = response.body;
      print("Response====>$id");
    } catch (e) {
      print(e);
    }
  }

  /* void showSnackBar() {
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

  Widget CoastalWidget() {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: QuestionBody(
            questionBody: Column(
              children: [
                const PageTitleWidget(
                  title: PageTitle.coastal,
                ),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: CoastalQuestion.doYouHaveBoats),
                    for (var i = 0; i < q1Cho.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q1Cho[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q1Cho[i].toString(),
                          groupValue: q1V,
                          onChanged: (val) {
                            setState(() {
                              q1V = val.toString();
                              print(q1V);
                            });
                          }),
                  ],
                )),
                if (q1V == "Yes")
                  QuestionContainer(
                      child: Column(
                    children: [
                      const QuestionName(questionName: CoastalQuestion.ifYesPurposeUseBoats),
                      for (var i = 0; i < q2Cho.length; i++)
                        RadioListTile(
                            tileColor: Colors.orangeAccent,
                            selectedTileColor: Colors.orangeAccent,
                            activeColor: Colors.deepOrange,
                            title: Text(
                              q2Cho[i].toString(),
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                              ),
                            ),
                            value: q2Cho[i].toString(),
                            groupValue: q2V,
                            onChanged: (val) {
                              setState(() {
                                q2V = val.toString();
                                print(q2V);
                              });
                            }),
                      if (q2V == "If other, Specify")
                        TextFieldContainer(
                          controller: purposeBoatController,
                          hint: "Enter Text",
                        )
                    ],
                  )),

                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: CoastalQuestion.areYouAssociatedFishing),
                    for (var i = 0; i < q3Cho.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q3Cho[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q3Cho[i].toString(),
                          groupValue: q3V,
                          onChanged: (val) {
                            setState(() {
                              q3V = val.toString();
                              print(q3V);
                            });
                          }),
                  ],
                )),
                if (q3V == "Yes")
                  QuestionContainer(
                      child: Column(
                    children: [
                      const QuestionName(questionName: CoastalQuestion.ifYesSpecifySellerOrOther),
                      TextFieldContainer(
                        controller: ifYesSpecifySellerController,
                        hint: "Enter Text",
                      )
                    ],
                  )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: CoastalQuestion.haveBeenEngaged),
                    for (var i = 0; i < q5Cho.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q5Cho[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q5Cho[i].toString(),
                          groupValue: q5V,
                          onChanged: (val) {
                            setState(() {
                              q5V = val.toString();
                              print(q5V);
                            });
                          }),
                  ],
                )),
                if (q5V == "Yes")
                  QuestionContainer(
                      child: Column(
                    children: [
                      const QuestionName(questionName: CoastalQuestion.ifYesSpecify),
                      TextFieldContainer(
                        controller: activitesApartFromFishingController,
                        hint: "Enter Text",
                      )
                    ],
                  )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: CoastalQuestion.doYouThinkLivingCoastal),
                    for (var i = 0; i < q7Cho.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q7Cho[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q7Cho[i].toString(),
                          groupValue: q7V,
                          onChanged: (val) {
                            setState(() {
                              q7V = val.toString();
                              print(q7V);
                            });
                          }),
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: CoastalQuestion.howDoYouGetInformation),
                    for (var i = 0; i < q8Cho.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q8Cho[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q8Cho[i].toString(),
                          groupValue: q8V,
                          onChanged: (val) {
                            setState(() {
                              q8V = val.toString();
                              print(q8V);
                            });
                          }),
                    if (q8V == "If other, Specify")
                      TextFieldContainer(
                        controller: informationRelatedThreatsController,
                        hint: "Enter Text",
                      )
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: CoastalQuestion.safePlaceNaturalEvents),
                    for (var i = 0; i < q9Cho.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q9Cho[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q9Cho[i].toString(),
                          groupValue: q9V,
                          onChanged: (val) {
                            setState(() {
                              q9V = val.toString();
                              print(q9V);
                            });
                          }),
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: CoastalQuestion.afterNaturalDisaster),
                    for (var i = 0; i < q10Cho.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q10Cho[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q10Cho[i].toString(),
                          groupValue: q10V,
                          onChanged: (val) {
                            setState(() {
                              q10V = val.toString();
                              print(q10V);
                            });
                          }),
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: CoastalQuestion.majorDamagesCalamities),
                    for (var i = 0; i < q11Cho.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q11Cho[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q11Cho[i].toString(),
                          groupValue: q11V,
                          onChanged: (val) {
                            setState(() {
                              q11V = val.toString();
                              print(q11V);
                            });
                          }),
                    if (q11V == "If Others, Specify")
                      TextFieldContainer(
                        controller: majorDemageController,
                        hint: "Enter Text",
                      )
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: CoastalQuestion.availabilityRationDisaster),
                    for (var i = 0; i < q12Cho.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q12Cho[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q12Cho[i].toString(),
                          groupValue: q12V,
                          onChanged: (val) {
                            setState(() {
                              q12V = val.toString();
                              print(q12V);
                            });
                          }),
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: CoastalQuestion.whetherFundAreaGranted),
                    for (var i = 0; i < q13Cho.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q13Cho[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q13Cho[i].toString(),
                          groupValue: q13V,
                          onChanged: (val) {
                            setState(() {
                              q13V = val.toString();
                              print(q13V);
                            });
                          }),
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: CoastalQuestion.doesThisRegionOpportunities),
                    for (var i = 0; i < q14Cho.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q14Cho[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q14Cho[i].toString(),
                          groupValue: q14V,
                          onChanged: (val) {
                            setState(() {
                              q14V = val.toString();
                              print(q14V);
                            });
                          }),
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: CoastalQuestion.anyFurtherSuggestions),
                    TextFieldContainer(
                      controller: anyFurtherSuggestionController,
                      hint: "Enter Text",
                    )
                  ],
                )),
                //------------------------------------------------
                /*submit button*/
                ButtonSaveAndContinue(
                  onPress: () async {
                    // Navigator.pushNamed(context, "/environmentalRelated_page");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EnvironmentalRelatedPage(surveyId: widget.surveyId,)));
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
                    // Navigator.pushNamed(context, '/skip_page');
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SkipPage(surveyId: widget.surveyId,)));
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
          ),
        ),
      ),
    );
  }

// sendCoastalData() async {
//   try {
//     var response = await http.post(
//         Uri.parse(
//             'http://192.168.12.69:3000/socio-economic-survey-api/user/coastal'),
//         body: {
//           "do_you_have_boats": coastal.question[0].ans,
//           "purpose_of_using_boatss": coastal.question[1].ans,
//           "are_you_associated_with_fishing_related_activities":
//               coastal.question[2].ans,
//           "role_in_fishing_related_activities": coastal.question[3].ans,
//           "have_you_been_engaged_in_other_activities_apart_from_fishing":
//               coastal.question[4].ans,
//           "other_activities_apart_from_fishing": coastal.question[5].ans,
//           "think_living_in_a_coastal_region_is_a_threat_an_opportunity":
//               coastal.question[6].ans,
//           "how_do_you_get_the_information_related_to_natural_threats":
//               coastal.question[7].ans,
//           "safe_place_during_natural_events": coastal.question[8].ans,
//           "after_disaster_how_many_days_it_take_to_come_to_normal":
//               coastal.question[9].ans,
//           "major_damages_during_natural_calamities": coastal.question[10].ans,
//           "availability_of_ration_during_the_natural_disaster":
//               coastal.question[11].ans,
//           "whether_any_fund_area_granted_for_the_flood_prone_area":
//               coastal.question[12].ans,
//           "does_this_region_have_any_tourism_opportunities":
//               coastal.question[13].ans,
//           "any_further_suggestion_issues": coastal.question[14].ans,
//         });
//     print(response);
//   } catch (e) {
//     print(e);
//   }
// }
}
