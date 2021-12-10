// class SurveyIdModel {
//   String surveyId;
//   List<Data> data;

//   SurveyIdModel({this.surveyId, this.data});

//   SurveyIdModel.fromJson(Map<String, dynamic> json) {
//     surveyId = json['survey_id'];
//     if (json['data'] != null) {
//       data = new List<Data>();
//       json['data'].forEach((v) {
//         data.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['survey_id'] = this.surveyId;
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   String question;
//   String answer;

//   Data({this.question, this.answer});

//   Data.fromJson(Map<String, dynamic> json) {
//     question = json['question'];
//     answer = json['answer'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['question'] = this.question;
//     data['answer'] = this.answer;
//     return data;
//   }
// }

// To parse this JSON data, do
//
//     final surveyIdModel = surveyIdModelFromJson(jsonString);

import 'dart:convert';

SurveyIdModel surveyIdModelFromJson(String str) => SurveyIdModel.fromJson(json.decode(str));

String surveyIdModelToJson(SurveyIdModel data) => json.encode(data.toJson());

class SurveyIdModel {
    SurveyIdModel({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    List<Map<String, String>> data;

    factory SurveyIdModel.fromJson(Map<String, dynamic> json) => SurveyIdModel(
        status: json["status"],
        message: json["message"],
        data: List<Map<String, String>>.from(json["data"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
    };
}

