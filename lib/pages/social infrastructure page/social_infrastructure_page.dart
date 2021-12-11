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
import 'package:socio_survey/json%20data/SocialInfrastructure_data.dart';
import 'package:socio_survey/main.dart';
import 'package:socio_survey/models/SocialInfrastructureQuestion.dart';
import 'package:socio_survey/pages/householdprofilepage/household_profile_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:socio_survey/pages/physical%20infrastructure%20page/physical_infrastructure_page.dart';
import 'package:socio_survey/pages/slums%20page/slums_page.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/widgets/contant_widget.dart';
import 'package:socio_survey/widgets/contants_question.dart';

class SocialInfrastructurePage extends StatefulWidget {
  final String surveyId;

  SocialInfrastructurePage({Key key, this.surveyId}) : super(key: key);

  @override
  _SocialInfrastructurePageState createState() => _SocialInfrastructurePageState();
}

class _SocialInfrastructurePageState extends State<SocialInfrastructurePage> {
  SocialInfrastructure socialInfrastructure;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityCheck connectivityCheck = ConnectivityCheck();

  Future futureData;
  DeviceId deviceResponseSocialInfrastructure;

  @override
  void initState() {
    setData();
    setState(() {
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
          deviceResponseSocialInfrastructure = DeviceId.fromJson(jsonDecode(response.body));
          print(deviceResponseSocialInfrastructure.data.length);
          print("test");
          print(deviceResponseSocialInfrastructure.data[0].surveyId);
          print(deviceResponseSocialInfrastructure.data[0]);
          print("-----${deviceResponseSocialInfrastructure.data[0].household_status}");
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
    preferences.setString("page", "/socialInfrastructure_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      socialInfrastructure.question[i].ans = val;
    });
  }

  getAns() {
    print(socialInfrastructure.question);
    socialInfrastructure.question.forEach((element) {
      print(element.ans);
    });
  }

  TextEditingController othersSpcify = TextEditingController();

  String listToString;

  String combine;

  bool showOthersQuis = false;

  List<bool> userStatus = [false, false, false, false, false, false, false, false, false, false, false, false, false, false];

  var tmpArray = [];
  List<bool> userStatus1 = [false, false, false, false, false, false, false, false, false, false, false, false, false, false];

  var tmpArray1 = [];
  List<bool> userStatus2 = [false, false, false, false, false, false, false, false, false, false, false, false, false, false];
  TextEditingController anganwadiDistanceController = TextEditingController();
  TextEditingController primarySchoolDistanceController = TextEditingController();
  TextEditingController collegeDistanceController = TextEditingController();
  TextEditingController higherSecondaryDistanceController = TextEditingController();
  TextEditingController mostPreferredController = TextEditingController();
  TextEditingController suggestionImprovementController1 = TextEditingController();
  TextEditingController pvtHospitalDistanceController = TextEditingController();
  TextEditingController govtHospitalDistanceController = TextEditingController();
  TextEditingController phcAndChcDistanceController = TextEditingController();
  TextEditingController suggestionImprovementController2 = TextEditingController();
  TextEditingController suggestionImprovementController3 = TextEditingController();
  TextEditingController flagShipSchemeController = TextEditingController();
  TextEditingController ifAvailableSchemeController = TextEditingController();
  List question1Choices = ["Government", "Private"];
  List question3Choices = ["Public", "Private", "School Bus", "Other, Specify"];
  List question4Choices = ["Yes", "No"];
  List question6Choices = ["Private", "Government", "Clinic", "PHC / CHC"];
  List question7Choices = ["Yes", "No"];
  List question9Choices = ["Yes", "No"];
  List question10Choices = ["Yes", "No"];
  List question11Choices = ["Once in a week", "Twice in a week", "Alternate days in a week", "Regular"];

  String question1GroupValue;
  String question3GroupValue;
  String question4GroupValue;
  String question6GroupValue;
  String question7GroupValue;
  String question9GroupValue;
  String question10GroupValue;
  String question11GroupValue;

  List question2ChoicesCheckBox = ["Anganwadi", "Primary School", "Higher Secondary", "College"];
  List question7ChoicesCheckBox = ["Pvt. Hospital", "Govt. Hospital", "PHC / CHC"];

  List question14ChoicesCheckBox = [
    "Kanyashree",
    "Rupashree",
    "Nijo Griha Nijo Bhumi",
    "Somobyathi",
    "SaboojSathi",
    "Akanksha",
    "Karmatirtha",
    "Shilpa-Sathi",
    "Others"
  ];
  List question2ChoicesCheckBoxValue = [false, false, false, false];
  List question7ChoicesCheckBoxValue = [false, false, false];
  List question14ChoicesCheckBoxValue = [false, false, false, false, false, false, false, false, false];

  var tmpArray2 = [];
  final String title = 'Social Infrastructure';
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
              return SocialInfrastructurePage1();
        }
      },
    );
  }

  Widget textFileds() {
    return Column(
      children: [
        TextField(
          controller: othersSpcify,
          decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter Distance'),
          onSubmitted: (val) {
            // setState(() {
            //   String onchangeValue = val;
            //   print(onchangeValue);
            //   tmpArray.add(onchangeValue.toString());
            // });

            // transportation.question[i].ans = val;
            // print(transportation.toJson());
          },
        ),
        TextField(
          controller: othersSpcify,
          decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter Distance'),
          onSubmitted: (val) {
            // setState(() {
            //   String onchangeValue = val;
            //   print(onchangeValue);
            //   tmpArray.add(onchangeValue.toString());
            // });

            // transportation.question[i].ans = val;
            // print(transportation.toJson());
          },
        ),
        TextField(
          controller: othersSpcify,
          decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter Distance'),
          onSubmitted: (val) {
            // setState(() {
            //   String onchangeValue = val;
            //   print(onchangeValue);
            //   tmpArray.add(onchangeValue.toString());
            // });

            // transportation.question[i].ans = val;
            // print(transportation.toJson());
          },
        ),
      ],
    );
  }

  /* void alertTextField() {
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

  void setData() {
    if (widget.surveyId == null) {
      return;
    }

    question1GroupValue = surveyModel.whichTypeOfSchoolorEducationInfrastructureDoYouPrefer;
    question2ChoicesCheckBoxValue = enableCheckBoxValue(surveyModel.typeOfEducationAvailabilityAndTheirDistance, question2ChoicesCheckBox, question2ChoicesCheckBoxValue);
    question3GroupValue = surveyModel.mostPreferredMode;
    question4GroupValue = surveyModel.doYouThinkYourRegionHasGoodOpportunitiesInEducation;
    suggestionImprovementController1.text = surveyModel.anyFurtherSuggestionsOrIssuesForImprovementInEducation;
    question6GroupValue = surveyModel.mostPreferredHealthFacility;
    question7ChoicesCheckBoxValue = enableCheckBoxValue(surveyModel.distance, question7ChoicesCheckBox, question7ChoicesCheckBoxValue);
    question7GroupValue = surveyModel.doYouThinkYourRegionHasGoodInHealthFacilities;
    suggestionImprovementController2.text = surveyModel.anySuggestionsForImprovementInHealthFacilities;
    question9GroupValue = surveyModel.availabilityOfParksPlaygroundOrOtherRecreationSpaces;
    question10GroupValue = surveyModel.doYouOrYourFamilyMembersGoToAParkOrPlayground;
    question11GroupValue = surveyModel.ifYesHowRegularYouGoToParkOrPlayground;
    suggestionImprovementController3.text = surveyModel.anyFurtherSuggestionOrIssuesForImprovementInParks;
    question14ChoicesCheckBoxValue = enableCheckBoxValue(surveyModel.doYouReceiveAnyGrantFromAnyStateGovtFlagshipScheme, question14ChoicesCheckBox, question14ChoicesCheckBoxValue);
    ifAvailableSchemeController.text = surveyModel.ifAvailingAnyOtherSchemesPleaseSpecify;
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

  Future postMethod() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    final deviceId = _preferences.getString('D_id');
    final surveyId = _preferences.getString('survey_id') ?? '${deviceId.toString()}' + 'S1';
    try {
      var data = {
        "survey_id": surveyId,
        "which_type_of_schoolor_education_infrastructure_do_you_prefer": question1GroupValue,
        "type_of_education_availability_and_their_distance": getCheckBoxValues(question2ChoicesCheckBox, question2ChoicesCheckBoxValue),
        "most_preferred_mode": question3GroupValue,
        "do_you_think_your_region_has_good_opportunities_in_education": question4GroupValue,
        "any_further_suggestions_or_issues_for_improvement_in_education": suggestionImprovementController1.text,
        "most_preferred_health_facility": question6GroupValue,
        "distance": getCheckBoxValues(question7ChoicesCheckBox, question7ChoicesCheckBoxValue),
        "do_you_think_your_region_has_good_in_health_facilities": question7GroupValue,
        "any_suggestions_for_improvement_in_health_facilities": suggestionImprovementController2.text,
        "availability_of_parks_playground_or_other_recreation_spaces": question9GroupValue,
        "do_you_or_your_family_members_go_to_a_park_or_playground": question10GroupValue,
        "if_yes_how_regular_you_go_to_park_or_playground": question11GroupValue,
        "any_further_suggestion_or_issues_for_improvement_in_parks": suggestionImprovementController3.text,
        "do_you_receive_any_grant_from_any_state_govt_flagship_scheme": getCheckBoxValues(question14ChoicesCheckBox, question14ChoicesCheckBoxValue),
        "if_availing_any_other_schemes_please_specify": ifAvailableSchemeController.text,
        "social_infrastructure_status": "1"
      };
      var dataUpdate = {
        //"survey_id": surveyId,
        "which_type_of_schoolor_education_infrastructure_do_you_prefer": question1GroupValue,
        "type_of_education_availability_and_their_distance": getCheckBoxValues(question2ChoicesCheckBox, question2ChoicesCheckBoxValue),
        "most_preferred_mode": question3GroupValue,
        "do_you_think_your_region_has_good_opportunities_in_education": question4GroupValue,
        "any_further_suggestions_or_issues_for_improvement_in_education": suggestionImprovementController1.text,
        "most_preferred_health_facility": question6GroupValue,
        "distance": getCheckBoxValues(question7ChoicesCheckBox, question7ChoicesCheckBoxValue),
        "do_you_think_your_region_has_good_in_health_facilities": question7GroupValue,
        "any_suggestions_for_improvement_in_health_facilities": suggestionImprovementController2.text,
        "availability_of_parks_playground_or_other_recreation_spaces": question9GroupValue,
        "do_you_or_your_family_members_go_to_a_park_or_playground": question10GroupValue,
        "if_yes_how_regular_you_go_to_park_or_playground": question11GroupValue,
        "any_further_suggestion_or_issues_for_improvement_in_parks": suggestionImprovementController3.text,
        "do_you_receive_any_grant_from_any_state_govt_flagship_scheme": getCheckBoxValues(question14ChoicesCheckBox, question14ChoicesCheckBoxValue),
        "if_availing_any_other_schemes_please_specify": ifAvailableSchemeController.text,
        "social_infrastructure_status": "1"
      };

      // var response = await http.post(
      //     Uri.parse(
      //         'http://13.232.140.106:5000/rsi-field-force-api/social-infrastructure'),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: json.encode(data));

      // print(response.body);

      var response;
      if (deviceResponseSocialInfrastructure.data[0].social_infrastructure_status == "1" ||
          deviceResponseSocialInfrastructure.data[0].social_infrastructure_status != null) {
        print("in if");
        print(dataUpdate);
        response = await http.put(Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/social-infrastructure?survey_id=$surveyId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(dataUpdate));
        print(response.body);
      } else {
        print("in else");
        print(data);
        deviceResponseSocialInfrastructure.data[0].social_infrastructure_status = "1";
        response = await http.post(Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/social-infrastructure'),
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

  Widget SocialInfrastructurePage1() {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
            child: QuestionBody(
          questionBody: Column(
            children: [
              const PageTitleWidget(title: PageTitle.socialInfrastructure),
              /*------Qusetion1------*/
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.whichTypeOfSchoolEducation),
                  for (var i = 0; i < question1Choices.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          question1Choices[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: question1Choices[i].toString(),
                        groupValue: question1GroupValue,
                        onChanged: (val) {
                          setState(() {
                            question1GroupValue = val.toString();
                            print(question1GroupValue);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.typeOfEducationAvailability),
                  for (var i = 0; i < question2ChoicesCheckBox.length; i++)
                    CheckboxListTile(
                        activeColor: Colors.deepOrangeAccent,
                        title: Text(question2ChoicesCheckBox[i],
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            )),
                        value: question2ChoicesCheckBoxValue[i],
                        onChanged: (value) {
                          setState(() {
                            question2ChoicesCheckBoxValue[i] = value;
                          });
                          print(question2ChoicesCheckBox[i]);
                        }),
                  (question2ChoicesCheckBoxValue[0] && question2ChoicesCheckBox.contains("Anganwadi"))
                      ? TextFieldContainer(controller: anganwadiDistanceController, hint: "Enter Anganwadi Distance", inputType: TextInputType.number)
                      : Container(),
                  (question2ChoicesCheckBoxValue[1] && question2ChoicesCheckBox.contains("Primary School"))
                      ? TextFieldContainer(controller: primarySchoolDistanceController, hint: "Enter Primary School Distance", inputType: TextInputType.number)
                      : Container(),
                  (question2ChoicesCheckBoxValue[2] && question2ChoicesCheckBox.contains("Higher Secondary"))
                      ? TextFieldContainer(
                          controller: higherSecondaryDistanceController, hint: "Enter Higher Secondary Distance", inputType: TextInputType.number)
                      : Container(),
                  (question2ChoicesCheckBoxValue[3] && question2ChoicesCheckBox.contains("College"))
                      ? TextFieldContainer(controller: collegeDistanceController, hint: "Enter College Distance", inputType: TextInputType.number)
                      : Container(),
                ],
              )),
              /*------Qusetion3------*/
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.mostPreferredMode),
                  for (var i = 0; i < question3Choices.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          question3Choices[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: question3Choices[i].toString(),
                        groupValue: question3GroupValue,
                        onChanged: (val) {
                          setState(() {
                            question3GroupValue = val.toString();
                            print(question3GroupValue);
                          });
                        }),
                  if (question3GroupValue == "Other, Specify")
                    TextFieldContainer(
                      controller: mostPreferredController,
                      hint: "Enter Text",
                    )
                ],
              )),
              /*------Qusetion4------*/
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.doYouThinkThatYourRegion),
                  for (var i = 0; i < question4Choices.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          question4Choices[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: question4Choices[i].toString(),
                        groupValue: question4GroupValue,
                        onChanged: (val) {
                          setState(() {
                            question4GroupValue = val.toString();
                            print(question4GroupValue);
                          });
                        }),
                ],
              )),
              /*------Qusetion5------*/
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.anyFurtherSuggestions),
                  TextFieldContainer(
                    controller: suggestionImprovementController1,
                    hint: "Enter Text",
                  )
                ],
              )),
              /*------Qusetion6------*/
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.mostPreferredHealthFacility),
                  for (var i = 0; i < question6Choices.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          question6Choices[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: question6Choices[i].toString(),
                        groupValue: question6GroupValue,
                        onChanged: (val) {
                          setState(() {
                            question6GroupValue = val.toString();
                            print(question6GroupValue);
                          });
                        }),
                ],
              )),
              /*------------------------------*/
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.distance),
                  for (var i = 0; i < question7ChoicesCheckBox.length; i++)
                    CheckboxListTile(
                        activeColor: Colors.deepOrangeAccent,
                        title: Text(question7ChoicesCheckBox[i],
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            )),
                        value: question7ChoicesCheckBoxValue[i],
                        onChanged: (value) {
                          setState(() {
                            question7ChoicesCheckBoxValue[i] = value;
                          });
                          print(question7ChoicesCheckBox[i]);
                        }),
                  (question7ChoicesCheckBoxValue[0] && question7ChoicesCheckBox.contains("Pvt. Hospital"))
                      ? TextFieldContainer(
                          controller: pvtHospitalDistanceController,
                          hint: "Enter Pvt. Hospital Distance",
                          inputType: TextInputType.number,
                        )
                      : Container(),
                  (question7ChoicesCheckBoxValue[1] && question7ChoicesCheckBox.contains("Govt. Hospital"))
                      ? TextFieldContainer(
                          controller: govtHospitalDistanceController,
                          hint: "Enter Govt. Hospital Distance",
                          inputType: TextInputType.number,
                        )
                      : Container(),
                  (question7ChoicesCheckBoxValue[2] && question7ChoicesCheckBox.contains("PHC / CHC"))
                      ? TextFieldContainer(
                          controller: phcAndChcDistanceController,
                          hint: "Enter PHC/CHC Distance",
                          inputType: TextInputType.number,
                        )
                      : Container(),
                ],
              )),
              ////////////////////////
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.goodOpportunitiesHealthFacilities),
                  for (var i = 0; i < question7Choices.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          question7Choices[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: question7Choices[i].toString(),
                        groupValue: question7GroupValue,
                        onChanged: (val) {
                          setState(() {
                            question7GroupValue = val.toString();
                            print(question7GroupValue);
                          });
                        }),
                ],
              )),
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.anySuggestionsForImprovement),
                  TextFieldContainer(
                    controller: suggestionImprovementController2,
                    hint: "Enter Text",
                  )
                ],
              )),
              ////////////////////
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.availabilityOfParksPlayground),
                  for (var i = 0; i < question9Choices.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          question9Choices[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: question9Choices[i].toString(),
                        groupValue: question9GroupValue,
                        onChanged: (val) {
                          setState(() {
                            question9GroupValue = val.toString();
                            print(question9GroupValue);
                          });
                        }),
                ],
              )),
              ////////////////////
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.doYouOrYourFamilyMembers),
                  for (var i = 0; i < question10Choices.length; i++)
                    RadioListTile(
                        tileColor: Colors.orangeAccent,
                        selectedTileColor: Colors.orangeAccent,
                        activeColor: Colors.deepOrange,
                        title: Text(
                          question10Choices[i].toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: question10Choices[i].toString(),
                        groupValue: question10GroupValue,
                        onChanged: (val) {
                          setState(() {
                            question10GroupValue = val.toString();
                            print(question10GroupValue);
                          });
                        }),
                ],
              )),
              if (question10GroupValue == "Yes")
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: SocialInfrastructureQuestion.ifYesHowRegular),
                    for (var i = 0; i < question11Choices.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            question11Choices[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: question11Choices[i].toString(),
                          groupValue: question11GroupValue,
                          onChanged: (val) {
                            setState(() {
                              question11GroupValue = val.toString();
                              print(question11GroupValue);
                            });
                          }),
                  ],
                )),
              ////
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.anyFurtherImprovement),
                  TextFieldContainer(
                    controller: suggestionImprovementController3,
                    hint: "Enter Text",
                  )
                ],
              )),

              QuestionContainer(
                  child: Column(
                children: [
                  QuestionName(questionName: SocialInfrastructureQuestion.receiceAnyGrantAnyState),
                  for (var i = 0; i < question14ChoicesCheckBox.length; i++)
                    CheckboxListTile(
                        activeColor: Colors.deepOrangeAccent,
                        title: Text(
                          question14ChoicesCheckBox[i],
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                          ),
                        ),
                        value: question14ChoicesCheckBoxValue[i],
                        onChanged: (value) {
                          setState(() {
                            question14ChoicesCheckBoxValue[i] = value;
                          });
                          print(question14ChoicesCheckBox[i]);
                        }),
                  (question14ChoicesCheckBoxValue[8] && question14ChoicesCheckBox.contains("Others"))
                      ? TextFieldContainer(
                          controller: flagShipSchemeController,
                          hint: "Enter Text",
                        )
                      : Container(),
                ],
              )),
              ////
              QuestionContainer(
                  child: Column(
                children: [
                  const QuestionName(questionName: SocialInfrastructureQuestion.ifAvailingAnyOtherShemesPleaseSpecify),
                  TextFieldContainer(
                    controller: ifAvailableSchemeController,
                    hint: "Enter Text",
                  )
                ],
              )),
              //------------------------------------------------
              /*submit button*/
              ButtonSaveAndContinue(
                onPress: () async {
                  await postMethod();
                  // Navigator.pushNamed(context, "/skip_page");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SkipPage(surveyId: widget.surveyId,)));
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
                  // Navigator.pushNamed(context, '/physicalInfrastructure_page');
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhysicalInfrastructurePage(surveyId: widget.surveyId,)));
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

// sendSocialData() async {
//   try {
//     var response = await http.post(
//         Uri.parse(
//             'http://192.168.12.69:3000/socio-economic-survey-api/user/social-infrastructure'),
//         body: {
//           "type_of_school_infrastructure_do_you_prefer":
//               socialInfrastructure.question[0].ans,
//           "type_of_education_availability_distance":
//               socialInfrastructure.question[1].ans,
//           "most_preferred_mode": socialInfrastructure.question[2].ans,
//           "your_region_has_good_opportunities_in_education_facilities":
//               socialInfrastructure.question[3].ans,
//           "suggestion_for_educational_improvement":
//               socialInfrastructure.question[4].ans,
//           "most_preferred_health_facility":
//               socialInfrastructure.question[5].ans,
//           "health_distance": socialInfrastructure.question[6].ans,
//           "your_region_has_good_opportunities_in_health_facilities":
//               socialInfrastructure.question[7].ans,
//           "suggestion_for_health_facilities_improvement":
//               socialInfrastructure.question[8].ans,
//           "availablility_of_parks_playground_other_recreation_spaces":
//               socialInfrastructure.question[9].ans,
//           "your_family_members_go_to_park_playground":
//               socialInfrastructure.question[10].ans,
//           "how_regular": socialInfrastructure.question[11].ans,
//           "suggestion_for_recreation_space_improvement":
//               socialInfrastructure.question[12].ans,
//           "grant_from_any_state_government_flagship_scheme":
//               socialInfrastructure.question[13].ans,
//           "other_schemes": socialInfrastructure.question[14].ans,
//         });
//     print(response);
//   } catch (e) {
//     print(e);
//   }
// }
}
