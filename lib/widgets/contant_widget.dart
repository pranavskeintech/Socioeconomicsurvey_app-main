import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonSaveAndContinue extends StatelessWidget {
  final VoidCallback onPress;
  const ButtonSaveAndContinue({
    Key key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.0),
          color: Color(0xfff89d4cf),
        ),
        child: FlatButton(
          onPressed: onPress,
          height: 50,
          minWidth: 250,
          textColor: Colors.white,
          child: Text("Save & Continue",
              style: GoogleFonts.quicksand(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
        ));
  }
}

class ButtonSaveAndExit extends StatelessWidget {
  final VoidCallback onPress;
  const ButtonSaveAndExit({
    Key key,
     this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.0),
          color: Colors.redAccent,
        ),
        child: FlatButton(
          onPressed: onPress,
          height: 50,
          minWidth: 250,
          textColor: Colors.white,
          child: Text("Save & Exit",
              style: GoogleFonts.quicksand(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
        ));
  }
}

class ButtonBack extends StatelessWidget {
  final VoidCallback onPress;
  const ButtonBack({
    Key key,
     this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.0),
          color: Colors.grey,
        ),
        child: FlatButton(
          onPressed: onPress,
          height: 50,
          minWidth: 250,
          textColor: Colors.white,
          child: Text(
            "Back",
            style: GoogleFonts.quicksand(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ));
  }
}

class PageTitleWidget extends StatelessWidget {
  final String title;
  const PageTitleWidget({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50, left: 25),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: GoogleFonts.quicksand(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}

class QuestionBody extends StatelessWidget {
  final Widget questionBody;
  const QuestionBody({
    Key key,
    this.questionBody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xfff6e45e1), Color(0xfff89d4cf)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: questionBody);
  }
}

class QuestionContainer extends StatelessWidget {
  final Widget child;
  const QuestionContainer({Key key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: child,
    );
  }
}

class QuestionName extends StatelessWidget {
  final String questionName;
  const QuestionName({
    Key key,
    this.questionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          questionName,
          style: GoogleFonts.quicksand(
            fontSize: 20,
          ),
        ));
  }
}

class TextFieldContainer extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hint;
  final Function(String) onChange;

  const TextFieldContainer({
    Key key,
    this.controller,
    this.inputType,
    this.hint, this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                controller: controller,
                keyboardType: inputType,
                decoration: InputDecoration(
                  hintText: hint,
                  border: OutlineInputBorder(),
                ),
                onChanged:onChange
              ),
            ),
          ],
        ));
  }
}

class UserTextfieldContainer extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final Function(String) onChange;
  const UserTextfieldContainer({
    Key key,
    this.textController,
    this.labelText,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
          controller: textController,
          onChanged: onChange,
          decoration: InputDecoration(
              fillColor: Colors.grey,
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blueAccent))),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Fill';
            }
            return null;
          }),
    );
  }
}

class NumberTextFieldContainer extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final Function(String) onChange;
  const NumberTextFieldContainer({
    Key key,
    this.textController,
    this.labelText,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
          onChanged: onChange,
          controller: textController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              fillColor: Colors.grey,
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blueAccent))),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'information not provided';
            }
            return null;
          }),
    );
  }
}
