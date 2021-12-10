import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:socio_survey/dbHelper/dbHelper.dart';
import 'package:socio_survey/json%20data/culturalHeritage_data.dart';
import 'package:socio_survey/models/CulturalQuestion.dart';
import 'package:socio_survey/pages/Tourism%20Page/tourism_page.dart';
import 'package:socio_survey/widgets/contant_widget.dart';
import 'package:socio_survey/widgets/contants_question.dart';

class CulturalAndHeritage extends StatefulWidget {
  CulturalAndHeritage({Key key}) : super(key: key);

  @override
  _CulturalAndHeritageState createState() => _CulturalAndHeritageState();
}

class _CulturalAndHeritageState extends State<CulturalAndHeritage> {
  TextEditingController othersSpcify1 = TextEditingController();

  String listToString1;

  String combine1;

  bool showOthersQuis1 = false;
  TextEditingController othersSpcify2 = TextEditingController();

  String listToString2;

  String combine2;

  bool showOthersQuis2 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CulturalHeritage culturalHeritage;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();

  Future futureData;
  DeviceId deviceResponseCultural;

  @override
  void initState() {
    setState(() {
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
          deviceResponseCultural = DeviceId.fromJson(jsonDecode(response.body));
          print(deviceResponseCultural.data.length);
          print("test");
          print(deviceResponseCultural.data[0].surveyId);
          print(deviceResponseCultural.data[0]);
          print("-----${deviceResponseCultural.data[0].household_status}");
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
    preferences.setString("page", "/culturalAndHeritage");
  }

  setSelectedRadio(val, i) {
    setState(() {
      culturalHeritage.question[i].ans = val;
    });
  }

  getAns() {
    print(culturalHeritage.question);
    culturalHeritage.question.forEach((element) {
      print(element.ans);
    });
  }

  List<bool> userStatus = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  var tmpArray = [];
  List<bool> userStatus1 = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  var tmpArray1 = [];
  bool _isLoading = false;
  final String title = 'Cultural and Heritage';
  TextEditingController poplarFestivalController = TextEditingController();
  TextEditingController problemFacedFestivalController =
  TextEditingController();
  TextEditingController doesFestivalOccusionController =
  TextEditingController();
  TextEditingController anyFurtherSuggController = TextEditingController();
  List q1checkBoxChoices = [
    "Durga Puja",
    "Holi",
    "Eid",
    "Rath Yaatra",
    "Diwali",
    "Muhaaram",
    "If Other, Specify"
  ];
  List q1checkBoxChoicesValues = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List q2Choice = ["Yes", "No"];
  String q2V;
  List q3Choice = ["Within the state", "Outside the state"];
  String q3V;
  List q4checkBoxChoices = [
    "Traffic Issue",
    "Over Crowded",
    "Lots of Noise",
    "Cleanliness",
    "If other Specify"
  ];
  List q4checkBoxChoicesValues = [
    false,
    false,
    false,
    false,
    false,
  ];
  List q5Choice = ["Yes", "No"];
  String q5V;
  List q7Choice = ["Yes", "No"];
  String q7V;
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
            return Scaffold(
              body: GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: QuestionBody(
                    questionBody: Column(
                      children: [
                        const PageTitleWidget(
                          title: PageTitle.culturalAndHeritage,
                        ),
                        QuestionContainer(
                            child: Column(
                              children: [
                                const QuestionName(
                                    questionName:
                                    CulturalAndHeriageQuestion.popularFestivalOccasion),
                                for (var i = 0; i < q1checkBoxChoices.length; i++)
                                  CheckboxListTile(
                                      activeColor: Colors.deepOrange,
                                      title: Text(
                                        q1checkBoxChoices[i],
                                        style: GoogleFonts.quicksand(
                                          fontSize: 18,
                                        ),
                                      ),
                                      value: q1checkBoxChoicesValues[i],
                                      onChanged: (value) {
                                        setState(() {
                                          q1checkBoxChoicesValues[i] = value;
                                        });
                                        print(q1checkBoxChoices[i]);
                                      }),
                                (q1checkBoxChoicesValues[6] &&
                                    q1checkBoxChoices.contains("If Other, Specify"))
                                    ? TextFieldContainer(
                                    controller: poplarFestivalController,
                                    hint: "Enter Text")
                                    : Container(),
                              ],
                            )),
                        QuestionContainer(
                            child: Column(
                              children: [
                                const QuestionName(
                                    questionName:
                                    CulturalAndHeriageQuestion.doesThisPlaceSignificant),
                                for (var i = 0; i < q2Choice.length; i++)
                                  RadioListTile(
                                      tileColor: Colors.orangeAccent,
                                      selectedTileColor: Colors.orangeAccent,
                                      activeColor: Colors.deepOrange,
                                      title: Text(
                                        q2Choice[i].toString(),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 18,
                                        ),
                                      ),
                                      value: q2Choice[i].toString(),
                                      groupValue: q2V,
                                      onChanged: (val) {
                                        setState(() {
                                          q2V = val.toString();
                                          print(q2V);
                                        });
                                      }),
                              ],
                            )),
                        QuestionContainer(
                            child: Column(
                              children: [
                                const QuestionName(
                                    questionName: CulturalAndHeriageQuestion.visitersDuring),
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
                                const QuestionName(
                                    questionName: CulturalAndHeriageQuestion.problemFaced),
                                for (var i = 0; i < q4checkBoxChoices.length; i++)
                                  CheckboxListTile(
                                      activeColor: Colors.deepOrange,
                                      title: Text(
                                        q4checkBoxChoices[i],
                                        style: GoogleFonts.quicksand(
                                          fontSize: 18,
                                        ),
                                      ),
                                      value: q4checkBoxChoicesValues[i],
                                      onChanged: (value) {
                                        setState(() {
                                          q4checkBoxChoicesValues[i] = value;
                                        });
                                        print(q4checkBoxChoices[i]);
                                      }),
                                (q4checkBoxChoicesValues[4] &&
                                    q4checkBoxChoices.contains("If other Specify"))
                                    ? TextFieldContainer(
                                  controller: problemFacedFestivalController,
                                  hint: "Enter Text",
                                )
                                    : Container(),
                              ],
                            )),
                        QuestionContainer(
                            child: Column(
                              children: [
                                const QuestionName(
                                    questionName:
                                    CulturalAndHeriageQuestion.doesFestiveOccasion),
                                for (var i = 0; i < q5Choice.length; i++)
                                  RadioListTile(
                                      tileColor: Colors.orangeAccent,
                                      selectedTileColor: Colors.orangeAccent,
                                      activeColor: Colors.deepOrange,
                                      title: Text(
                                        q5Choice[i].toString(),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 18,
                                        ),
                                      ),
                                      value: q5Choice[i].toString(),
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
                                  const QuestionName(
                                      questionName: CulturalAndHeriageQuestion.ifYesSpecify),
                                  TextFieldContainer(
                                    controller: doesFestivalOccusionController,
                                    hint: "Enter Text",
                                  )
                                ],
                              )),
                        QuestionContainer(
                            child: Column(
                              children: [
                                const QuestionName(
                                    questionName: CulturalAndHeriageQuestion.doTouristsVisit),
                                for (var i = 0; i < q7Choice.length; i++)
                                  RadioListTile(
                                      tileColor: Colors.orangeAccent,
                                      selectedTileColor: Colors.orangeAccent,
                                      activeColor: Colors.deepOrange,
                                      title: Text(
                                        q7Choice[i].toString(),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 18,
                                        ),
                                      ),
                                      value: q7Choice[i].toString(),
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
                                const QuestionName(
                                    questionName:
                                    CulturalAndHeriageQuestion.anyFurtherSuggestion),
                                TextFieldContainer(
                                  controller: anyFurtherSuggController,
                                  hint: "Enter Text",
                                )
                              ],
                            )),
                        /*submit button*/
                        ButtonSaveAndContinue(
                          onPress: () async{
                            Navigator.pushNamed(context, '/tourism_page');
                            await postMethod();

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
                            Navigator.pushNamed(context, '/environmentalRelated_page');
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
                  ),
                ),
              ),
            );
        }
      },
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
  }*/

  Future postMethod() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    final deviceId = _preferences.getString('D_id');
    final surveyId =
        _preferences.getString('survey_id') ?? '${deviceId.toString()}' + 'S1';
    try {
      var data = {
        "survey_id": surveyId,
        "popular_festival_occasion": "ChecKBox",
        "this_place_have_any_significant_heritage_site_structure": q2V,
        "visitors_during_the_festivals_or_occasion": q3V,
        "problem_faced_during_the_festivals_and_occasion": "CheckBox",
        "festive_occasion_presence_help_you_in_the_economic_generation": q5V,
        "if_yes_specify_how_festivals_helps":
        doesFestivalOccusionController.text,
        "do_tourists_visit_this_place_regularly_or_during_festivals": q7V,
        "any_further_suggestion_in_cultural_heritage":
        anyFurtherSuggController.text,
        "cultural_heritage_status":"1"
      };
      var dataUpdate = {
        //"survey_id": surveyId,
        "popular_festival_occasion": "ChecKBox",
        "this_place_have_any_significant_heritage_site_structure": q2V,
        "visitors_during_the_festivals_or_occasion": q3V,
        "problem_faced_during_the_festivals_and_occasion": "CheckBox",
        "festive_occasion_presence_help_you_in_the_economic_generation": q5V,
        "if_yes_specify_how_festivals_helps":
        doesFestivalOccusionController.text,
        "do_tourists_visit_this_place_regularly_or_during_festivals": q7V,
        "any_further_suggestion_in_cultural_heritage":
        anyFurtherSuggController.text,
        "cultural_heritage_status":"1"
      };
      // var response = await http.post(
      //     Uri.parse(
      //         'http://13.232.140.106:5000/rsi-field-force-api/cultural-heritage'),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: json.encode(data));

      var response;
      if (deviceResponseCultural.data[0].cultural_heritage_status == "1" || deviceResponseCultural.data[0].cultural_heritage_status != null) {
        print("in if");
        print(dataUpdate);
        response = await http.put(
            Uri.parse(
                'http://13.232.140.106:5000/rsi-field-force-api/cultural-heritage?survey_id=$surveyId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(dataUpdate));
        print(response.body);

      } else {
        print("in else");
        print(data);
        deviceResponseCultural.data[0].cultural_heritage_status = "1";
        response = await http.post(
            Uri.parse(
                'http://13.232.140.106:5000/rsi-field-force-api/cultural-heritage'),
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

  // Widget culturalHeritageWidget() {
  //   return
  // }

// sendCulturalData() async {
//   try {
//     var response = await http.post(
//         Uri.parse(
//             'http://192.168.12.69:3000/socio-economic-survey-api/user/cultural-heritage'),
//         body: {
//           "popular_festival_occasion": culturalHeritage.question[0].ans,
//           "place_have_any_significant_heritage_site_structure_precinit":
//               culturalHeritage.question[1].ans,
//           "visitors_during_festival_occasion":
//               culturalHeritage.question[2].ans,
//           "problem_during_festival_occasion":
//               culturalHeritage.question[3].ans,
//           "festival_heritage_presence_help_you_in_economic_generation":
//               culturalHeritage.question[4].ans,
//           "if_yes_specify": culturalHeritage.question[5].ans,
//           "tourists_visit_this_place_regularly_during_festivals":
//               culturalHeritage.question[6].ans,
//           "any_further_suggestion_issues_for_improvement":
//               culturalHeritage.question[7].ans,
//         });
//     print(response);
//   } catch (e) {
//     print(e);
//   }
// }
}

// class DatabaseHelper {
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//   static Database? _database;
//   Future<Database> get database async => _database ??= await _initDatabase();

//   Future<Database> _initDatabase() async {
//     Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, 'cultural.db');
//     return await openDatabase(path, version: 1, onCreate: _onCreate);
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE cultural(
//         id INTEGER PRIMARY KEY,
//         title TEXT,
//         question TEXT
//       )
//       ''');
//   }

//   Future<List<CulturalHeritage>> getCultural() async {
//     Database db = await instance.database;
//     var cultural = await db.query('cultural', orderBy: 'title');
//     List<CulturalHeritage> culturalList = cultural.isEmpty
//         ? cultural.map((e) => CulturalHeritage.fromJson(e)).toList()
//         : [];
//     print(culturalList);
//     return culturalList;
//   }
// }