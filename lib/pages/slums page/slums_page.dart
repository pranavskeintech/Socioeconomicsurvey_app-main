import 'dart:convert';
import 'package:editable/editable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:socio_survey/dbHelper/dbHelper.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/components/table_page.dart';
import 'package:socio_survey/components/textfield_container.dart';
import 'package:socio_survey/json%20data/slums_data.dart';
import 'package:socio_survey/models/SlumsQuestions.dart';
import 'package:socio_survey/pages/Coastal%20Page/coastal_page.dart';
import 'package:socio_survey/pages/environmental%20related%20page/environmental_related_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/widgets/contant_widget.dart';
import 'package:socio_survey/widgets/contants_question.dart';

class SlumsPage extends StatefulWidget {
    final String surveyId;
  SlumsPage({Key key, this.surveyId}) : super(key: key);

  @override
  _SlumsPageState createState() => _SlumsPageState();
}

class _SlumsPageState extends State<SlumsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Slums slums;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  // @override
  // void initState() {
  //   Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  //   var json = slumsData;
  //   slums = Slums.fromJson(json);
  //
  //   setState(() {
  //     connectivityCheck.startMonitoring();
  //     print(slums?.toJson());
  //     page();
  //   });
  //   super.initState();
  // }

  Future futureData;
  DeviceId deviceResponseSlums;

  @override
  void initState() {
    setState(() {
      futureData =  checkStatus();
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
          deviceResponseSlums = DeviceId.fromJson(jsonDecode(response.body));
          print(deviceResponseSlums.data.length);
          print("test");
          print(deviceResponseSlums.data[0].surveyId);
          print(deviceResponseSlums.data[0]);
          print("-----${deviceResponseSlums.data[0].household_status}");
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
    preferences.setString("page", "/slums_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      slums.question[i].ans = val;
    });
  }

  getAns() {
    print(slums.question);
    slums.question.forEach((element) {
      print(element.ans);
    });
  }

  bool _isLoading = false;
  final String title = 'Slums page';

  // List rows = [];
  // List cols = [
  //   {"title": 'Boy/Girl', 'key': 'gender'},
  //   {"title": 'Type of School', 'key': 'typeOfSchool'},
  //   {"title": 'Age of dropout', 'key': 'dropout'},
  //   {"title": 'Reason', 'key': 'reason'},
  // ];
  // final _editableKey = GlobalKey<EditableState>();
  TextEditingController typeOfWorkController = TextEditingController();
  TextEditingController ifSkilledLabourController = TextEditingController();
  TextEditingController typeOfRationCardController = TextEditingController();
  TextEditingController lifeInSlumAresController = TextEditingController();
  TextEditingController whatKindProblemFaceController = TextEditingController();
  TextEditingController ifNotGoingSchoolDropoutAgeController =
      TextEditingController();
  TextEditingController reasonDropOutController = TextEditingController();
  TextEditingController alternativController = TextEditingController();
  TextEditingController anyFurtherSuggController = TextEditingController();
  TextEditingController whichTypeSchoolController = TextEditingController();
  List qtnCho2 = ["Government", "Private"];
  List qtnChoGovernment = ["Patta Holder", "Non-Patta Holder"];
  List qtnCho3 = ["> 5 Year", "5 to 10 Years", "10 to 25 Years", "< 25 Years"];
  List qtnCho4 = [
    "Construction labourer",
    "Rack picker",
    "Driver",
    "Daily wage labour",
    "If Other, Specify"
  ];
  List qtnCho15 = ["Not so bad", "No other way", "Other"];
  List qtnCho16 = [
    "Drainage",
    "No proper ventilation",
    "Drinking water",
    "Electricity",
    "Health",
    "If Others, Specify"
  ];
  List qtnIfSchool = ["Government", "Private", "Others"];
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
              return SlumPageWidget();
        }
      },
    );



  }

  Future postMethod() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String tableData = _preferences.getString('table') ?? "Not Answered";

    final deviceId = _preferences.getString('D_id');
    final surveyId =
        _preferences.getString('survey_id') ?? '${deviceId.toString()}' + 'S1';
    try {
      var data = {
        "survey_id": surveyId,
        "does_this_place_is_allotted_to_you_by_any_authority": qtnGrpVal1,
        "status_of_land": qtnGrpVal2,
        "if_government_land_is_there_any_patta": qtnGrpValGover,
        "how_long_have_you_stayed_here": qtnGrpVal3,
        "types_of_work_in_which_you_are_engaged": qtnGrpVal4,
        "are_you_skilled_labour": qtnGrpVal5,
        "if_yes_skill_type_carpenter_electrician_etc":
            ifSkilledLabourController.text,
        "due_to_the_covid19_has_the_income_and_job_been_affected": qtnGrpVal6,
        "do_you_get_any_ration_assistance_from_the_government": qtnGrpVal7,
        "type_of_ration_card_you_available": typeOfRationCardController.text,
        "do_you_get_any_financial_assistance_from_the_government": qtnGrpVal9,
        "get_any_benefits_from_any_state_or_central_housing_schemes":
            qtnGrpVal10,
        "allotted_house_under_slum_rehabilitation_project_of_government":
            qtnGrpVal11,
        "if_government_provides_a_house_would_you_move_to_that_place":
            qtnGrpVal12,
        "do_you_get_any_benefit_of_swasthya_sathi_for_health_assistance":
            qtnGrpVal13,
        "willing_to_go_back_to_native_if_suitable_jobs_are_made_available":
            qtnGrpVal14,
        "what_do_you_say_about_life_in_slum_areas": qtnGrpVal15,
        "what_kind_of_problems_do_you_face": qtnGrpVal16,
        "do_you_face_any_problems_from_industries_around_you": qtnGrpVal17,
        "whether_all_children_enrolled_in_the_school": qtnGrpVal18,
        "if_yes_which_type_of_school": qtnGrpValSchool,
        "if_not_going_to_school_drop_out_age":
            ifNotGoingSchoolDropoutAgeController.text,
        "reason_of_drop_out": reasonDropOutController.text,
        "if_more_than_one_student": tableData.toString() ?? "",
        "alternative_economic_activities_for_livelihood":
            alternativController.text,
        "any_further_suggestion_or_issues_for_improvement_regarding_slums":
            anyFurtherSuggController.text,
        "slums_status":"1"

      };
      var dataUpdate = {
       // "survey_id": surveyId,
        "does_this_place_is_allotted_to_you_by_any_authority": qtnGrpVal1,
        "status_of_land": qtnGrpVal2,
        "if_government_land_is_there_any_patta": qtnGrpValGover,
        "how_long_have_you_stayed_here": qtnGrpVal3,
        "types_of_work_in_which_you_are_engaged": qtnGrpVal4,
        "are_you_skilled_labour": qtnGrpVal5,
        "if_yes_skill_type_carpenter_electrician_etc":
        ifSkilledLabourController.text,
        "due_to_the_covid19_has_the_income_and_job_been_affected": qtnGrpVal6,
        "do_you_get_any_ration_assistance_from_the_government": qtnGrpVal7,
        "type_of_ration_card_you_available": typeOfRationCardController.text,
        "do_you_get_any_financial_assistance_from_the_government": qtnGrpVal9,
        "get_any_benefits_from_any_state_or_central_housing_schemes":
        qtnGrpVal10,
        "allotted_house_under_slum_rehabilitation_project_of_government":
        qtnGrpVal11,
        "if_government_provides_a_house_would_you_move_to_that_place":
        qtnGrpVal12,
        "do_you_get_any_benefit_of_swasthya_sathi_for_health_assistance":
        qtnGrpVal13,
        "willing_to_go_back_to_native_if_suitable_jobs_are_made_available":
        qtnGrpVal14,
        "what_do_you_say_about_life_in_slum_areas": qtnGrpVal15,
        "what_kind_of_problems_do_you_face": qtnGrpVal16,
        "do_you_face_any_problems_from_industries_around_you": qtnGrpVal17,
        "whether_all_children_enrolled_in_the_school": qtnGrpVal18,
        "if_yes_which_type_of_school": qtnGrpValSchool,
        "if_not_going_to_school_drop_out_age":
        ifNotGoingSchoolDropoutAgeController.text,
        "reason_of_drop_out": reasonDropOutController.text,
        "if_more_than_one_student": tableData.toString() ?? "",
        "alternative_economic_activities_for_livelihood":
        alternativController.text,
        "any_further_suggestion_or_issues_for_improvement_regarding_slums":
        anyFurtherSuggController.text,
        "slums_status":"1"
      };

      // var response = await http.post(
      //     Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/slums'),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: json.encode(data));




      var response;
      if (deviceResponseSlums.data[0].slums_status == "1" || deviceResponseSlums.data[0].slums_status != null) {
        print("in if");
        print(dataUpdate);
        response = await http.put(
            Uri.parse(
                'http://13.232.140.106:5000/rsi-field-force-api/slums?survey_id=$surveyId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(dataUpdate));
        print(response.body);

      } else {
        print("in else");
        print(data);
        deviceResponseSlums.data[0].slums_status = "1";
        response = await http.post(
            Uri.parse(
                'http://13.232.140.106:5000/rsi-field-force-api/slums'),
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

  // sendSlumsData() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/slums'),
  //         body: {
  //           "this_place_is_allotted_to_you_by_any_authority":
  //               slums.question[0].ans,
  //           "status_of_land": slums.question[1].ans,
  //           "is_there_patta": slums.question[2].ans,
  //           "how_long_have_you_stayed_here": slums.question[3].ans,
  //           "types_of_work_you_are_engaged": slums.question[4].ans,
  //           "are_you_skilled_labour": slums.question[5].ans,
  //           "skill_type": slums.question[6].ans,
  //           "due_to_covid19_your_income_job_been_affected":
  //               slums.question[7].ans,
  //           "get_any_ration_assistance_from_government": slums.question[8].ans,
  //           "type_of_ration_card_you_avail": slums.question[9].ans,
  //           "get_any_financial_assitance_from_government":
  //               slums.question[10].ans,
  //           "how_regular": slums.question[11].ans,
  //           "get_any_benefits_from_any_state_central_housing_schemes":
  //               slums.question[12].ans,
  //           "allotted_any_house_under_the_slum_rehabilitation_project":
  //               slums.question[13].ans,
  //           "if_government_provides_house_you_move_to_that_place":
  //               slums.question[14].ans,
  //           "get_any_benefits_of_swasthya_sathi": slums.question[15].ans,
  //           "willing_to_go_back_to_native_if_suitable_jobs_made_available":
  //               slums.question[16].ans,
  //           "life_in_slum_areas": slums.question[17].ans,
  //           "kind_of_problem_do_you_face": slums.question[18].ans,
  //           "face_any_problems_from_industries_around_you":
  //               slums.question[19].ans,
  //           "whether_all_children_enrolled_in_school": slums.question[20].ans,
  //           "student_gender": slums.question[21].ans,
  //           "type_of_school": slums.question[22].ans,
  //           "not_going_dropout_age": slums.question[23].ans,
  //           "reason_of_dropout": slums.question[24].ans,
  //           "suggestion_for_improvement": slums.question[25].ans,
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void showSnackBar() {
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
  }

  Widget SlumPageWidget() {
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
            child: QuestionBody(
              questionBody: Column(
                children: [
                  const PageTitleWidget(title: PageTitle.slums),
                  /*------Qusetion1------*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(questionName: SlumsQuestion.doPlaceAllocted),
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
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(questionName: SlumsQuestion.statusLand),
                          for (var i = 0; i < qtnCho2.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  qtnCho2[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: qtnCho2[i].toString(),
                                groupValue: qtnGrpVal2,
                                onChanged: (val) {
                                  setState(() {
                                    qtnGrpVal2 = val.toString();
                                    print(qtnGrpVal2);
                                  });
                                }),
                        ],
                      )),
                  qtnGrpVal2 == "Government"
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.ifGovernmentLand),
                          for (var i = 0; i < qtnChoGovernment.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  qtnChoGovernment[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: qtnChoGovernment[i].toString(),
                                groupValue: qtnGrpValGover,
                                onChanged: (val) {
                                  setState(() {
                                    qtnGrpValGover = val.toString();
                                    print(qtnGrpValGover);
                                  });
                                }),
                        ],
                      ))
                      : Container(),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.howLongStayedHere),
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
                          const QuestionName(
                              questionName: SlumsQuestion.typeYouAreEngaged),
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
                          (qtnGrpVal4 == "If Other, Specify")
                              ? TextFieldContainer(
                            controller: typeOfWorkController,
                            hint: "Enter Text",
                          )
                              : Container(),
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.areYouSkilledLabour),
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
                          const QuestionName(
                              questionName: SlumsQuestion.ifYesSkillType),
                          TextFieldContainer(
                            controller: ifSkilledLabourController,
                            hint: "Enter Text",
                          )
                        ],
                      ))
                      : Container(),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(questionName: SlumsQuestion.dueToTheCovid19),
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
                          const QuestionName(
                              questionName: SlumsQuestion.doYouGetAnyRationAssistance),
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
                          const QuestionName(
                              questionName: SlumsQuestion.typeOfRationCard),
                          TextFieldContainer(
                            controller: typeOfRationCardController,
                            hint: "Enter Text",
                          )
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.anyFinancialAssitence),
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
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.doYouGetBenefitHosingScheme),
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
                          const QuestionName(
                              questionName: SlumsQuestion.haveAllottedAnyHouse),
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
                          const QuestionName(
                              questionName: SlumsQuestion.ifGovernmentProvideHouse),
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
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(questionName: SlumsQuestion.swasthyaSathi),
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
                                groupValue: qtnGrpVal13,
                                onChanged: (val) {
                                  setState(() {
                                    qtnGrpVal13 = val.toString();
                                    print(qtnGrpVal13);
                                  });
                                }),
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.areYouWillingToGoBack),
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
                          const QuestionName(
                              questionName: SlumsQuestion.whatDoYouSaySlumAreas),
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
                          (qtnGrpVal15 == "Other")
                              ? TextFieldContainer(
                            controller: lifeInSlumAresController,
                            hint: "Enter Text",
                          )
                              : Container(),
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.whatKindProblemsFace),
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
                          (qtnGrpVal16 == "If Others, Specify")
                              ? TextFieldContainer(
                            controller: whatKindProblemFaceController,
                            hint: "Enter Text",
                          )
                              : Container(),
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.doYouFaceProblemsIndustries),
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
                                groupValue: qtnGrpVal17,
                                onChanged: (val) {
                                  setState(() {
                                    qtnGrpVal17 = val.toString();
                                    print(qtnGrpVal17);
                                  });
                                }),
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.whetherAllChildren),
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

                  qtnGrpVal18 == "Yes"
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.ifYesWhichTypeSchool),
                          for (var i = 0; i < qtnIfSchool.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  qtnIfSchool[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: qtnIfSchool[i].toString(),
                                groupValue: qtnGrpValSchool,
                                onChanged: (val) {
                                  setState(() {
                                    qtnGrpValSchool = val.toString();
                                    print(qtnGrpValSchool);
                                  });
                                }),
                          (qtnGrpValSchool == "Others")
                              ? TextFieldContainer(
                            controller: whichTypeSchoolController,
                            hint: "Enter Text",
                          )
                              : Container(),
                        ],
                      ))
                      : Container(),
                  qtnGrpVal18 == "Yes"
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          QuestionName(
                              questionName: SlumsQuestion.ifNotSchoolDropOutAge),
                          TextFieldContainer(
                            controller: ifNotGoingSchoolDropoutAgeController,
                            inputType: TextInputType.number,
                            hint: "Enter Drop out Age",
                          ),
                        ],
                      ))
                      : Container(),
                  qtnGrpVal18 == "Yes"
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.reasonDropOut),
                          TextFieldContainer(
                            controller: reasonDropOutController,
                            hint: "Enter Text",
                          )
                        ],
                      ))
                      : Container(),
                  qtnGrpVal18 == "Yes"
                      ? QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.ifMoreFillTable),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TablePage()));
                              },
                              child: Center(
                                  child: Text(
                                    "Click here to Open Table",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 18, color: Colors.red),
                                  )))
                        ],
                      ))
                      : Container(),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: SlumsQuestion.alternativeEconomiclivelihood),
                          TextFieldContainer(
                            controller: alternativController,
                            hint: "Enter Text",
                          )
                        ],
                      )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          QuestionName(questionName: SlumsQuestion.anyFurtherSuggestion),
                          TextFieldContainer(
                            controller: anyFurtherSuggController,
                            hint: "Enter Text",
                          )
                        ],
                      )),

//------------------------------------------------
                  //------------------------------------------------
                  /*submit button*/
                  ButtonSaveAndContinue(
                    onPress: () async{
                      print("dfghdgfhd");

                     // Navigator.pushNamed(context, "/environmentalRelated_page");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EnvironmentalRelatedPage(data:"hi")));


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
                    if (statusOf == "pending_survey")
                    {
                      Navigator.pushNamed(context, '/skip_page');
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

  // Widget tableData() {
  //   return Editable(
  //     key: _editableKey,
  //     columns: cols,
  //     rows: rows,
  //     //zebraStripe: true,
  //     // stripeColor1: Colors.blue[50],
  //     //stripeColor2: Colors.grey[200],
  //     onRowSaved: (value) {
  //       print(value);
  //     },
  //     onSubmitted: (value) {
  //       print(value);
  //     },
  //     //borderColor: Color(0xfff89d4cf),
  //     // tdStyle: TextStyle(fontWeight: FontWeight.),
  //     trHeight: 80,
  //     thStyle: TextStyle(fontSize: 15),
  //     thAlignment: TextAlign.center,
  //     thVertAlignment: CrossAxisAlignment.end,
  //     thPaddingBottom: 3,
  //     //showSaveIcon: true,
  //     //saveIconColor: Colors.black,
  //     // showCreateButton: true,
  //     tdAlignment: TextAlign.left,
  //     tdEditableMaxLines: 100, // don't limit and allow data to wrap
  //     tdPaddingTop: 0,
  //     tdPaddingBottom: 14,
  //     tdPaddingLeft: 10,
  //     tdPaddingRight: 8,
  //     focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.blue),
  //         borderRadius: BorderRadius.all(Radius.circular(0))),
  //   );
  // }
}

// class TableData extends StatelessWidget {
//   const TableData({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List rows = [];
//     List cols = [
//       {"title": 'Boy/Girl', 'key': 'gender'},
//       {"title": 'Type of School', 'key': 'typeOfSchool'},
//       {"title": 'Age of dropout', 'key': 'dropout'},
//       {"title": 'Reason', 'key': 'reason'},
//     ];
//     final _editableKey = GlobalKey<EditableState>();
//     return SingleChildScrollView(
//       child: Editable(
//         key: _editableKey,
//         columns: cols,
//         rows: rows,
//         //zebraStripe: true,
//         // stripeColor1: Colors.blue[50],
//         //stripeColor2: Colors.grey[200],
//         onRowSaved: (value) {
//           print(value);
//         },
//         onSubmitted: (value) {
//           print(value);
//         },
//         //borderColor: Color(0xfff89d4cf),
//         // tdStyle: TextStyle(fontWeight: FontWeight.),
//         trHeight: 80,
//         thStyle: TextStyle(fontSize: 15),
//         thAlignment: TextAlign.center,
//         thVertAlignment: CrossAxisAlignment.end,
//         thPaddingBottom: 3,
//         //showSaveIcon: true,
//         //saveIconColor: Colors.black,
//         // showCreateButton: true,
//         tdAlignment: TextAlign.left,
//         tdEditableMaxLines: 100, // don't limit and allow data to wrap
//         tdPaddingTop: 0,
//         tdPaddingBottom: 14,
//         tdPaddingLeft: 10,
//         tdPaddingRight: 8,
//         focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.blue),
//             borderRadius: BorderRadius.all(Radius.circular(0))),
//       ),
//     );
//   }
// }
