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
import 'package:socio_survey/json%20data/economy_data.dart';
import 'package:socio_survey/json%20data/transportation_data.dart';
import 'package:socio_survey/models/transportationQuestion.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:socio_survey/pages/physical%20infrastructure%20page/physical_infrastructure_page.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/widgets/contant_widget.dart';
import 'package:socio_survey/widgets/contants_question.dart';


class TransportationPage extends StatefulWidget {
  final String surveyId;

  TransportationPage({Key key, this.surveyId}) : super(key: key);

  @override
  _TransportationPageState createState() => _TransportationPageState();
}

class _TransportationPageState extends State<TransportationPage> {
  TextEditingController beforeCovid19Controller = TextEditingController();
  TextEditingController afterCovid19Controller = TextEditingController();
  TextEditingController selfOwnedController = TextEditingController();
  TextEditingController schoolDistanceController = TextEditingController();
  TextEditingController margetAndShoppingDistanceController =
      TextEditingController();
  TextEditingController hospitalAndHelthDistanceController =
      TextEditingController();
  TextEditingController parkAndCinemaDistanceController =
      TextEditingController();
  TextEditingController railwayDistanceController = TextEditingController();
  TextEditingController airportDistanceController = TextEditingController();
  TextEditingController bankDistanceController = TextEditingController();
  TextEditingController preferredModeController = TextEditingController();
  TextEditingController anyFurtherController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DeviceId deviceResponseTransport;
  String question1GroupValue;
  String question3GroupValue;
  String question6GroupValue;
  List question1Choices = ["Yes", "No"];
  List question2ChoicesCheckBox = [
    "Public Bus",
    "Private Car",
    "Shared Car",
    "Auto",
    "Two wheeler",
    "Rickshaw",
    "ToTo",
    "Others"
  ];
  List question2ChoicesCheckBoxValue = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List question3Choices = [
    "Public Bus",
    "Private Car",
    "Shared Car",
    "Auto",
    "Two wheeler",
    "Rickshaw",
    "If Others"
  ];
  List question4ChoicesCheckBox = [
    "2 Wheeler",
    "4 Wheeler",
    "Cycle",
    "Light and Heavy Vehicles",
    "None",
    "If Others, Specify"
  ];
  List question4ChoicesCheckBoxValue = [
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List question5Choices = [
    "Rickshaw",
    "2 Wheeler",
    "4 Wheeler",
    "Cycle",
    "Bus",
    "Walk"
  ];
  List question6Choices = [
    "Rickshaw",
    "2 Wheeler",
    "4 Wheeler",
    "Cycle",
    "Bus",
    "Walk"
  ];
  List question7Choices = [
    "Rickshaw",
    "2 Wheeler",
    "4 Wheeler",
    "Cycle",
    "Bus",
    "Walk"
  ];
  List question9Choices = [
    "Rickshaw",
    "2 Wheeler",
    "4 Wheeler",
    "Cycle",
    "Bus",
    "Walk"
  ];
  List question11Choices = [
    "Rickshaw",
    "2 Wheeler",
    "4 Wheeler",
    "Cycle",
    "Bus",
    "Walk"
  ];
  List question12Choices = [
    "Rickshaw",
    "2 Wheeler",
    "4 Wheeler",
    "Cycle",
    "Bus",
    "Walk"
  ];
  List question14Choices = [
    "Rickshaw",
    "2 Wheeler",
    "4 Wheeler",
    "Cycle",
    "Bus",
    "Walk"
  ];
  List question16Choices = [
    "Rickshaw",
    "2 Wheeler",
    "4 Wheeler",
    "Cycle",
    "Bus",
    "Walk"
  ];
  List question18Choices = [
    "Once in a year",
    "Once in 6 Months",
    "Once in 3 Months",
    "Every Month"
  ];
  List question19Choices = ["Within State", "Outside State"];
  List question21Choices = ["Yes", "No"];
  List question22Choices = ["Yes", "No"];
  List question23Choices = ["Yes", "No"];
  List question24Choices = ["Yes", "No"];
  List question25Choices = ["Yes", "No"];

  String question14GroupValue;
  String question9GroupValue;
  String question5GroupValue;
  String question7GroupValue;
  String question11GroupValue;
  String question12GroupValue;
  String question16GroupValue;
  String question18GroupValue;
  String question19GroupValue;
  String question21GroupValue;
  String question22GroupValue;
  String question23GroupValue;
  String question24GroupValue;
  String question25GroupValue;
  TextEditingController othersSpcify2 = TextEditingController();
  TextEditingController othersSpcify1 = TextEditingController();
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  Transportation transportation;
  TextEditingController _textEditingController = TextEditingController();
  Color valuew;
  String listToString2;
  String listToString1;
  String combine2;
  String combine1;
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
          print("Response===-----${response.body[1]}");
          print(response.body);
          deviceResponseTransport = DeviceId.fromJson(jsonDecode(response.body));
          print(deviceResponseTransport.data.length);
          print("test");
          print(deviceResponseTransport.data[0].surveyId);
          print(deviceResponseTransport.data[0]);
          print("-----${deviceResponseTransport.data[0].transportation_status}");
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
    preferences.setString("page", "/transportation_page");
  }

  setSelectedRadio({val, i}) {
    setState(() {
      transportation.question[i].ans = val;
    });
  }

  getAns() {
    print(transportation.question);
    transportation.question.forEach((element) {
      print(element.ans);
    });
  }

  bool showOthersQuis2 = false;
  bool showOthersQuis1 = false;

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

  final String title = 'Transportation';
  bool _isLoading = false;
  bool radiowithtext = true;
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
                return Center(child: Text('Loading....'));
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return TransportationPage1();
            }
          },
        );
      },
    );



  }

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
        "are_transportation_and_conveyance_facilities_satisfactory":
            question1GroupValue,
        "before_Covid19_the_most_preferred_mode_of_transport": "CheckBox",
        "after_covid19_the_most_preferred_mode_of_transport":
            question3GroupValue,
        "self_owned_vehicles": "CheckBox",
        "mode_of_transportation_prefer_for_school_or_college":
            question5GroupValue,
        "distance_for_school_college": schoolDistanceController.text,
        "mode_of_transportation_prefer_for_market_or_shopping_centre":
            question5GroupValue,
        "distance_for_market_or_shopping_centre":
            margetAndShoppingDistanceController.text,
        "mode_of_transportation_prefer_for_hospital_or_health_centre":
            question7GroupValue,
        "distance_for_hospital_or_health_centre":
            hospitalAndHelthDistanceController.text,
        "mode_of_transportation_prefer_for_parks_cinema_mall":
            question9GroupValue,
        "distance_for_parks_cinema_mall": parkAndCinemaDistanceController.text,
        "mode_of_transportation_for_railway_station_or_bus_terminal":
            question11GroupValue,
        "distance_for_railway_station_or_bus_terminal":
            railwayDistanceController.text,
        "mode_of_transportation_prefer_for_airport": question12GroupValue,
        "distance_for_airport": airportDistanceController.text,
        "mode_of_transportation_prefer_for_bank_or_postoffice":
            question16GroupValue,
        "distance_for_bank_or_postoffice": bankDistanceController.text,
        "how_often_do_you_travel_outstation": question18GroupValue,
        "location_of_outstation": question19GroupValue,
        "preferred_mode_of_transportation_for_outstation":
            preferredModeController.text,
        "are_there_any_signages_provided": question21GroupValue,
        "is_there_any_footpath_provided": question22GroupValue,
        "is_zebra_crossing_provided_near_junctions": question23GroupValue,
        "availability_of_cycle_track_and_pedestrian_pathway":
            question24GroupValue,
        "if_yes_is_the_path_shaded_with_trees": question25GroupValue,
        "any_further_suggestion_for_improvement": anyFurtherController.text,
        "transportation_status" :"1"



      };
      var dataUpdate = {
        "survey_id": surveyId,
        "are_transportation_and_conveyance_facilities_satisfactory":
        question1GroupValue,
        "before_Covid19_the_most_preferred_mode_of_transport": "CheckBox",
        "after_covid19_the_most_preferred_mode_of_transport":
        question3GroupValue,
        "self_owned_vehicles": "CheckBox",
        "mode_of_transportation_prefer_for_school_or_college":
        question5GroupValue,
        "distance_for_school_college": schoolDistanceController.text,
        "mode_of_transportation_prefer_for_market_or_shopping_centre":
        question5GroupValue,
        "distance_for_market_or_shopping_centre":
        margetAndShoppingDistanceController.text,
        "mode_of_transportation_prefer_for_hospital_or_health_centre":
        question7GroupValue,
        "distance_for_hospital_or_health_centre":
        hospitalAndHelthDistanceController.text,
        "mode_of_transportation_prefer_for_parks_cinema_mall":
        question9GroupValue,
        "distance_for_parks_cinema_mall": parkAndCinemaDistanceController.text,
        "mode_of_transportation_for_railway_station_or_bus_terminal":
        question11GroupValue,
        "distance_for_railway_station_or_bus_terminal":
        railwayDistanceController.text,
        "mode_of_transportation_prefer_for_airport": question12GroupValue,
        "distance_for_airport": airportDistanceController.text,
        "mode_of_transportation_prefer_for_bank_or_postoffice":
        question16GroupValue,
        "distance_for_bank_or_postoffice": bankDistanceController.text,
        "how_often_do_you_travel_outstation": question18GroupValue,
        "location_of_outstation": question19GroupValue,
        "preferred_mode_of_transportation_for_outstation":
        preferredModeController.text,
        "are_there_any_signages_provided": question21GroupValue,
        "is_there_any_footpath_provided": question22GroupValue,
        "is_zebra_crossing_provided_near_junctions": question23GroupValue,
        "availability_of_cycle_track_and_pedestrian_pathway":
        question24GroupValue,
        "if_yes_is_the_path_shaded_with_trees": question25GroupValue,
        "any_further_suggestion_for_improvement": anyFurtherController.text,
        "transportation_status" :"1"



      };


      // var response = await http.post(
      //     Uri.parse(
      //         'http://13.232.140.106:5000/rsi-field-force-api/transportation'),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: json.encode(data));
      //
      // // print(response.body);
      // String id = response.body;
      // print("Response====>$id");

      var response;
      var test = 2;
     if (deviceResponseTransport.data[0].transportation_status == "1" || deviceResponseTransport.data[0].transportation_status != null) {
       //if(test == 1){
        print("in if");
        print(data);
        response = await http.put(
            Uri.parse(
                'http://13.232.140.106:5000/rsi-field-force-api/transportation?survey_id=$surveyId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(dataUpdate));
        print(response.body);

      }
       else
        {
        print("in else");
        print(data);
        deviceResponseTransport.data[0].transportation_status = "1";
        response = await http.post(
            Uri.parse(
                'http://13.232.140.106:5000/rsi-field-force-api/transportation'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(data));
        print("Response ${response.body}");
      }


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

  Widget TransportationPage1() {
    return  Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
            child: QuestionBody(
              questionBody: Column(children: [
                const PageTitleWidget(
                  title: PageTitle.transportation,
                ),
                /*------Qusetion1------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName:
                            TransportationQuestion.areTransportationConveyance),
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
                /*------Qusetion2------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.beforeCovid),
                        for (var i = 0; i < question2ChoicesCheckBox.length; i++)
                          CheckboxListTile(
                              title: Text(
                                question2ChoicesCheckBox[i],
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              activeColor: Colors.deepOrangeAccent,
                              value: question2ChoicesCheckBoxValue[i],
                              onChanged: (value) {
                                setState(() {
                                  question2ChoicesCheckBoxValue[i] = value;
                                });
                                print(question2ChoicesCheckBox[i]);
                              }),
                        (question2ChoicesCheckBoxValue[7] &&
                            question2ChoicesCheckBox.contains("Others"))
                            ? TextFieldContainer(
                          controller: beforeCovid19Controller,
                          hint: "Enter Here",
                        )
                            : Container(),
                      ],
                    )),
                /*------Qusetion3------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.afterCovid),
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
                        if (question3GroupValue == "If Others")
                          TextFieldContainer(
                            controller: afterCovid19Controller,
                            hint: "Enter Text",
                          )
                      ],
                    )),
                /*------Qusetion4------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.selfOwendVehicle),
                        for (var i = 0; i < question4ChoicesCheckBox.length; i++)
                          CheckboxListTile(
                              activeColor: Colors.deepOrangeAccent,
                              title: Text(
                                question4ChoicesCheckBox[i],
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              value: question4ChoicesCheckBoxValue[i],
                              onChanged: (value) {
                                setState(() {
                                  question4ChoicesCheckBoxValue[i] = value;
                                });
                                print(question4ChoicesCheckBox[i]);
                              }),
                        (question4ChoicesCheckBoxValue[5] &&
                            question4ChoicesCheckBox.contains("If Others, Specify"))
                            ? TextFieldContainer(
                          controller: selfOwnedController,
                          hint: "Enter Here",
                        )
                            : Container(),
                      ],
                    )),
                /*------Qusetion5------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.modeSchoolAndCollege),
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
                      ],
                    )),
                /*------Qusetion6------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName:
                            TransportationQuestion.distanceSchoolAndCollege),
                        TextFieldContainer(
                          controller: schoolDistanceController,
                          inputType: TextInputType.number,
                          hint: "Enter Distance",
                        ),
                      ],
                    )),
                /*------Qusetion7------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.modeMargetAndShopping),
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
                /*------Qusetion8------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName:
                            TransportationQuestion.distanceMargetAndShopping),
                        TextFieldContainer(
                          controller: margetAndShoppingDistanceController,
                          inputType: TextInputType.number,
                          hint: "Enter Distance",
                        ),
                      ],
                    )),
                /*------Qusetion9------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.modeHospitalAndHelth),
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
                /*------Qusetion10------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName:
                            TransportationQuestion.distanceHospitalAndHelth),
                        TextFieldContainer(
                          controller: hospitalAndHelthDistanceController,
                          inputType: TextInputType.number,
                          hint: "Enter Distance",
                        ),
                      ],
                    )),
                /*------Qusetion11------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.modeParksAndCineme),
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
                /*------Qusetion12------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.distanceParksAndCineme),
                        TextFieldContainer(
                          controller: parkAndCinemaDistanceController,
                          inputType: TextInputType.number,
                          hint: "Enter Distance",
                        ),
                      ],
                    )),
                /*------Qusetion13------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.modeRailwayAndBus),
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
                /*------Qusetion14------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.distanceRailwayAndBus),
                        TextFieldContainer(
                          controller: railwayDistanceController,
                          inputType: TextInputType.number,
                          hint: "Enter Distance",
                        ),
                      ],
                    )),
                /*------Qusetion15------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.modeAirport),
                        for (var i = 0; i < question12Choices.length; i++)
                          RadioListTile(
                              tileColor: Colors.orangeAccent,
                              selectedTileColor: Colors.orangeAccent,
                              activeColor: Colors.deepOrange,
                              title: Text(
                                question12Choices[i].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              value: question12Choices[i].toString(),
                              groupValue: question12GroupValue,
                              onChanged: (val) {
                                setState(() {
                                  question12GroupValue = val.toString();
                                  print(question12GroupValue);
                                });
                              }),
                      ],
                    )),
                /*------Qusetion16------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.distanceAirport),
                        TextFieldContainer(
                          controller: airportDistanceController,
                          inputType: TextInputType.number,
                          hint: "Enter Distance",
                        ),
                      ],
                    )),
                /*------Qusetion17------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.modeBankAndPost),
                        for (var i = 0; i < question16Choices.length; i++)
                          RadioListTile(
                              tileColor: Colors.orangeAccent,
                              selectedTileColor: Colors.orangeAccent,
                              activeColor: Colors.deepOrange,
                              title: Text(
                                question16Choices[i].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              value: question16Choices[i].toString(),
                              groupValue: question16GroupValue,
                              onChanged: (val) {
                                setState(() {
                                  question16GroupValue = val.toString();
                                  print(question16GroupValue);
                                });
                              }),
                      ],
                    )),
                /*------Qusetion18------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.distanceBankAndPost),
                        TextFieldContainer(
                          controller: bankDistanceController,
                          inputType: TextInputType.number,
                          hint: "Enter Distance",
                        ),
                      ],
                    )),
                /*------Qusetion19------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.howOftenTravel),
                        for (var i = 0; i < question18Choices.length; i++)
                          RadioListTile(
                              tileColor: Colors.orangeAccent,
                              selectedTileColor: Colors.orangeAccent,
                              activeColor: Colors.deepOrange,
                              title: Text(
                                question18Choices[i].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              value: question18Choices[i].toString(),
                              groupValue: question18GroupValue,
                              onChanged: (val) {
                                setState(() {
                                  question18GroupValue = val.toString();
                                  print(question18GroupValue);
                                });
                              }),
                      ],
                    )),
                /*------Qusetion20------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.locationOutstation),
                        for (var i = 0; i < question19Choices.length; i++)
                          RadioListTile(
                              tileColor: Colors.orangeAccent,
                              selectedTileColor: Colors.orangeAccent,
                              activeColor: Colors.deepOrange,
                              title: Text(
                                question19Choices[i].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              value: question19Choices[i].toString(),
                              groupValue: question19GroupValue,
                              onChanged: (val) {
                                setState(() {
                                  question19GroupValue = val.toString();
                                  print(question19GroupValue);
                                });
                              }),
                      ],
                    )),
                /*------Qusetion21------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName:
                            TransportationQuestion.preferredTransportationOutation),
                        TextFieldContainer(
                          controller: preferredModeController,
                          hint: "Enter Text",
                        ),
                      ],
                    )),
                /*------Qusetion22------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.signageProvided),
                        for (var i = 0; i < question21Choices.length; i++)
                          RadioListTile(
                              tileColor: Colors.orangeAccent,
                              selectedTileColor: Colors.orangeAccent,
                              activeColor: Colors.deepOrange,
                              title: Text(
                                question21Choices[i].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              value: question21Choices[i].toString(),
                              groupValue: question21GroupValue,
                              onChanged: (val) {
                                setState(() {
                                  question21GroupValue = val.toString();
                                  print(question21GroupValue);
                                });
                              }),
                      ],
                    )),
                /*------Qusetion23------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.footpathProvided),
                        for (var i = 0; i < question22Choices.length; i++)
                          RadioListTile(
                              tileColor: Colors.orangeAccent,
                              selectedTileColor: Colors.orangeAccent,
                              activeColor: Colors.deepOrange,
                              title: Text(
                                question22Choices[i].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              value: question22Choices[i].toString(),
                              groupValue: question22GroupValue,
                              onChanged: (val) {
                                setState(() {
                                  question22GroupValue = val.toString();
                                  print(question22GroupValue);
                                });
                              }),
                      ],
                    )),
                /*------Qusetion24------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.zebraCrossingProvided),
                        for (var i = 0; i < question23Choices.length; i++)
                          RadioListTile(
                              tileColor: Colors.orangeAccent,
                              selectedTileColor: Colors.orangeAccent,
                              activeColor: Colors.deepOrange,
                              title: Text(
                                question23Choices[i].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              value: question23Choices[i].toString(),
                              groupValue: question23GroupValue,
                              onChanged: (val) {
                                setState(() {
                                  question23GroupValue = val.toString();
                                  print(question23GroupValue);
                                });
                              }),
                      ],
                    )),
                /*------Qusetion25------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.pedestrianPathway),
                        for (var i = 0; i < question24Choices.length; i++)
                          RadioListTile(
                              tileColor: Colors.orangeAccent,
                              selectedTileColor: Colors.orangeAccent,
                              activeColor: Colors.deepOrange,
                              title: Text(
                                question24Choices[i].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              value: question24Choices[i].toString(),
                              groupValue: question24GroupValue,
                              onChanged: (val) {
                                setState(() {
                                  question24GroupValue = val.toString();
                                  print(question24GroupValue);
                                });
                              }),
                      ],
                    )),
                if (question24GroupValue == "Yes")
                /*------Qusetion26------*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(
                              questionName: TransportationQuestion.ifYesShadedTrees),
                          for (var i = 0; i < question25Choices.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  question25Choices[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: question25Choices[i].toString(),
                                groupValue: question25GroupValue,
                                onChanged: (val) {
                                  setState(() {
                                    question25GroupValue = val.toString();
                                    print(question25GroupValue);
                                  });
                                }),
                        ],
                      )),
                /*------Qusetion27------*/
                QuestionContainer(
                    child: Column(
                      children: [
                        const QuestionName(
                            questionName: TransportationQuestion.anyFurtherImprovement),
                        TextFieldContainer(
                          controller: anyFurtherController,
                          hint: "Enter Text",
                        ),
                      ],
                    )),
                /*submit button*/
                ButtonSaveAndContinue(
                  onPress: () {
                    setState(() {
                      print("====>$question1GroupValue");
                      Navigator.pushNamed(context, "/physicalInfrastructure_page");
                      postMethod();
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                /*Back button*/
                ButtonBack(onPress: () async {
                  print("====>$question1GroupValue");
                  SharedPreferences _pref = await SharedPreferences.getInstance();
                  final String statusOf = _pref.getString('survey_status');
                  if (statusOf == "pending_survey")
                  {
                    Navigator.pushNamed(context,'/economyAndIndustries_page');
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
              ]),
            )),
      ),
    );
  }

  // sendTransportationData() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/transportation'),
  //         body: {
  //           "transportation_conveyance_facilities_satisfactory":
  //               transportation.question[0].ans.toString(),
  //           "before_covid19_most_preferred_mode_of_transport":
  //               transportation.question[1].ans.toString(),
  //           "after_covid19_most_preferred_mode_of_transport":
  //               transportation.question[2].ans.toString(),
  //           "self_owned_vehicles": transportation.question[3].ans.toString(),
  //           "mode_of_transportation_for_school_college":
  //               transportation.question[4].ans.toString(),
  //           "mode_of_transportation_for_market_shoppingcenter":
  //               transportation.question[5].ans.toString(),
  //           "mode_of_transportation_for_hospital_healthcare":
  //               transportation.question[6].ans.toString(),
  //           "mode_of_transportation_for_parks_cinema_mall":
  //               transportation.question[7].ans.toString(),
  //           "mode_of_transportation_for_railwaystation_bus":
  //               transportation.question[8].ans.toString(),
  //           "mode_of_transportation_for_terminal":
  //               transportation.question[9].ans.toString(),
  //           "mode_of_transportation_for_airport":
  //               transportation.question[10].ans.toString(),
  //           "mode_of_transportation_for_bank_postoffice":
  //               transportation.question[11].ans.toString(),
  //           "how_often_do_you_travel_outstation":
  //               transportation.question[12].ans.toString(),
  //           "oustation_location": transportation.question[13].ans.toString(),
  //           "preferred_mode_of_transportation":
  //               transportation.question[14].ans.toString(),
  //           "are_there_any_signages_provided":
  //               transportation.question[15].ans.toString(),
  //           "is_there_any_footpath_provided":
  //               transportation.question[16].ans.toString(),
  //           "is_zebra_crossing_provided_near_junctions":
  //               transportation.question[17].ans.toString(),
  //           "availability_of_cycle_track_pedestrain_pathway":
  //               transportation.question[18].ans.toString(),
  //           "is_the_path_shaded_with_trees":
  //               transportation.question[19].ans.toString(),
  //           "any_further_suggestion_for_improvement":
  //               transportation.question[20].ans.toString()
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
