import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:socio_survey/components/getdevice_id.dart';
import 'package:socio_survey/dbHelper/dbHelper.dart';
import 'package:socio_survey/json%20data/housing_data.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/models/HousingQuestion.dart';
import 'package:socio_survey/pages/Economy%20and%20Industries%20page/economy_and_indu_page.dart';
import 'package:socio_survey/pages/householdprofilepage/household_profile_page.dart';
import 'package:socio_survey/widgets/contant_widget.dart';
import 'package:socio_survey/widgets/contants_question.dart';

var isDataAvailble = false;

DeviceId housingPageResponse;



class HousingPage extends StatefulWidget {
  final DeviceId surveyId;
  HousingPage({Key key, this.surveyId}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  TextEditingController othersSpcify = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController wallController = TextEditingController();
  TextEditingController roofController = TextEditingController();
  TextEditingController rentedAmountController = TextEditingController();
  TextEditingController approxPriceRangeController = TextEditingController();
  TextEditingController landPropertyController = TextEditingController();
  TextEditingController residentialBuildingController = TextEditingController();
  TextEditingController cookingFuelController = TextEditingController();
  List question1Choices = [
    "Semi Pukka House",
    "Pukka House",
    "Kaccha House",
    "Individual House",
    "Apartment"
  ];
  List question2Choices = [
    "Single Storied (G+0)",
    "Two Storied (G+1)",
    "3 Storied (G+2)",
    "Multi Storied (G+3 and above)"
  ];
  List question3Choices1 = [
    "Brick/ Stone",
    "Mud blocks/Bamboo",
    "Others, Specify"
  ];
  List question3Choices2 = ["RCC", "Tin", "Tiles", "Others, Specify"];
  List question5Choices = ["Good", "Average", "Poor"];
  List question4Choices = [
    "0 - 5 Yrs",
    "5 -15 Yrs",
    "15 – 25 Yrs",
    "More than 25 yrs"
  ];
  List question6Choices = ["Self-owned", "Rented"];
  List question7Choices = ["Yes", "No"];
  List question9Choices = ["Yes", "No"];
  List question12Choices = ["Yes", "No"];
  String question1GroupValue;
  String question2GroupValue;
  String question3GroupValue1;
  String question3GroupValue2;
  String question5GroupValue;
  String question4GroupValue;
  String question6GroupValue;
  String question7GroupValue;
  String question9GroupValue;
  String question12GroupValue;
  String question15GroupValue;
  String residingBuildingVal="";
  List question13Choices = [
    "Self Use",
    "Rent purpose",
    "Shop/Commercial",
    "Manufacturing Activity",
    "Government Office",
    "Private Office",
    "Other Specify"
  ];
  List question14Choices = [
    "Refrigerator",
    "Telephone / Mobile Phone",
    "Computer / Laptop",
    "Television",
    "A.C",
    "Geyser",
    "Electric Mixer / Grinder",
    "Washing Machine",
    "Tape Recorder / CD player"
  ];
  List question15Choices = [
    "Cooking Gas / LPG",
    "Firewood",
    "Electric Induction",
    "Kerosene",
    "Cooking Coal",
    "If Other, Specify"
  ];
  List question13ChoicesValue = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List question14ChoicesValue = [
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
  Housing housing;

  bool selectedCheckBox = false;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  bool isShow = false;
  String listToString;
  String combine;
  Future futureData;

  @override
  void initState() {
    setState(() {
      futureData =  checkStatus();
    });

    print("Calling initState");
  }

  Future checkStatus() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final String statusOf = _pref.getString('survey_status');
    print(statusOf);
    if (_pref.getString("survey_id") != null) {
       final id = _pref.getString("survey_id");
       print("id====>${id}");
      //final id = "D72S16";
      try {
        final response = await http.get(Uri.parse(
            "http://13.232.140.106:5000/rsi-field-force-api/survey/get-individual-survey-details?survey_id=$id"));
        if (response.statusCode == 200) {
          print("Response===-----${response.body}");
          housingPageResponse = DeviceId.fromJson(jsonDecode(response.body));
          print(housingPageResponse.data.length);
          print("test");
          print(housingPageResponse.data[0].surveyId);
          print(housingPageResponse.data[0]);
          if (statusOf == "pending_survey") {
          setValuesToForm();
          }
          //return response.body;
          //return DeviceId.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Failed to load Data');
        }
      } catch (e) {
        print("error" + e.toString());
      }
    }
  }

  void setValuesToForm() {
    // var json = housingData;
    // housing = Housing.fromJson(json);
    // setState(() {
    //   connectivityCheck.startMonitoring();
    //   //print(housing?.toJson());
    //   page();
    // });
    // super.initState();
    // assetCheckBox();
    // residentialBuildingCheckbox();
    print(
        "============>${housingPageResponse.data[0].roof}<==================");
    /*1.Type of House*/

    question1GroupValue = setDataToRb(housingPageResponse.data[0].type_of_house);
    question2GroupValue = setDataToRb(housingPageResponse.data[0].number_of_floors);
    question4GroupValue = setDataToRb(housingPageResponse.data[0].age_of_house);
    question5GroupValue = setDataToRb(housingPageResponse.data[0].house_condition);
    question6GroupValue = setDataToRb(housingPageResponse.data[0].ownership_type);
    question7GroupValue = setDataToRb(housingPageResponse.data[0].land_ownership);
    question9GroupValue = setDataToRb(housingPageResponse.data[0].do_you_have_any_other_land_property);
    question12GroupValue = setDataToRb(housingPageResponse.data[0].if_no_are_you_willing_to_buy);
    question3GroupValue1 = setRbAndText(question3Choices1,housingPageResponse.data[0].wall,wallController,"Others, Specify");
    question3GroupValue2 = setRbAndText(question3Choices2,housingPageResponse.data[0].roof,roofController,"Others, Specify");
    question15GroupValue = setRbAndText(question15Choices,housingPageResponse.data[0].cooking_fuel_used_in_the_kitchen,cookingFuelController,"If Other, Specify");
    setTxtEditValue(housingPageResponse.data[0].if_rented_amount,rentedAmountController);
    setTxtEditValue(housingPageResponse.data[0].approx_price_range_of_land_per_katha,approxPriceRangeController);

    // if (housingPageResponse.data[0].if_rented_amount != null) {
    //   rentedAmountController.text = housingPageResponse.data[0].if_rented_amount;
    // }


    // if (housingPageResponse.data[0].roof != null) {
    //   print(housingPageResponse.data[0].roof);
    //   if(question3Choices2.contains(housingPageResponse.data[0].roof)){
    //     question3GroupValue2 = housingPageResponse.data[0].roof;
    //   }else{
    //     question3GroupValue2 = "Others, Specify";
    //     roofController.text =  housingPageResponse.data[0].roof;
    //   }
    // }

    // if (housingPageResponse.data[0].cooking_fuel_used_in_the_kitchen != null) {
    //   print(housingPageResponse.data[0].cooking_fuel_used_in_the_kitchen);
    //   if(question15Choices.contains(housingPageResponse.data[0].cooking_fuel_used_in_the_kitchen)){
    //     question15GroupValue = housingPageResponse.data[0].cooking_fuel_used_in_the_kitchen;
    //   }else{
    //     question15GroupValue = "If Other, Specify";
    //     cookingFuelController.text =  housingPageResponse.data[0].cooking_fuel_used_in_the_kitchen;
    //   }
    // }


    print(
        "============>${housingPageResponse.data[0].usage_of_residential_building_text}<==================");
    print("============>${housingPageResponse.data[0].usage_of_residential_building_text}<==================");

    // if(housingPageResponse.data[0].usage_of_residential_building_text!= null){
    //  residentialBuildingController.text = housingPageResponse.data[0].usage_of_residential_building_text;
    // }

    final tagName = housingPageResponse.data[0].asset_owned_by_household;
    final split = tagName.split(',');
    final Map<int, String> values = {
      for (int i = 0; i < split.length; i++)
        i: split[i]
    };

    for(int i = 0;i<values.length;i++){
      print(question14Choices.indexOf(values[i]));
      int temp =  question14Choices.indexOf(values[i]);
      question14ChoicesValue[temp]=true;
    }
    final tagName1 = housingPageResponse.data[0].usage_of_residential_building;
    final split1 = tagName1.split(',');
    final Map<int, String> values1 = {
      for (int i = 0; i < split1.length; i++)
        i: split1[i]
    };
    for(int i = 0;i<values1.length;i++){
      print(question13Choices.indexOf(values1[i]));
      int temp =  question13Choices.indexOf(values1[i]);
      question13ChoicesValue[temp]=true;
    }


  }
  bool visibility = false;
  bool visibility1 = false;

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/housing_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      housing.question[i].ans = val;
    });
  }

  subSetSelectedRadio(val, i, l) {
    setState(() {
      housing.question[i].subqunts[l].ans = val;
    });
  }

  bool showOthersQuis = false;

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

  var tmpArray = [];
  var tmpArray1 = [];
  String onChagedValue;
  final String title = 'Housing page';
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
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

              return HousingPage1();
        }
      },
    );



  }

  Widget otherSpecifyFun() {
    return TextField(
      controller: othersSpcify,
    );
  }

  Future postMethod() async {

    print("residingBuildingVal${residingBuildingVal}");
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    final deviceId = _preferences.getString('D_id');
    final surveyId =
    _preferences.getString('survey_id');

    var qtn13Str = "";
    var qtn14Str = "";

    qtn13Str = getCheckBoxValues(question13Choices,question13ChoicesValue);
    qtn14Str = getCheckBoxValues(question14Choices,question14ChoicesValue);

    print("test----{$qtn13Str}");
    print("test----{$qtn14Str}");
    try {
      var data = {
        "survey_id": surveyId,
        "type_of_house": question1GroupValue,
        "number_of_floors": question2GroupValue,
        "wall": question3GroupValue1,
        "roof": question3GroupValue2,
        "age_of_house": question4GroupValue,
        "house_condition": question5GroupValue,
        "ownership_type": question6GroupValue,
        "if_rented_amount": rentedAmountController.text,
        "land_ownership": question7GroupValue,
        "approx_price_range_of_land_per_katha": approxPriceRangeController.text,
        "do_you_have_any_other_land_property": question9GroupValue,
        "if_yes_where": landPropertyController.text,
        "if_no_are_you_willing_to_buy": question12GroupValue,
        "usage_of_residential_building": qtn13Str,
        "usage_of_residential_building_text": residingBuildingVal,
        "asset_owned_by_household": qtn14Str,
        "cooking_fuel_used_in_the_kitchen": question15GroupValue,
        "housing_status": "1"
      };
      var dataUpdate = {
       // "survey_id": surveyId,
        "type_of_house": question1GroupValue,
        "number_of_floors": question2GroupValue,
        "wall": question3GroupValue1,
        "roof": question3GroupValue2,
        "age_of_house": question4GroupValue,
        "house_condition": question5GroupValue,
        "ownership_type": question6GroupValue,
        "if_rented_amount": rentedAmountController.text,
        "land_ownership": question7GroupValue,
        "approx_price_range_of_land_per_katha": approxPriceRangeController.text,
        "do_you_have_any_other_land_property": question9GroupValue,
        "if_yes_where": landPropertyController.text,
        "if_no_are_you_willing_to_buy": question12GroupValue,
        "usage_of_residential_building": qtn13Str,
        "usage_of_residential_building_text": residingBuildingVal,
        "asset_owned_by_household": qtn14Str,
        "cooking_fuel_used_in_the_kitchen": question15GroupValue,
        "housing_status": "1"
      };
      var response;
      if (housingPageResponse.data[0].housing_status == "1" && housingPageResponse.data[0].housing_status != null) {
        print("in if");
        response = await http.put(
            Uri.parse(
                'http://13.232.140.106:5000/rsi-field-force-api/housing?survey_id=$surveyId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(dataUpdate));
        // print(response.body);
        String id = response.body;
        print("Response====>$id");
      } else {
        housingPageResponse.data[0].housing_status = "1";
        print("in else");
        var bodyEncoded = json.encode(data);
        response = await http.post(
            Uri.parse('http://13.232.140.106:5000/rsi-field-force-api/housing'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: bodyEncoded);
        String id = response.body;
        print("Response====>$id");
      }
    } catch (e) {
      print(e);
    }
  }


  Widget HousingPage1() {
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
                    title: PageTitle.housing,
                  ),
                  /*------Qusetion1------*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(questionName: HousingQuestion.typeOfHouse),
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
                            questionName: HousingQuestion.numberOfFloors),
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
                    ),
                  ),

                  /*------Qusetion3------*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(questionName: HousingQuestion.materialUsed),
                          /*sub1 */
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: QuestionName(questionName: HousingQuestion.wall),
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
                          if (question3GroupValue1 == "Others, Specify")
                            TextFieldContainer(
                              controller: wallController,
                              hint: "Enter Text",
                            ),

                          //sub2
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: QuestionName(questionName: HousingQuestion.roof),
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
                          if (question3GroupValue2 == "Others, Specify")
                            TextFieldContainer(
                              controller: roofController,
                              hint: "Enter Text",
                            ),
                        ],
                      )),

                  /*------Qusetion4------*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(questionName: HousingQuestion.ageOfHouse),
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
                          const QuestionName(
                              questionName: HousingQuestion.houseCondition),
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
                          const QuestionName(questionName: HousingQuestion.ownerShipType),
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
                  if (question6GroupValue == "Rented")
                    QuestionContainer(
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const QuestionName(
                                questionName: HousingQuestion.ifRentedAmount),
                            TextFieldContainer(
                              controller: rentedAmountController,
                              hint: "Enter Amount",
                              inputType: TextInputType.number,
                              onChange: (val) {
                                question6GroupValue = rentedAmountController.text;
                              },
                            ),
                          ],
                        )),
                  QuestionContainer(
                      child: Column(
                        children: [
                          const QuestionName(questionName: HousingQuestion.landOwnerShip),
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
                  /*------Qusetion9------*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          QuestionName(questionName: HousingQuestion.approxPriceRange),
                          TextFieldContainer(
                            controller: approxPriceRangeController,
                            hint: "Enter Price Range",
                            inputType: TextInputType.number,
                          ),
                        ],
                      )),
                  /*------Qusetion10------*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          QuestionName(
                              questionName: HousingQuestion.doYouHaveLandProperty),
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
                  if (question9GroupValue == "Yes")
                    QuestionContainer(
                        child: Column(
                          children: [
                            QuestionName(questionName: HousingQuestion.ifYesWhere),
                            TextFieldContainer(
                              controller: landPropertyController,
                              hint: "Enter Here",
                              onChange: (val) {
                                question9GroupValue = landPropertyController.text;
                              },
                            ),
                          ],
                        )),
                  if (question9GroupValue == "No")
                    QuestionContainer(
                        child: Column(
                          children: [
                            QuestionName(questionName: HousingQuestion.ifNoWillingBuy),
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
                  /*------question12------*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          QuestionName(
                              questionName: HousingQuestion.usageResidentialBuilding),
                          for (var i = 0; i < question13Choices.length; i++)
                            CheckboxListTile(
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  question13Choices[i],
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: question13ChoicesValue[i],
                                onChanged: (value) {
                                  setState(() {
                                    question13ChoicesValue[i] = value;
                                  });
                                  print(question13Choices[i]);
                                }),
                          (question13ChoicesValue[6] &&
                              question13Choices.contains("Other Specify"))
                              ? TextFieldContainer(
                            controller: residentialBuildingController,
                            hint: "Enter Text",

                          )
                              : Container(),
                        ],
                      )),

                  /*------question13------*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          QuestionName(questionName: HousingQuestion.assetOwnedHouseHold),
                          for (var i = 0; i < question14Choices.length; i++)
                            CheckboxListTile(
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  question14Choices[i],
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: question14ChoicesValue[i],
                                onChanged: (value) {
                                  setState(() {
                                    question14ChoicesValue[i] = value;
                                  });
                                  print(question14Choices[i]);
                                }),
                        ],
                      )),

                  /*------Qusetion12------*/
                  QuestionContainer(
                      child: Column(
                        children: [
                          QuestionName(questionName: HousingQuestion.cookingFuelKitchen),
                          for (var i = 0; i < question15Choices.length; i++)
                            RadioListTile(
                                tileColor: Colors.orangeAccent,
                                selectedTileColor: Colors.orangeAccent,
                                activeColor: Colors.deepOrange,
                                title: Text(
                                  question15Choices[i].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                value: question15Choices[i].toString(),
                                groupValue: question15GroupValue,
                                onChanged: (val) {
                                  setState(() {
                                    question15GroupValue = val.toString();
                                    print(question15GroupValue);
                                  });
                                }),
                          if (question15GroupValue == "If Other, Specify")
                            TextFieldContainer(
                              controller: cookingFuelController,
                              hint: "Enter Text",
                              onChange: (val) {
                                question15GroupValue = cookingFuelController.text;
                              },
                            )
                        ],
                      )),
                  /*submit button*/
                  ButtonSaveAndContinue(
                    onPress: () async {
                      if (question15GroupValue == "If Other, Specify"){
                        question15GroupValue = cookingFuelController.toString();
                      }else{
                        wallController.text = "";
                      }
                      if (question3GroupValue2 == "Others, Specify"){
                        question3GroupValue2 = roofController.text;
                      }else{
                        wallController.text = "";
                      }
                      if (question3GroupValue1 == "Others, Specify"){
                        question3GroupValue1 = wallController.text;
                      }else{
                        wallController.text = "";
                      }
                      if(question13ChoicesValue[6]){
                        residingBuildingVal = residentialBuildingController.text;
                      }

                      await postMethod();
                      Navigator.pushNamed(context, "/economyAndIndustries_page");
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  /*Back button*/
                  ButtonBack(onPress: () {
                    Navigator.pushNamed(context, "/household_profile");
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
            )),
      ),
    );
  }

  getCheckBoxValues(List qtnchoices,List qtnChoicesValue) {
    String cbVal= "";
    for(int i = 0; i<qtnchoices.length;i++){
      if(qtnChoicesValue[i]){
        cbVal = cbVal + qtnchoices[i]+",";
      }
    }
    if (cbVal.endsWith(",")) {
      cbVal = cbVal.substring(0, cbVal.length - 1);
    }
    return cbVal;
  }

  setDataToRb(String dataFromApi) {
    String rbValue ="";
    if(dataFromApi != null){
      rbValue = dataFromApi;
    }
    return rbValue;
  }



  setRbAndText(List list, String dataFromAPi, TextEditingController textController, String option) {
    String temp = "";
    if (dataFromAPi != null) {
      print(dataFromAPi);
      if(list.contains(dataFromAPi)){
        temp = dataFromAPi;
      }else{
        temp = option;
        question3GroupValue1 = temp;
        textController.text =  dataFromAPi;
      }
    }
    print("temp${temp}");
    return temp;
  }

  void setTxtEditValue(String dataFromApi, TextEditingController txtEditController) {
    if (dataFromApi != null) {
      txtEditController.text = dataFromApi;
    }
  }


}
