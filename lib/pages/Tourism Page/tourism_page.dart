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
import 'package:socio_survey/json%20data/tourism_data.dart';
import 'package:socio_survey/main.dart';
import 'package:socio_survey/models/TourismQuestion.dart';
import 'package:socio_survey/pages/cultural%20and%20heritage%20page/cultural_and_heritage.dart';
import 'package:socio_survey/pages/environmental%20related%20page/environmental_related_page.dart';
import 'package:socio_survey/pages/final%20page/final_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/widgets/contant_widget.dart';
import 'package:socio_survey/widgets/contants_question.dart';

class TourismPage extends StatefulWidget {
  final surveyId;

  TourismPage({Key key, this.surveyId}) : super(key: key);

  @override
  _TourismPageState createState() => _TourismPageState();
}

class _TourismPageState extends State<TourismPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  Tourism tourism;

  // @override
  // void initState() {
  //   Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  //   var json = tourismData;
  //   tourism = Tourism.fromJson(json);
  //
  //   setState(() {
  //     connectivityCheck.startMonitoring();
  //     print(tourism?.toJson());
  //     page();
  //   });
  //   super.initState();
  // }

  Future futureData;
  DeviceId deviceResponseTourist;

  @override
  void initState() {
    setData();
    var json = tourismData;
    tourism = Tourism.fromJson(json);
    setState(() {
      connectivityCheck.startMonitoring();
      print(tourism?.toJson());
      page();
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
          deviceResponseTourist = DeviceId.fromJson(jsonDecode(response.body));
          print(deviceResponseTourist.data.length);
          print("test");
          print(deviceResponseTourist.data[0].surveyId);
          print(deviceResponseTourist.data[0]);
          print("-----${deviceResponseTourist.data[0].household_status}");
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
    preferences.setString("page", "/tourism_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      tourism.question[i].ans = val;
    });
  }

  getAns() {
    print(tourism.question);
    tourism.question.forEach((element) {
      print(element.ans);
    });
  }

  List onChangeList = [];
  bool _isLoading = false;
  final String title = 'Tourism';

  TextEditingController fithQuizController = TextEditingController();
  TextEditingController fithQuizController1 = TextEditingController();
  TextEditingController tenthQuizController = TextEditingController();
  TextEditingController tenthQuizController1 = TextEditingController();
  TextEditingController tenthQuizController2 = TextEditingController();
  TextEditingController twelthQuizController = TextEditingController();
  TextEditingController twelthQuizController1 = TextEditingController();

  String fifthquz;
  String fifthquz1;
  String tenthquz;
  String tenthquz1;
  String tenthquz2;
  String twelthquz;
  String twelthquz1;
  TextEditingController bestSessionController = TextEditingController();
  TextEditingController whichTypeActivitesController = TextEditingController();
  TextEditingController duringSessionController = TextEditingController();
  TextEditingController leanSessionController = TextEditingController();
  TextEditingController noOfPersonController = TextEditingController();
  TextEditingController ifHandiCraftController = TextEditingController();
  TextEditingController whomDoYouSellController = TextEditingController();
  TextEditingController localMelaController = TextEditingController();
  TextEditingController kolkataFairController = TextEditingController();
  TextEditingController intraStatelController = TextEditingController();
  TextEditingController beforeCovidController = TextEditingController();
  TextEditingController afterCovidController = TextEditingController();
  TextEditingController anyFurtherSuggestionController = TextEditingController();
  List q1Choice = ["Yes", "No"];
  String q1V;
  List q3Choice = ["Yes", "No"];
  String q3V;
  List q9Choice = ["Yes", "No"];
  String q9V;
  List q11Choice = ["Yes", "No"];
  String q11V;
  List q13Choice = ["Yes", "No"];
  String q13V;

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
              return TourismWidget();
        }
      },
    );
  }

  String fifthCombinedData() {
    List combine = [
      {fithQuizController.text, fithQuizController1.text}
    ];

    String finalData = combine.join("");

    return finalData;
  }

  String tenthCombinedData() {
    List combine = [
      {tenthQuizController.text, tenthQuizController1.text, tenthQuizController2.text}
    ];
    String finalData = combine.join("");
    return finalData;
  }

  String twelthCombinedData() {
    List combine = [
      {twelthQuizController.text, twelthQuizController1.text}
    ];
    String finalData = combine.join("");
    return finalData;
  }

  Widget fifthQuz() {
    return Container(
      // margin: EdgeInsets.all(20),
      // padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          //Text("data"),
          // Text('5. Any other work engagement apart from tourist activity?'),
          ListTile(
            title: Text(
              "During tourist season",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    fifthquz = fithQuizController.text;
                  });
                },
                controller: fithQuizController,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter here')),
          ),
          ListTile(
            title: Text(
              "Lean season",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    fifthquz1 = fithQuizController1.text;
                  });
                },
                controller: fithQuizController1,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter here')),
          )
        ],
      ),
    );
  }

  Widget tenthQuiz() {
    return Container(
      // margin: EdgeInsets.all(20),
      // padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          //Text("data"),
          // Text('5. Any other work engagement apart from tourist activity?'),
          ListTile(
            title: Text(
              "Local Mela/ Fair/ Hat or within District:",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    tenthquz = tenthQuizController.text;
                  });
                },
                controller: tenthQuizController,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter here')),
          ),
          ListTile(
            title: Text(
              "Kolkata Fair or Inter-State:",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    tenthquz1 = tenthQuizController1.text;
                  });
                },
                controller: tenthQuizController1,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter here')),
          ),
          ListTile(
            title: Text(
              "Intra-State or outside state:",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    tenthquz2 = tenthQuizController2.text;
                  });
                },
                controller: tenthQuizController2,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter here')),
          )
        ],
      ),
    );
  }

  Widget twelthQuiz() {
    return Container(
      // margin: EdgeInsets.all(20),
      // padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          //Text("data"),
          // Text('5. Any other work engagement apart from tourist activity?'),
          ListTile(
            title: Text(
              "Before Covid-19",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    twelthquz = twelthQuizController.text;
                  });
                },
                controller: twelthQuizController,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter here')),
          ),
          ListTile(
            title: Text(
              "After Covid-19",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    twelthquz1 = twelthQuizController1.text;
                  });
                },
                controller: twelthQuizController1,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter here')),
          )
        ],
      ),
    );
  }

  void setData() {
    if (widget.surveyId == null) {
      return;
    }

    q1V = surveyModel.doTouristsComeToThisRegionRegularly;
    bestSessionController.text = surveyModel.bestSeasonForTouristToVisitAndWhy;
    q3V = surveyModel.areYouInvolvedInTouristsRelatedActivities;

    whichTypeActivitesController.text = surveyModel.whichTypeOfActivitiesYoureInvolvedIn;

    /*"${duringSessionController.text + "," + leanSessionController.text}" = surveyModel.anyOtherWorkEngagementApartFromTouristActivity ;*/

    noOfPersonController.text = surveyModel.noOfPersonOrFamilyMemberEngageInSuchActivity;
    ifHandiCraftController.text = surveyModel.ifHandicraftWhatItemsDoYouSell;

    whomDoYouSellController.text = surveyModel.whomDoYouSellYourProductsToMostOften;
    q9V = surveyModel.participateInAnyFairOrMelaForProductShowcaseAndSell;

    /*"${localMelaController.text + "," + kolkataFairController.text + "," + intraStatelController.text}" = surveyModel.ifYesWhereAndHowOftenDoYouVisit ;*/
    q11V = surveyModel.availabilityOfTrainingCentreAndExhibitionCentre;

/*    "${beforeCovidController.text + "," + afterCovidController.text}" = surveyModel.sellOfProducts ;*/
    q13V = surveyModel.tourismSectorHelpsInEconomicGrowthOfThisRegion;
    anyFurtherSuggestionController.text = surveyModel.anyFurtherSuggestionForImprovementInTourism;
  }

  Future postMethod() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    final deviceId = _preferences.getString('D_id');
    final surveyId = _preferences.getString('survey_id') ?? '${deviceId.toString()}' + 'S1';
    try {
      var data = {
        "survey_id": surveyId,
        "do_tourists_come_to_this_region_regularly": q1V,
        "best_season_for_tourist_to_visit_and_why": bestSessionController.text,
        "are_you_involved_in_tourists_related_activities": q3V,
        "which_type_of_activities_youre_involved_in": whichTypeActivitesController.text,
        "any_other_work_engagement_apart_from_tourist_activity": "${duringSessionController.text + "," + leanSessionController.text}",
        "no_of_person_or_family_member_engage_in_such_activity": noOfPersonController.text,
        "if_handicraft_what_items_do_you_sell": ifHandiCraftController.text,
        "whom_do_you_sell_your_products_to_most_often": whomDoYouSellController.text,
        "participate_in_any_fair_or_mela_for_product_showcase_and_sell": q9V,
        "if_yes_where_and_how_often_do_you_visit": "${localMelaController.text + "," + kolkataFairController.text + "," + intraStatelController.text}",
        "availability_of_training_centre_and_exhibition_centre": q11V,
        "sell_of_products": "${beforeCovidController.text + "," + afterCovidController.text}",
        "tourism_sector_helps_in_economic_growth_of_this_region": q13V,
        "any_further_suggestion_for_improvement_in_tourism": anyFurtherSuggestionController.text,
        "tourism_status": "1"
      };
      var dataUpdate = {
        "survey_id": surveyId,
        "do_tourists_come_to_this_region_regularly": q1V,
        "best_season_for_tourist_to_visit_and_why": bestSessionController.text,
        "are_you_involved_in_tourists_related_activities": q3V,
        "which_type_of_activities_youre_involved_in": whichTypeActivitesController.text,
        "any_other_work_engagement_apart_from_tourist_activity": "${duringSessionController.text + "," + leanSessionController.text}",
        "no_of_person_or_family_member_engage_in_such_activity": noOfPersonController.text,
        "if_handicraft_what_items_do_you_sell": ifHandiCraftController.text,
        "whom_do_you_sell_your_products_to_most_often": whomDoYouSellController.text,
        "participate_in_any_fair_or_mela_for_product_showcase_and_sell": q9V,
        "if_yes_where_and_how_often_do_you_visit": "${localMelaController.text + "," + kolkataFairController.text + "," + intraStatelController.text}",
        "availability_of_training_centre_and_exhibition_centre": q11V,
        "sell_of_products": "${beforeCovidController.text + "," + afterCovidController.text}",
        "tourism_sector_helps_in_economic_growth_of_this_region": q13V,
        "any_further_suggestion_for_improvement_in_tourism": anyFurtherSuggestionController.text,
        "tourism_status": "1"
      };

      // var response = await http.post(
      //     Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/tourism'),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: json.encode(data));

      var response;
      if (deviceResponseTourist.data[0].tourism_status == "1" || deviceResponseTourist.data[0].tourism_status != null) {
        print("in if");
        print(dataUpdate);
        response = await http.put(Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/tourism?survey_id=$surveyId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(dataUpdate));
        print(response.body);
      } else {
        print("in else");
        print(data);
        deviceResponseTourist.data[0].tourism_status = "1";
        response = await http.post(Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/tourism'),
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
  }
*/
  Widget TourismWidget() {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: QuestionBody(
            questionBody: Column(
              children: [
                const PageTitleWidget(title: PageTitle.tourism),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: TourismQuestion.doTouristRegion),
                    for (var i = 0; i < q1Choice.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q1Choice[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q1Choice[i].toString(),
                          groupValue: q1V,
                          onChanged: (val) {
                            setState(() {
                              q1V = val.toString();
                              print(q1V);
                            });
                          }),
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: TourismQuestion.bestSessionTourist),
                    TextFieldContainer(
                      controller: bestSessionController,
                      hint: "Enter Text",
                    )
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: TourismQuestion.areYouInvolvedTouristActivities),
                    for (var i = 0; i < q3Choice.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q3Choice[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q3Choice[i].toString(),
                          groupValue: q3V,
                          onChanged: (val) {
                            setState(() {
                              q3V = val.toString();
                              print(q3V);
                            });
                          }),
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: TourismQuestion.whichTypeOfActivites),
                    TextFieldContainer(
                      controller: whichTypeActivitesController,
                      hint: "Enter Text",
                    )
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: TourismQuestion.anyOtherEngagement),
                    SizedBox(
                      height: 10,
                    ),
                    const QuestionName(questionName: TourismQuestion.duringTouringSeason),
                    TextFieldContainer(
                      controller: duringSessionController,
                      hint: "Enter Text",
                    ),
                    const QuestionName(questionName: TourismQuestion.leanSeason),
                    TextFieldContainer(
                      controller: leanSessionController,
                      hint: "Enter Text",
                    )
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: TourismQuestion.noOfPersonSuchAct),
                    TextFieldContainer(
                      controller: noOfPersonController,
                      hint: "Enter Text",
                    )
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: TourismQuestion.ifHandicraft),
                    TextFieldContainer(
                      controller: ifHandiCraftController,
                      hint: "Enter Text",
                    )
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: TourismQuestion.whomDoYouSellProducts),
                    TextFieldContainer(
                      controller: whomDoYouSellController,
                      hint: "Enter Text",
                    )
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: TourismQuestion.doYouParticipate),
                    for (var i = 0; i < q9Choice.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q9Choice[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q9Choice[i].toString(),
                          groupValue: q9V,
                          onChanged: (val) {
                            setState(() {
                              q9V = val.toString();
                              print(q9V);
                            });
                          }),
                  ],
                )),
                if (q9V == "Yes")
                  QuestionContainer(
                      child: Column(
                    children: [
                      const QuestionName(questionName: TourismQuestion.ifYesWhereAndHowOften),
                      SizedBox(
                        height: 10,
                      ),
                      const QuestionName(questionName: TourismQuestion.localMela),
                      TextFieldContainer(
                        controller: localMelaController,
                        hint: "Enter Text",
                      ),
                      const QuestionName(questionName: TourismQuestion.kolkataFair),
                      TextFieldContainer(
                        controller: kolkataFairController,
                        hint: "Enter Text",
                      ),
                      const QuestionName(questionName: TourismQuestion.intraState),
                      TextFieldContainer(
                        controller: intraStatelController,
                        hint: "Enter Text",
                      )
                    ],
                  )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: TourismQuestion.availabilityOfTraining),
                    for (var i = 0; i < q11Choice.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q11Choice[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q11Choice[i].toString(),
                          groupValue: q11V,
                          onChanged: (val) {
                            setState(() {
                              q11V = val.toString();
                              print(q11V);
                            });
                          }),
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: TourismQuestion.sellOfProducts),
                    SizedBox(
                      height: 10,
                    ),
                    const QuestionName(questionName: TourismQuestion.beforeCovid19),
                    TextFieldContainer(
                      controller: beforeCovidController,
                      hint: "Enter Text",
                    ),
                    const QuestionName(questionName: TourismQuestion.afterCovid19),
                    TextFieldContainer(
                      controller: afterCovidController,
                      hint: "Enter Text",
                    ),
                  ],
                )),
                QuestionContainer(
                    child: Column(
                  children: [
                    const QuestionName(questionName: TourismQuestion.doYouThinkTourismSector),
                    for (var i = 0; i < q13Choice.length; i++)
                      RadioListTile(
                          tileColor: Colors.orangeAccent,
                          selectedTileColor: Colors.orangeAccent,
                          activeColor: Colors.deepOrange,
                          title: Text(
                            q13Choice[i].toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                            ),
                          ),
                          value: q13Choice[i].toString(),
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
                    const QuestionName(questionName: TourismQuestion.anyFurtherSuggestionForImprovement),
                    TextFieldContainer(
                      controller: anyFurtherSuggestionController,
                      hint: "Enter Text",
                    ),
                  ],
                )),
                //------------------------------------------------
                /*submit button*/
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Color(0xfff89d4cf),
                    ),
                    child: FlatButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, "/landing_page");
                        await postMethod();
                      },
                      height: 50,
                      minWidth: 250,
                      textColor: Colors.white,
                      child: Text("Save & Submit",
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    )),
                const SizedBox(
                  height: 15,
                ),
                /*Back button*/
                ButtonBack(onPress: () async {
                  SharedPreferences _pref = await SharedPreferences.getInstance();
                  final String statusOf = _pref.getString('survey_status');
                  if (statusOf == "pending_survey") {
                    // Navigator.pushNamed(context, '/culturalAndHeritage');
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CulturalAndHeritage(surveyId: widget.surveyId,)));
                  } else {
                    Navigator.pop(context);
                  }
                }),
                const SizedBox(
                  height: 15,
                ),
                /*Save And Exit button*/
                ButtonSaveAndExit(onPress: () {
                  Navigator.pushNamed(context, "/landing_page");
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

// sendTourismData() async {
//   try {
//     var response = await http.post(
//         Uri.parse(
//             'http://192.168.12.69:3000/socio-economic-survey-api/user/tourism'),
//         body: {
//           "tourists_come_to_this_region_regularly": tourism.question[0].ans,
//           "best_season_for_tourist_to_visit_then_why":
//               tourism.question[1].ans,
//           "are_you_involved_in_tourist_related_activities":
//               tourism.question[2].ans,
//           "which_type_of_activities_you_involved_in": tourism.question[3].ans,
//           "work_engagement_apart_from_tourist_activity":
//               tourism.question[4].ans,
//           "no_of_family_members_engage_in_such_activity":
//               tourism.question[5].ans,
//           "if_handicraft_what_item_do_you_sell": tourism.question[6].ans,
//           "whom_do_you_sell_your_products_to_most_often":
//               tourism.question[7].ans,
//           "participate_in_any_mela_for_product_showcase_sell":
//               tourism.question[8].ans,
//           "where_then_how_often_do_you_visit_mela": tourism.question[9].ans,
//           "availabolity_of_training_center_exhibition_center":
//               tourism.question[10].ans,
//           "sell_of_product_before_covid19": tourism.question[11].ans,
//           "sell_of_product_after_covid19": tourism.question[12].ans,
//           "tourism_sector_helps_economic_growth_of_this_region":
//               tourism.question[13].ans,
//           "any_suggestion_for_improvement": tourism.question[14].ans,
//           "any_further_suggestion_for_improvement": tourism.question[15].ans,
//         });
//     print(response);
//   } catch (e) {
//     print(e);
//   }
// }
}
