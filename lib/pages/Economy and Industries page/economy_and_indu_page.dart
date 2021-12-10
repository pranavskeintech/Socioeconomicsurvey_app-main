import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:socio_survey/dbHelper/dbHelper.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/components/textfield_container.dart';
import 'package:socio_survey/json%20data/economy_data.dart';
import 'package:socio_survey/models/EconomyQuestions.dart';
import 'package:socio_survey/pages/Transportation%20page/transportation_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';

import 'package:http/http.dart' as http;
import 'package:socio_survey/widgets/contant_widget.dart';
import 'package:socio_survey/widgets/contants_question.dart';

var isDataAvailble = false;
DeviceId deviceResponseEconomy;


class EconomyAndIndustriesPage extends StatefulWidget {
  final String surveyId;
  EconomyAndIndustriesPage({Key key, this.surveyId}) : super(key: key);

  @override
  _EconomyAndIndustriesPageState createState() =>
      _EconomyAndIndustriesPageState();
}

class _EconomyAndIndustriesPageState extends State<EconomyAndIndustriesPage> {


  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController typeEmploymentController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController occupationControllerAnother = TextEditingController();
  TextEditingController whichTypeIndustryCompanyController =
      TextEditingController();
  TextEditingController suggestionJobController = TextEditingController();
  TextEditingController familyMemberPensionController = TextEditingController();
  TextEditingController typeEmploymentControllerAnother =
      TextEditingController();
  TextEditingController ifYesSpecifyWhich = TextEditingController();

  TextEditingController controllerx = TextEditingController();
  List question1Choices = ["Private", "Government", "If Others,Specify"];
  List questionANotherEmployee = ["Private", "Government", "If Others,Specify"];
  List question2Choices = [
    "Wage Labour",
    "Skilled Labour",
    "Shopkeeper / Business man",
    "Self Employed",
    "Government",
    "Private",
    "Retired",
    "Unemployed",
    "Construction worker",
    "Industrial worker",
    "Fulltime",
    "If Others, Specify"
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
    "If other, Specify"
  ];
  List question6Choices = ["Yes", "No"];
  List questionAnotherFamily = ["Yes", "No"];
  List questionChoicesConstruction = [
    "Daily Wedged",
    "Weekly Wedged",
    "Engaged with Contractor"
  ];
  List questionChoicesIndustrial = [
    "Small Scale",
    "Medium Scale",
    "Large Scale"
  ];
  List questionChoicesJobOpportunity = ["Increase", "Decrease"];
  List questionChoicesAfterJobOpportunity = [
    "Increased",
    "Decreased",
    "No Changes"
  ];
  List questionChoicesShopping = ["Online shopping", "Offline Shopping"];
  List questionChoicesOnlineShopping = [
    "Once in a week",
    "Twice in a week",
    "Once in a month",
    "Very rare"
  ];
  List questionChoicesVisitMarket = [
    "Once in a week",
    "Twice in a week",
    "Once in a month",
    "Very often"
  ];
  List questionChoicesMonthlyExp = [
    "Upto Rs 10,000",
    "Rs 10,000 Rs 20,000",
    "Rs 20,000 and Above"
  ];
  String question1GroupValue;
  String question2GroupValue;
  String question3GroupValue1;
  String question3GroupValue2;
  String question3GroupValue3;
  String question4GroupValue;
  String question5GroupValue;
  String question6GroupValue;
  String questionGroupValueConstruction;
  String questionGroupValueIndustrial;
  String questionGrpAnotherFamily;
  String questionGrpAnotherEmployee;
  String questionGrpAnotherEmployeeOcc;
  String questionGroupValueConstructionFamilyMember;
  String questionGroupValueIndustrialFamilyMember;
  String questionGroupValueFamilyMember;
  String questionGroupValueJobOpportunity;
  String questionGroupValueMonthlyExp;
  String questionGroupValueAfterJobOpportunity;
  String questionGroupValueBeforeShopping;
  String questionGroupValueAfterShopping;
  String questionGroupValueOnlineShopping;
  String questionGroupValueIndustrialSectorAffected;
  String questionGroupValueReceivePension;
  String questionGroupValueVisitMarket;
  String questionGroupValueAfterVisitMarket;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  bool _isLoading = false;
  Economy economy;
  //Future<List<EconomyDb>> _economyList;
  Future futureData;

  @override
  void initState() {
    setState(() {
      futureData = checkStatus();
    });
    // futureData = getDataById(widget.surveyId);
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
          deviceResponseEconomy = DeviceId.fromJson(jsonDecode(response.body));
          print(deviceResponseEconomy.data.length);
          print("test");
          print(deviceResponseEconomy.data[0].surveyId);
          print(deviceResponseEconomy.data[0]);
          print("-----${deviceResponseEconomy.data[0].household_status}");
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
    preferences.setString("page", "/economyAndIndustries_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      economy.question[i].ans = val;
    });
  }

  getAns() {
    print(economy.question);
    economy.question.forEach((element) {
      print(element.ans);
    });
  }


  List ans = [];
  final String title = 'Economy and Industries';
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
            return EconomyAndIndustriesPage1();
        }
      },
    );

  }

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
      final surveyId = _preferences.getString('survey_id') ??
          '${deviceId.toString()}' + 'S1';
      var data = {
        "survey_id": surveyId,
        "type_of_employment_engagement": question1GroupValue,
        "occupation": question2GroupValue,
        "if_construction_worker": questionGroupValueConstruction,
        "if_industrial_worker_in_which_industry_do_you_work":
            questionGroupValueIndustrial,
        "if_there_is_another_family_member_who_is_employed":
            questionGrpAnotherFamily,
        "type_of_employment_engagement_another_family_member":
            questionGrpAnotherEmployee,
        "occupation_another_family_member": questionGrpAnotherEmployeeOcc,
        "if_construction_worker_another_family_member":
            questionGroupValueConstructionFamilyMember,
        "if_industrial_worker_another_family_member":
            questionGroupValueIndustrialFamilyMember,
        "is_any_of_the_family_members_working_as_part_time_employees":
            questionGroupValueFamilyMember,
        "if_yes_which_type_of_industry_company_Office":
            whichTypeIndustryCompanyController.text,
        "after_covid19_impact_on_job_opportunity_Availability":
            questionGroupValueJobOpportunity,
        "does_the_industrial_sector_been_affected_after_covid19":
            questionGroupValueIndustrialSectorAffected,
        "suggestions_for_how_job_opportunities_can_be_made_available":
            suggestionJobController.text,
        "does_any_family_member_receive_a_pension":
            questionGroupValueReceivePension,
        "if_yes_specify_which": ifYesSpecifyWhich.text,
        "what_is_your_monthly_expenditure": questionGroupValueMonthlyExp,
        "impact_on_monthly_expenditure_after_covid19":
            questionGroupValueAfterJobOpportunity,
        "how_often_you_visit_the_market_before_covid19":
            questionGroupValueVisitMarket,
        "how_often_you_visit_the_market_after_covid19":
            questionGroupValueAfterVisitMarket,
        "most_preferred_way_of_shopping_after_covid19":
            questionGroupValueAfterShopping,
        "most_preferred_way_of_shopping_before_covid19":
            questionGroupValueBeforeShopping,
        "how_often_do_you_do_online_shopping": questionGroupValueOnlineShopping,
        "economy_status":"1"


      };
      var dataupdate = {
        //"survey_id": surveyId,
        "type_of_employment_engagement": question1GroupValue,
        "occupation": question2GroupValue,
        "if_construction_worker": questionGroupValueConstruction,
        "if_industrial_worker_in_which_industry_do_you_work":
        questionGroupValueIndustrial,
        "if_there_is_another_family_member_who_is_employed":
        questionGrpAnotherFamily,
        "type_of_employment_engagement_another_family_member":
        questionGrpAnotherEmployee,
        "occupation_another_family_member": questionGrpAnotherEmployeeOcc,
        "if_construction_worker_another_family_member":
        questionGroupValueConstructionFamilyMember,
        "if_industrial_worker_another_family_member":
        questionGroupValueIndustrialFamilyMember,
        "is_any_of_the_family_members_working_as_part_time_employees":
        questionGroupValueFamilyMember,
        "if_yes_which_type_of_industry_company_Office":
        whichTypeIndustryCompanyController.text,
        "after_covid19_impact_on_job_opportunity_Availability":
        questionGroupValueJobOpportunity,
        "does_the_industrial_sector_been_affected_after_covid19":
        questionGroupValueIndustrialSectorAffected,
        "suggestions_for_how_job_opportunities_can_be_made_available":
        suggestionJobController.text,
        "does_any_family_member_receive_a_pension":
        questionGroupValueReceivePension,
        "if_yes_specify_which": ifYesSpecifyWhich.text,
        "what_is_your_monthly_expenditure": questionGroupValueMonthlyExp,
        "impact_on_monthly_expenditure_after_covid19":
        questionGroupValueAfterJobOpportunity,
        "how_often_you_visit_the_market_before_covid19":
        questionGroupValueVisitMarket,
        "how_often_you_visit_the_market_after_covid19":
        questionGroupValueAfterVisitMarket,
        "most_preferred_way_of_shopping_after_covid19":
        questionGroupValueAfterShopping,
        "most_preferred_way_of_shopping_before_covid19":
        questionGroupValueBeforeShopping,
        "how_often_do_you_do_online_shopping": questionGroupValueOnlineShopping,
        "economy_status":"1"


      };

      // var response = await http.post(
      //     Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/economy'),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: json.encode(data));
      //
      // // print(response.body);
      // String id = response.body;
      // print("Response====>$id");
      var response;
      if (deviceResponseEconomy.data[0].economy_status == "1" || deviceResponseEconomy.data[0].economy_status != null) {
        print("in if");
        print(surveyId);
        print(data);
        response = await http.put(
            Uri.parse(
                'http://13.232.140.106:5000/rsi-field-force-api/economy?survey_id=$surveyId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(dataupdate));
        print(response.body);

      } else {
        print("in else");
        print(data);
        deviceResponseEconomy.data[0].economy_status = "1";
        response = await http.post(
            Uri.parse(
                'http://13.232.140.106:5000/rsi-field-force-api/economy'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(data));
        print(response.body);
      }

    }
    catch (e) {
      print(e);
    }
  }

  /*void showSnackBar() {post
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

  Widget EconomyAndIndustriesPage1() {
    return  Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
            child: QuestionBody(
              questionBody: Column(
                children: [
                  const PageTitleWidget(
                    title: PageTitle.economyAndIndustries,
                  ),
                  /*------Qusetion1------*/
                  /*--TODO: RadioWithTextStart...--*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.typeOfEmployment),
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
                          (question1GroupValue == "If Others,Specify")
                              ? TextFieldContainer(
                            controller: typeEmploymentController,
                            hint: "Enter Text",
                          )
                              : Container(),
                        ],
                      )),
                  /*--TODO: RadioWithText...--*/
                  /*------Qusetion2------*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: EconomyAndIndustriesQuestion.occupation),
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
                          (question2GroupValue == "If Others, Specify")
                              ? TextFieldContainer(
                            controller: occupationController,
                            hint: "Enter Here",
                          )
                              : Container(),
                        ],
                      )),
                  question2GroupValue == "Construction worker"
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          QuestionName(
                              questionName: EconomyAndIndustriesQuestion
                                  .ifConstructionWorker),
                          for (var i = 0;
                          i < questionChoicesConstruction.length;
                          i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionChoicesConstruction[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionChoicesConstruction[i].toString(),
                                groupValue: questionGroupValueConstruction,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueConstruction = val.toString();
                                    print(questionGroupValueConstruction);
                                  });
                                }),
                        ],
                      ))
                      : Container(),
                  question2GroupValue == "Industrial worker"
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: EconomyAndIndustriesQuestion
                                  .ifConstructionWorker),
                          for (var i = 0; i < questionChoicesIndustrial.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionChoicesIndustrial[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionChoicesIndustrial[i].toString(),
                                groupValue: questionGroupValueIndustrial,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueIndustrial = val.toString();
                                    print(questionGroupValueIndustrial);
                                  });
                                }),
                        ],
                      ))
                      : Container(),
                  QuestionContainer(
                      child: Column(
                        children: [
                          QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.anyAnotherFamilyEmployed),
                          for (var i = 0; i < questionAnotherFamily.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionAnotherFamily[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionAnotherFamily[i].toString(),
                                groupValue: questionGrpAnotherFamily,
                                onChanged: (val) {
                                  setState(() {
                                    questionGrpAnotherFamily = val.toString();
                                    print(questionGrpAnotherFamily);
                                  });
                                }),
                        ],
                      )),
                  questionGrpAnotherFamily == "Yes"
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: EconomyAndIndustriesQuestion
                                  .typeOfEmploymentAnother),
                          for (var i = 0; i < questionANotherEmployee.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionANotherEmployee[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionANotherEmployee[i].toString(),
                                groupValue: questionGrpAnotherEmployee,
                                onChanged: (val) {
                                  setState(() {
                                    questionGrpAnotherEmployee = val.toString();
                                    print(questionGrpAnotherEmployee);
                                  });
                                }),
                          (questionGrpAnotherEmployee == "If Others,Specify")
                              ? TextFieldContainer(
                            controller: typeEmploymentControllerAnother,
                            hint: "Enter Text",
                          )
                              : Container(),
                        ],
                      ))
                      : Container(),
                  questionGrpAnotherFamily == "Yes"
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.occupationAnother),
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
                                groupValue: questionGrpAnotherEmployeeOcc,
                                onChanged: (val) {
                                  setState(() {
                                    questionGrpAnotherEmployeeOcc = val.toString();
                                    print(questionGrpAnotherEmployeeOcc);
                                  });
                                }),
                          (questionGrpAnotherEmployeeOcc == "If Others, Specify")
                              ? TextFieldContainer(
                            controller: occupationControllerAnother,
                            hint: "Enter Text",
                          )
                              : Container(),
                        ],
                      ))
                      : Container(),
                  (questionGrpAnotherEmployeeOcc == "Construction worker")
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: EconomyAndIndustriesQuestion
                                  .ifConstructionWorkerAnother),
                          for (var i = 0;
                          i < questionChoicesConstruction.length;
                          i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionChoicesConstruction[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionChoicesConstruction[i].toString(),
                                groupValue:
                                questionGroupValueConstructionFamilyMember,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueConstructionFamilyMember =
                                        val.toString();
                                    print(
                                        questionGroupValueConstructionFamilyMember);
                                  });
                                }),
                        ],
                      ))
                      : Container(),
                  (questionGrpAnotherEmployeeOcc == "Industrial worker")
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: EconomyAndIndustriesQuestion
                                  .ifIndustrialWorkerAnother),
                          for (var i = 0; i < questionChoicesIndustrial.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionChoicesIndustrial[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionChoicesIndustrial[i].toString(),
                                groupValue:
                                questionGroupValueIndustrialFamilyMember,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueIndustrialFamilyMember =
                                        val.toString();
                                    print(questionGroupValueIndustrialFamilyMember);
                                  });
                                }),
                        ],
                      ))
                      : Container(),

                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.familyMemberPartTime),
                          for (var i = 0; i < questionAnotherFamily.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionAnotherFamily[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionAnotherFamily[i].toString(),
                                groupValue: questionGroupValueFamilyMember,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueFamilyMember = val.toString();
                                    print(questionGroupValueFamilyMember);
                                  });
                                }),
                        ],
                      )),
                  questionGroupValueFamilyMember == "Yes"
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.ifYesWhichIndustry),
                          TextFieldContainer(
                            controller: whichTypeIndustryCompanyController,
                            hint: "Enter Text",
                          ),
                        ],
                      ))
                      : Container(),

/*--TODO: OnlyRadio...--*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.afterCovidImpactJob),
                          for (var i = 0; i < questionChoicesJobOpportunity.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionChoicesJobOpportunity[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionChoicesJobOpportunity[i].toString(),
                                groupValue: questionGroupValueJobOpportunity,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueJobOpportunity = val.toString();
                                    print(questionGroupValueJobOpportunity);
                                  });
                                }),
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.industrialSectorAffect),
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
                                groupValue: questionGroupValueIndustrialSectorAffected,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueIndustrialSectorAffected =
                                        val.toString();
                                    print(questionGroupValueIndustrialSectorAffected);
                                  });
                                }),
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.suggestionsHowJob),
                          TextFieldContainer(
                            controller: suggestionJobController,
                            hint: "Enter Text",
                          )
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: EconomyAndIndustriesQuestion
                                  .familyMemberReceivePension),
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
                                groupValue: questionGroupValueReceivePension,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueReceivePension = val.toString();
                                    print(questionGroupValueReceivePension);
                                  });
                                }),
                        ],
                      )),
                  questionGroupValueReceivePension == "Yes"
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.ifYesSpecifyWhich),
                          TextFieldContainer(
                            controller: ifYesSpecifyWhich,
                            hint: "Enter Text",
                          )
                        ],
                      ))
                      : Container(),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: EconomyAndIndustriesQuestion.whatMonthly),
                          for (var i = 0; i < questionChoicesMonthlyExp.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionChoicesMonthlyExp[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionChoicesMonthlyExp[i].toString(),
                                groupValue: questionGroupValueMonthlyExp,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueMonthlyExp = val.toString();
                                    print(questionGroupValueMonthlyExp);
                                  });
                                }),
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          QuestionName(
                              questionName: EconomyAndIndustriesQuestion.impactOnMonthly),
                          for (var i = 0;
                          i < questionChoicesAfterJobOpportunity.length;
                          i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionChoicesAfterJobOpportunity[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionChoicesAfterJobOpportunity[i].toString(),
                                groupValue: questionGroupValueAfterJobOpportunity,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueAfterJobOpportunity =
                                        val.toString();
                                    print(questionGroupValueAfterJobOpportunity);
                                  });
                                }),
                        ],
                      )),

                  //----11---//
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.howOftenBeforeCovid),
                          for (var i = 0; i < questionChoicesVisitMarket.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionChoicesVisitMarket[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionChoicesVisitMarket[i].toString(),
                                groupValue: questionGroupValueVisitMarket,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueVisitMarket = val.toString();
                                    print(questionGroupValueVisitMarket);
                                  });
                                }),
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.howOftenAeforeCovid),
                          for (var i = 0; i < questionChoicesVisitMarket.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionChoicesVisitMarket[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionChoicesVisitMarket[i].toString(),
                                groupValue: questionGroupValueAfterVisitMarket,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueAfterVisitMarket = val.toString();
                                    print(questionGroupValueAfterVisitMarket);
                                  });
                                }),
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.margetAfterCovid),
                          for (var i = 0; i < questionChoicesShopping.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionChoicesShopping[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionChoicesShopping[i].toString(),
                                groupValue: questionGroupValueAfterShopping,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueAfterShopping = val.toString();
                                    print(questionGroupValueAfterShopping);
                                  });
                                }),
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.margetBeforeCovid),
                          for (var i = 0; i < questionChoicesShopping.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionChoicesShopping[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionChoicesShopping[i].toString(),
                                groupValue: questionGroupValueBeforeShopping,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueBeforeShopping = val.toString();
                                    print(questionGroupValueBeforeShopping);
                                  });
                                }),
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName:
                              EconomyAndIndustriesQuestion.howOftenOnlineShopping),
                          for (var i = 0; i < questionChoicesOnlineShopping.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  questionChoicesOnlineShopping[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: questionChoicesOnlineShopping[i].toString(),
                                groupValue: questionGroupValueOnlineShopping,
                                onChanged: (val) {
                                  setState(() {
                                    questionGroupValueOnlineShopping = val.toString();
                                    print(questionGroupValueOnlineShopping);
                                  });
                                }),
                        ],
                      )),
                  /*submit button*/
                  ButtonSaveAndContinue(
                    onPress: () {
                      setState(() {

                        postMethod();

                        Navigator.pushNamed(context, "/transportation_page");

                        print("====>$question1GroupValue");
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  /*Back button*/
                  ButtonBack(onPress: () async{
                    //
                    SharedPreferences _pref = await SharedPreferences.getInstance();
                    final String statusOf = _pref.getString('survey_status');
                    if (statusOf == "pending_survey")
                    {
                      Navigator.popAndPushNamed(context, '/housing_page');
                    }
                    else
                    {
                      Navigator.pop(context);
                    }

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
            )),
      ),
    );
  }

}
