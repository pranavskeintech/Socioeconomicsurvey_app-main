import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:socio_survey/dbHelper/dbHelper.dart';
import 'package:socio_survey/json%20data/household_data.dart';
import 'package:socio_survey/models/HouseHoldQuestion.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/widgets/contant_widget.dart';
import 'package:socio_survey/widgets/contants_question.dart';
var isDataAvailble = false;
DeviceId deviceResponse;

//final scaffoldKey = GlobalKey<ScaffoldState>();

TextEditingController migratedController = TextEditingController();
TextEditingController willingToMigrateController = TextEditingController();
TextEditingController ifNoNotGoingBackController = TextEditingController();
List question1Choices = ["Yes", "No"];
List question2Choices = [
  "> 5 Years",
  "5 to 10 Years",
  "10 to 25 Years",
  "25 to 50 Years",
  "< 50 Years"
];
List question3Choices1 = ["Within State", "Outside State"];
List question3Choices2 = ["Seasonal", "Permanent"];
List question3Choices3 = [
  "Education",
  "Employment",
  "Living Condition",
  "Accessibility",
  "If Other, Specify"
];
List question4Choices = [
  "Yes",
  "No",
  "Maybe",
  "If yes or maybe Place / Location"
];
List question5Choices = [
  "Earning Money",
  "Habituated",
  "Education",
  "If Other, Specify"
];
List question6Choices = ["Yes", "No"];
String question1GroupValue;
String question2GroupValue;
String question3GroupValue1;
String question3GroupValue2;
String question3GroupValue3;
String question4GroupValue;
String question5GroupValue;
String question6GroupValue;

DbHelper _dbHelper = DbHelper.instance;

bool _isOnline;
int curUserId = 1;
var dbHelper;

HouseHold quesList = HouseHold();
int value;
bool _isLoading = false;
Dio _dio = Dio();
bool visiblity = false;
bool visiblity1 = false;

ConnectivityCheck connectivityCheck = ConnectivityCheck();
class HouseHoldPofilePage extends StatefulWidget {

  final String surveyId;
  HouseHoldPofilePage({Key key, this.surveyId}) : super(key: key);

  @override
  _HouseHoldPofilePageState createState() => _HouseHoldPofilePageState();
}

class _HouseHoldPofilePageState extends State<HouseHoldPofilePage> {
  Future futureData;

  @override
  void initState() {
    setState(() {
      question1GroupValue = "";
      question2GroupValue = "";
      question3GroupValue1 = "";
      question3GroupValue2 = "";
      question3GroupValue3 = "";
      question4GroupValue = "";
      question5GroupValue = "";
      question6GroupValue = "";

      futureData =  checkStatus();
    });
    print("Calling initState");
  }

  Future checkStatus() async
  {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final String statusOf = _pref.getString('survey_status');
    print(statusOf);
      if (_pref.getString("survey_id") != null) {
        final id = _pref.getString("survey_id");
        print("id====>${id}");
        try {
          final response = await http.get(Uri.parse(
              "http://13.232.140.106:5000/rsi-field-force-api/survey/get-individual-survey-details?survey_id=$id"));
          if (response.statusCode == 200) {
            print("Response===-----${response.body}");
            deviceResponse = DeviceId.fromJson(jsonDecode(response.body));
            print(deviceResponse.data.length);
            print("test");
            print(deviceResponse.data[0].surveyId);
            print(deviceResponse.data[0]);
            print("-----${deviceResponse.data[0].household_status}");
            print(statusOf);
            if (statusOf == "pending_survey") {
               setvaluesToForm();
            }
          } else {
            throw Exception('Failed to load Data');
          }
        } catch (e) {
          print("error" + e.toString());
        }
      }

  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureData,
      builder:(BuildContext context, snapshot) {
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
              return HouseHoldPofilePage1();
        }
      },
    );
  }



  Widget HouseHoldPofilePage1() {
    return Scaffold(
    //  key: scaffoldKey,
      body: SingleChildScrollView(
        child: QuestionBody(
          questionBody: Column(
            children: [
              const PageTitleWidget(
                title: PageTitle.household,
              ),
              /*------Qusetion1------*/
              QuestionContainer(
                child: Column(
                  children: [
                    const QuestionName(
                      questionName: HouseHoldQuestion.migrated,
                    ),
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
                ),
              ),
              (question1GroupValue == "Yes")
                  ? QuestionContainer(
                  child: Column(
                    children: [
                      const QuestionName(
                        questionName: HouseHoldQuestion.ifYesNoYears,
                      ),
                      for (var i = 0; i < question2Choices.length; i++)
                        RadioListTile(
                            tileColor: Colors.orangeAccent,
                            selectedTileColor: Colors.orangeAccent,
                            activeColor: Colors.deepOrange,
                            title: Text(
                              question2Choices[i].toString(),
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                              ),
                            ),
                            value: question2Choices[i].toString(),
                            groupValue: question2GroupValue,
                            onChanged: (val) {
                              setState(() {
                                question2GroupValue = val.toString();
                                print(question2GroupValue);
                              });
                            }),
                    ],
                  ))
                  : Container(),
              (question1GroupValue == "Yes")
                  ? QuestionContainer(
                  child: Column(
                    children: [
                      const QuestionName(
                        questionName: HouseHoldQuestion.ifMigrated,
                      ),
                      /*sub1 */
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const QuestionName(
                          questionName: HouseHoldQuestion.placeOfOrgin,
                        ),
                      ),
                      for (var i = 0; i < question3Choices1.length; i++)
                        RadioListTile(
                            tileColor: Colors.orangeAccent,
                            selectedTileColor: Colors.orangeAccent,
                            activeColor: Colors.deepOrange,
                            title: Text(
                              question3Choices1[i].toString(),
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                              ),
                            ),
                            value: question3Choices1[i].toString(),
                            groupValue: question3GroupValue1,
                            onChanged: (val) {
                              setState(() {
                                question3GroupValue1 = val.toString();
                                print(question3GroupValue1);
                              });
                            }),
                      //sub2
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const QuestionName(
                          questionName: HouseHoldQuestion.migrationType,
                        ),
                      ),
                      for (var i = 0; i < question3Choices2.length; i++)
                        RadioListTile(
                            tileColor: Colors.orangeAccent,
                            selectedTileColor: Colors.orangeAccent,
                            activeColor: Colors.deepOrange,
                            title: Text(
                              question3Choices2[i].toString(),
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                              ),
                            ),
                            value: question3Choices2[i].toString(),
                            groupValue: question3GroupValue2,
                            onChanged: (val) {
                              setState(() {
                                question3GroupValue2 = val.toString();
                                print(question3GroupValue2);
                              });
                            }),
                      //sub2

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const QuestionName(
                          questionName: HouseHoldQuestion.reasonOfMigration,
                        ),
                      ),
                      for (var i = 0; i < question3Choices3.length; i++)
                        RadioListTile(
                            tileColor: Colors.orangeAccent,
                            selectedTileColor: Colors.orangeAccent,
                            activeColor: Colors.deepOrange,
                            title: Text(
                              question3Choices3[i].toString(),
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                              ),
                            ),
                            value: question3Choices3[i].toString(),
                            groupValue: question3GroupValue3,
                            onChanged: (val) {
                              setState(() {
                                question3GroupValue3 = val.toString();
                                print(question3GroupValue3);
                              });
                            }),
                      (question3GroupValue3 == "If Other, Specify")
                          ? TextFieldContainer(
                        controller: migratedController,
                        hint: "Enter Text",
                        onChange: (val) {
                          question3GroupValue3 =
                              migratedController.text;
                        },
                      )
                          : Container(),
                    ],
                  ))
                  : Container(),
              QuestionContainer(
                  child: Column(
                    children: [
                      const QuestionName(
                        questionName: HouseHoldQuestion.areWillingToAnother,
                      ),
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
                      (question4GroupValue == "If yes or maybe Place / Location")
                          ? TextFieldContainer(
                        controller: willingToMigrateController,
                        hint: "Enter Text",
                        onChange: (val) {
                          question3GroupValue3 =
                              willingToMigrateController.text;
                        },
                      )
                          : Container(),
                    ],
                  )),
              (question4GroupValue == "No")
                  ? QuestionContainer(
                  child: Column(
                    children: [
                      const QuestionName(
                        questionName: HouseHoldQuestion.ifNoReasonNotBack,
                      ),
                      for (var i = 0; i < question5Choices.length; i++)
                        RadioListTile(
                            tileColor: Colors.orangeAccent,
                            selectedTileColor: Colors.orangeAccent,
                            activeColor: Colors.deepOrange,
                            title: Text(
                              question5Choices[i].toString(),
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                              ),
                            ),
                            value: question5Choices[i].toString(),
                            groupValue: question5GroupValue,
                            onChanged: (val) {
                              setState(() {
                                question5GroupValue = val.toString();
                                print(question5GroupValue);
                              });
                            }),
                      if (question5GroupValue == "If Other, Specify")
                        TextFieldContainer(
                          controller: ifNoNotGoingBackController,
                          hint: "Enter Text",
                          onChange: (val) {
                            question5GroupValue =
                                ifNoNotGoingBackController.text;
                          },
                        )
                    ],
                  ))
                  : Container(),

              /*------Qusetion6------*/

              /*------Qusetion6------*/
              QuestionContainer(
                  child: Column(
                    children: [
                      const QuestionName(
                        questionName: HouseHoldQuestion.afterTheCovidSituation,
                      ),
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

              /*submit button*/
              ButtonSaveAndContinue(
                onPress: () async {
                  await postMethod();
                  Navigator.pushNamed(context, "/housing_page");
                },
              ),
              const SizedBox(
                height: 15,
              ),
              /*Back button*/
              ButtonBack(onPress: () {

                Navigator.pushNamed(context, '/user_details');
                print("====>$question1GroupValue");
              }),
              const SizedBox(
                height: 15,
              ),
              /*Save And Exit button*/
              ButtonSaveAndExit(onPress: () {
                Navigator.pushNamed(context, '/landing_page');
                print("====>$question1GroupValue");
              }),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future postMethod() async {
    try {
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      final deviceId = _preferences.getString('D_id');
      final surveyId = _preferences.getString('survey_id');
      // SharedPreferences _pref = await SharedPreferences.getInstance();
      // _pref.setString('survey_status',"pending");
      print("question1GroupValue");

      print(question1GroupValue);
      var data = {
        "survey_id": surveyId,
        "migrated": question1GroupValue,
        "if_yes_no_of_years": question2GroupValue,
        "place_of_origin": question3GroupValue1,
        "migration_type": question3GroupValue2,
        "reason_of_migration": question3GroupValue3,
        "are_you_willing_to_migrate_to_another_place": question4GroupValue,
        "if_no_reasons_for_not_going_back_to_the_native_place":
        question5GroupValue,
        "after_covid19_situation_you_go_back_to_your_native_place":
        question6GroupValue,
        "household_status": "1"
      };
      var dataUpdate = {
       // "survey_id": surveyId,
        "migrated": question1GroupValue,
        "if_yes_no_of_years": question2GroupValue,
        "place_of_origin": question3GroupValue1,
        "migration_type": question3GroupValue2,
        "reason_of_migration": question3GroupValue3,
        "are_you_willing_to_migrate_to_another_place": question4GroupValue,
        "if_no_reasons_for_not_going_back_to_the_native_place":
        question5GroupValue,
        "after_covid19_situation_you_go_back_to_your_native_place":
        question6GroupValue,
        "household_status": "1"
      };


      print("-----${deviceResponse.data[0].household_status}");

      var response;
      if (deviceResponse.data[0].household_status == "1" || deviceResponse.data[0].household_status != "null") {
        print("in if");
        response = await http.put(
            Uri.parse(
                'http://13.232.140.106:5000/rsi-field-force-api/household?survey_id=$surveyId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(dataUpdate));
      } else {
        print("in else");
        deviceResponse.data[0].household_status = "1";
        response = await http.post(
            Uri.parse(
                'http://13.232.140.106:5000/rsi-field-force-api/household'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(data));
      }
      String id = response.body;
      print("Response====>$id");
    } catch (e) {
      print(e);
    }
  }

  /*void showSnackBar() {
    scaffoldKey1.currentState.showSnackBar(SnackBar(
      content: Text(
        'Some Fields Are Missing',
        style: TextStyle(fontSize: 15),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Hide',
        textColor: Colors.white,
        onPressed: scaffoldKey2.currentState.hideCurrentSnackBar,
      ),
    ));
  }*/

  void setvaluesToForm() {

    print(
        "============================");
    print("============>${deviceResponse}<==================");


    /*1.Migrated*/
    if (deviceResponse.data[0].migrated != null ) {
      question1GroupValue = deviceResponse.data[0].migrated;
    }
    /*If yes no of years*/
    if (deviceResponse.data[0].if_yes_no_of_years != null) {
      question2GroupValue = deviceResponse.data[0].if_yes_no_of_years;
    }
    // if (deviceResponse.data[0].if_yes_no_of_years != null &&
    //     deviceResponse.data[0].if_yes_no_of_years == "> 5 Year") {
    //   question2GroupValue = "> 5 Year";
    //   // setSelectedRadio("> 5 Year", 1);
    // } else if (deviceResponse.data[0].if_yes_no_of_years != null &&
    //     deviceResponse.data[0].if_yes_no_of_years == "5 to 10 Years") {
    //   question2GroupValue = "5 to 10 Years";
    //   // setSelectedRadio("5 to 10 Years", 1);
    // } else if (deviceResponse.data[0].if_yes_no_of_years != null &&
    //     deviceResponse.data[0].if_yes_no_of_years == "10 to 25 Years") {
    //   question2GroupValue = "10 to 25 Years";
    //   //setSelectedRadio("10 to 25 Years", 1);
    // } else if (deviceResponse.data[0].if_yes_no_of_years != null &&
    //     deviceResponse.data[0].if_yes_no_of_years == "25 to 50 Years") {
    //   question2GroupValue = "25 to 50 Years";
    //   // setSelectedRadio("25 to 50 Years", 1);
    // } else if (deviceResponse.data[0].if_yes  _no_of_years != null &&
    //     deviceResponse.data[0].if_yes_no_of_years == "< 50 Years") {
    //   question2GroupValue = "< 50 Years";
    //   // setSelectedRadio("< 50 Years", 1);
    // }
    /*Place of origin*/
    if (deviceResponse.data[0].place_of_origin != null &&
        deviceResponse.data[0].place_of_origin == "Within State") {
      question3GroupValue1 = "Within State";
    } else if (deviceResponse.data[0].place_of_origin != null &&
        deviceResponse.data[0].place_of_origin == "Outside State") {
      question3GroupValue1 = "Outside State";
    }
    /*Migration type*/
    if (deviceResponse.data[0].migration_type != null &&
        deviceResponse.data[0].migration_type == "Seasonal") {
      question3GroupValue2 = "Seasonal";
    } else if (deviceResponse.data[0].migration_type != null &&
        deviceResponse.data[0].migration_type == "Permanent") {
      question3GroupValue2 = "Permanent";
    }

    /*Reason of migration*/
    if (deviceResponse.data[0].reason_of_migration != null &&
        deviceResponse.data[0].reason_of_migration == "Education") {
      question3GroupValue3 = "Education";
    } else if (deviceResponse.data[0].reason_of_migration != null &&
        deviceResponse.data[0].reason_of_migration == "Employment") {
      question3GroupValue3 = "Employment";
    } else if (deviceResponse.data[0].reason_of_migration != null &&
        deviceResponse.data[0].reason_of_migration == "Living Condition") {
      question3GroupValue3 = "Living Condition";
    } else if (deviceResponse.data[0].reason_of_migration != null &&
        deviceResponse.data[0].reason_of_migration == "Accessibility") {
      question3GroupValue3 = "Accessibility";
    } else if (deviceResponse.data[0].reason_of_migration != null) {
      question3GroupValue3 = "If Other, Specify";
      migratedController.text = deviceResponse.data[0].reason_of_migration;
    }

    /*2.are_you_willing_to_migrate_to_another_place*/
    if (deviceResponse.data[0].are_you_willing_to_migrate_to_another_place !=
        null) {
      question4GroupValue =
          deviceResponse.data[0].are_you_willing_to_migrate_to_another_place;
    }
    if (deviceResponse.data[0].are_you_willing_to_migrate_to_another_place !=
        null &&
        deviceResponse.data[0].are_you_willing_to_migrate_to_another_place ==
            "No") {
      question4GroupValue = "No";
    } else if (deviceResponse.data[0].are_you_willing_to_migrate_to_another_place !=
        null &&
        deviceResponse.data[0].are_you_willing_to_migrate_to_another_place ==
            "Yes") {
      question4GroupValue = "Yes";
    } else if (deviceResponse.data[0].are_you_willing_to_migrate_to_another_place !=
        null &&
        deviceResponse.data[0].are_you_willing_to_migrate_to_another_place ==
            "Maybe") {
      question4GroupValue = "Maybe";
    } else if (deviceResponse.data[0].are_you_willing_to_migrate_to_another_place !=
        null &&
        deviceResponse.data[0].are_you_willing_to_migrate_to_another_place ==
            "If yes or maybe Place / Location") {
      question4GroupValue = "If yes or maybe Place / Location";
      willingToMigrateController.text =
          deviceResponse.data[0].are_you_willing_to_migrate_to_another_place;
    }
    /*after_covid19_situation_you_go_back_to_your_native_place*/
    if (deviceResponse.data[0]
        .if_no_reasons_for_not_going_back_to_the_native_place !=
        null &&
        deviceResponse.data[0]
            .if_no_reasons_for_not_going_back_to_the_native_place ==
            "Earning Money") {
      question5GroupValue = "Earning Money";
    } else if (deviceResponse.data[0]
        .if_no_reasons_for_not_going_back_to_the_native_place !=
        null &&
        deviceResponse.data[0]
            .if_no_reasons_for_not_going_back_to_the_native_place ==
            "Habituated") {
      question5GroupValue = "Habituated";
    } else if (deviceResponse.data[0]
        .if_no_reasons_for_not_going_back_to_the_native_place !=
        null &&
        deviceResponse.data[0]
            .if_no_reasons_for_not_going_back_to_the_native_place ==
            "Education") {
      question5GroupValue = "Education";
    } else if (deviceResponse.data[0]
        .if_no_reasons_for_not_going_back_to_the_native_place !=
        null &&
        deviceResponse.data[0]
            .if_no_reasons_for_not_going_back_to_the_native_place ==
            "If other, Specify") {
      question5GroupValue = "If other, Specify";
      ifNoNotGoingBackController.text = deviceResponse.data[0]
          .if_no_reasons_for_not_going_back_to_the_native_place;
    }
    /*7.after_covid19_situation_you_go_back_to_your_native_place*/
    if (deviceResponse.data[0]
        .after_covid19_situation_you_go_back_to_your_native_place !=
        null &&
        deviceResponse.data[0]
            .after_covid19_situation_you_go_back_to_your_native_place ==
            "No") {
      question6GroupValue = "No";
    } else if (deviceResponse.data[0]
        .after_covid19_situation_you_go_back_to_your_native_place !=
        null &&
        deviceResponse.data[0]
            .after_covid19_situation_you_go_back_to_your_native_place ==
            "Yes") {
      question6GroupValue = "Yes";
    }
    setState(() {
      connectivityCheck.startMonitoring();
      page();
    });
  }
  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/household_profile");
  }


}


