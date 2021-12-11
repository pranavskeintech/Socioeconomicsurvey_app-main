// import 'package:flutter/material.dart';

// class UserDetailsTextFieldContainer extends StatelessWidget {
//   final TextEditingController textController;
//   final String labelText;
//   final Function onChange;
//   const UserDetailsTextFieldContainer({
//     Key key,
//     this.textController,
//     this.labelText,
//     this.onChange,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 30, right: 30),
//       child: TextFormField(
//           controller: textController,
//           onChanged: onChange,
//           decoration: InputDecoration(
//               fillColor: Colors.grey,
//               labelText: labelText,
//               labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: BorderSide(color: Colors.red)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: BorderSide(color: Colors.blueAccent))),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'information not provided';
//             }
//             return null;
//           }),
//     );
//   }
// }

// class NumberTextFieldContainer extends StatelessWidget {
//   final TextEditingController textController;
//   final String labelText;
//   final Function onChange;
//   const NumberTextFieldContainer({
//     Key key,
//     this.textController,
//     this.labelText,
//     this.onChange,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 30, right: 30),
//       child: TextFormField(
//           onChanged: onChange,
//           controller: textController,
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//               fillColor: Colors.grey,
//               labelText: labelText,
//               labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: BorderSide(color: Colors.red)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: BorderSide(color: Colors.blueAccent))),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'information not provided';
//             }
//             return null;
//           }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socio_survey/pages/user details page/user_details_page.dart';

class TextFieldContainer1 extends StatelessWidget {
  final TextEditingController textController;
  final Function(String) validation;
  final TextInputType inputType;
  final Function(String) onChange;
  final List<TextInputFormatter> inputFormatters;
  final InputDecoration inputDecoration;
  const TextFieldContainer1(
      {Key key,
      this.textController,
      this.validation,
      this.inputType,
      this.onChange,
      this.inputFormatters,
      this.inputDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      validator: validation,
      keyboardType: inputType,
      onChanged: onChange,
      inputFormatters: inputFormatters,
      decoration: inputDecoration,
    );
  }
}
