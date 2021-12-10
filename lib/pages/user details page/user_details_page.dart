import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:socio_survey/components/getdevice_id.dart';
import 'package:socio_survey/dbHelper/dbHelper.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/components/textfield_container.dart';
import 'package:socio_survey/components/userFields.dart';
import 'package:socio_survey/pages/householdprofilepage/household_profile_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/pages/user%20details%20page/userPost.dart';
import 'package:socio_survey/pages/user%20details%20page/userdetails_api.dart';
import 'package:native_state/native_state.dart';
import 'package:socio_survey/service%20model/user_details_model_api.dart';

const String route = "/user_details";


class UserDetailsBuilder extends StatefulWidget {
  UserDetailsBuilder({Key key}) : super(key: key);

  @override
  _UserDetailsBuilderState createState() => _UserDetailsBuilderState();
}

class _UserDetailsBuilderState extends State<UserDetailsBuilder> {
  Future futureData;

  TextEditingController _localityController = TextEditingController();
  TextEditingController _wardController = TextEditingController();
  TextEditingController _totalMemberController = TextEditingController();
  TextEditingController _familyHeadNameController =
  TextEditingController();
  TextEditingController _maleController = TextEditingController();
  TextEditingController _femaleController = TextEditingController();
  TextEditingController _illiterateMemberController =
  TextEditingController();
  TextEditingController _casteController = TextEditingController();
  TextEditingController _religionController = TextEditingController();
  TextEditingController _minorityStatusController =
  TextEditingController();
  TextEditingController _mobileNumberController =
  TextEditingController();

  bool _isLoading = false;
  Connectivity _connectivity = new Connectivity();

  bool _isOnline;
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    //setvalues();
    super.initState();
  }

  getPendingSyrvey() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final survey = _pref.getString("survey_id");
    futureData = getDataById(survey);
    print("=======>$survey");
  }

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
            return UserDetailsWidget();
        }
      },
    );
  }

  Future getDataById(id) async {
    final response = await http.get(Uri.parse(
        "http://13.232.140.106:5000/rsi-field-force-api/survey/get-individual-survey-details?survey_id=$id"));
    if (response.statusCode == 200) {
      print("Response===${response.body}");
      return DeviceId.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }



  Widget UserDetailsWidget() {
    return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
            child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xfff6e45e1), Color(0xfff89d4cf)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 36, horizontal: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RSI FieldForce",
                                style: GoogleFonts.quicksand(
                                    fontSize: 55.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "User Details",
                                style: GoogleFonts.quicksand(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    NumberTextFieldContainer(
                                      labelText: 'Mobile Number',
                                      textController: _mobileNumberController,
                                      onChange: (value) {},
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    UserDetailsTextFieldContainer(
                                      labelText: 'Name of Locality',
                                      textController: _localityController,
                                      onChange: (value) {},
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    NumberTextFieldContainer(
                                      labelText: 'Ward',
                                      textController: _wardController,
                                      onChange: (value) {},
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    NumberTextFieldContainer(
                                      labelText: 'Total No of Members',
                                      textController: _totalMemberController,
                                      onChange: (value) {},
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    UserDetailsTextFieldContainer(
                                      labelText: 'Full Name of family head',
                                      textController: _familyHeadNameController,
                                      onChange: (value) {},
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    NumberTextFieldContainer(
                                      labelText: 'Total No of Males',
                                      textController: _maleController,
                                      onChange: (value) {},
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    NumberTextFieldContainer(
                                      labelText: 'Total No of Females',
                                      textController: _femaleController,
                                      onChange: (value) {},
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    NumberTextFieldContainer(
                                      labelText:
                                      'Total No of Illiterate Members',
                                      textController:
                                      _illiterateMemberController,
                                      onChange: (value) {},
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    UserDetailsTextFieldContainer(
                                      labelText: 'Caste',
                                      textController: _casteController,
                                      onChange: (value) {},
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    UserDetailsTextFieldContainer(
                                      labelText: 'Religion',
                                      textController: _religionController,
                                      onChange: (value) {},
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    UserDetailsTextFieldContainer(
                                      labelText: 'Minority Status',
                                      textController: _minorityStatusController,
                                      onChange: (value) {},
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xff8E2DE2),
                                      ),
                                      child: FlatButton(
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();

                                            Map<String, String> userData =
                                            Map();
                                            userData['USER DETAILS'] = '';
                                            userData['Name of Locality'] =
                                                _localityController.text;
                                            userData['Ward'] =
                                                _wardController.text;
                                            userData['Total No of Member'] =
                                                _totalMemberController.text;
                                            userData[
                                            'Full Name of family head'] =
                                                _familyHeadNameController.text;
                                            userData['Male'] =
                                                _maleController.text;
                                            userData['Female'] =
                                                _femaleController.text;
                                            userData['Illiterate Member'] =
                                                _illiterateMemberController
                                                    .text;
                                            userData['Caste'] =
                                                _casteController.text;
                                            userData['Religion'] =
                                                _religionController.text;
                                            userData['Minority Status'] =
                                                _minorityStatusController.text;


                                            await postMethod();

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HouseHoldPofilePage()));


                                            // final sId = preferences
                                            //     .getString("survey_id");
                                            // final city = preferences
                                            //     .getString("city");
                                            // userData.forEach(
                                            //         (key, value) async {
                                            //       await DbHelper.instance
                                            //           .insertData(
                                            //           answer: value,
                                            //           city: city,
                                            //           surveyId: sId,
                                            //           question: key);
                                            //     });


                                          } else {
                                            showSnackBar();
                                          }
                                        },
                                        height: 50,
                                        minWidth: 250,
                                        textColor: Colors.white,
                                        child: _isLoading
                                            ? Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Loading..",
                                              style:
                                              GoogleFonts.quicksand(
                                                  fontSize: 18.0),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          ],
                                        )
                                            : Text("Take Survey",
                                            style: GoogleFonts.quicksand(
                                                fontSize: 22.0)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ))));
  }

  Future postMethod() async {
    try {
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      final deviceId = _preferences.getString('D_id');
      final surveyId = _preferences.getString("survey_id");
      print(
          "Printing New Survey Id ======>${_preferences.getString("survey_id")}");
      final cityPref = _preferences.getString('city');

      var data = {
        "devices_id": deviceId,
        "survey_id": surveyId,
        "city": cityPref,
        "phone_no": _mobileNumberController.text,
        "name_of_locality": _localityController.text,
        "ward": _wardController.text,
        "total_no_of_members": _totalMemberController.text,
        "full_name_of_family_head": _familyHeadNameController.text,
        "total_no_of_males": _maleController.text,
        "total_no_of_females": _femaleController.text,
        "total_no_of_illiterate_members": _illiterateMemberController.text,
        "caste": _casteController.text,
        "religion": _religionController.text,
        "minority_status": _minorityStatusController.text,
        "user_family_status": "1"
      };
      var response = await http.post(
          Uri.parse(
              'http://13.232.140.106:5000/rsi-field-force-api/user-family'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(data));

      // print(response.body);
      String id = response.body;

      var res = jsonDecode(response.body);
      print(res["status"]);


      //Success function
      // if(res["status"]){
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) =>
      //               HouseHoldPofilePage()));
      // }else{
      //
      // }


      print("Response====>$id");
    } catch (e) {
      print(e);
    }
  }
  void setvalues() {
    _mobileNumberController.text = "9999999990";
    _localityController..text = "test_skein";
    _wardController..text = "9";
    _totalMemberController..text = "9";
    _familyHeadNameController..text = "9";
    _maleController..text ="9";
    _femaleController..text = "9";
    _illiterateMemberController..text = "9";
    _casteController..text = "xx";
    _religionController..text = "yy";
    _minorityStatusController..text = "zz";
  }

  void showSnackBar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'All fields are mandatory .*',
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
}