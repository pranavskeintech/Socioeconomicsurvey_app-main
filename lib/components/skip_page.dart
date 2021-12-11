import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socio_survey/pages/Coastal%20Page/coastal_page.dart';
import 'package:socio_survey/pages/slums%20page/slums_page.dart';

class SkipPage extends StatefulWidget {
  final surveyId;

  SkipPage({Key key, this.surveyId}) : super(key: key);

  @override
  _SkipPageState createState() => _SkipPageState();
}

class _SkipPageState extends State<SkipPage> {
  bool visbilty = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(gradient: LinearGradient(colors: [Color(0xfff6e45e1), Color(0xfff89d4cf)], begin: Alignment.centerLeft, end: Alignment.centerRight)),
        child: visbilty
            ? Container(
                margin: EdgeInsets.only(top: 150, bottom: 150, left: 15, right: 15),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Are you Living in Slum ?",
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                          ),
                        )),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: Colors.grey,
                      ),
                      child: FlatButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, "/slums_page");
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SlumsPage(surveyId: widget.surveyId,)));
                          },
                          height: 50,
                          minWidth: 250,
                          textColor: Colors.white,
                          child: Text(
                            "Yes",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: Colors.grey,
                      ),
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              visbilty = false;
                            });
                          },
                          height: 50,
                          minWidth: 250,
                          textColor: Colors.white,
                          child: Text(
                            "NO",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ],
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: 150, bottom: 150, left: 15, right: 15),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Are you Living in Coastal ?",
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                          ),
                        )),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: Colors.grey,
                      ),
                      child: FlatButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, "/coastal_page");
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CoastalPage(surveyId: widget.surveyId,)));
                          },
                          height: 50,
                          minWidth: 250,
                          textColor: Colors.white,
                          child: Text(
                            "Yes",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: Colors.grey,
                      ),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/environmentalRelated_page");
                          },
                          height: 50,
                          minWidth: 250,
                          textColor: Colors.white,
                          child: Text(
                            "NO",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ],
                ),
              ));
  }
}
