// To parse this JSON data, do
//
//     final userDetailsDbModel = userDetailsDbModelFromJson(jsonString);

import 'dart:convert';

UserDetailsDbModel userDetailsDbModelFromJson(String str) => UserDetailsDbModel.fromJson(json.decode(str));

String userDetailsDbModelToJson(UserDetailsDbModel data) => json.encode(data.toJson());

class UserDetailsDbModel {
    UserDetailsDbModel({
        this.devicesId,
        this.surveyId,
        this.city,
        this.phoneNo,
        this.nameOfLocality,
        this.ward,
        this.totalNoOfMembers,
        this.fullNameOfFamilyHead,
        this.totalNoOfMales,
        this.totalNoOfFemales,
        this.totalNoOfIlliterateMembers,
        this.caste,
        this.religion,
        this.minorityStatus,
    });
  //   @override
  // String toString() {
  //   return 'DbModel:{devicesId:$devicesId},{surveyId:$surveyId},{city:$city},{phoneNo:$phoneNo},{nameOfLocality:$nameOfLocality},{ward:$ward},{totalNoOfMembers:$totalNoOfMembers},{fullNameOfFamilyHead:$fullNameOfFamilyHead},{nameOfLocality:$nameOfLocality},{nameOfLocality:$nameOfLocality},{nameOfLocality:$nameOfLocality},{nameOfLocality:$nameOfLocality},{nameOfLocality:$nameOfLocality},{nameOfLocality:$nameOfLocality},{nameOfLocality:$nameOfLocality}';
  // }

    String devicesId;
    String surveyId;
    String city;
    String phoneNo;
    String nameOfLocality;
    String ward;
    String totalNoOfMembers;
    String fullNameOfFamilyHead;
    String totalNoOfMales;
    String totalNoOfFemales;
    String totalNoOfIlliterateMembers;
    String caste;
    String religion;
    String minorityStatus;

    factory UserDetailsDbModel.fromJson(Map<String, dynamic> json) => UserDetailsDbModel(
        devicesId: json["devices_id"],
        surveyId: json["survey_id"],
        city: json["city"],
        phoneNo: json["phone_no"],
        nameOfLocality: json["name_of_locality"],
        ward: json["ward"],
        totalNoOfMembers: json["total_no_of_members"],
        fullNameOfFamilyHead: json["full_name_of_family_head"],
        totalNoOfMales: json["total_no_of_males"],
        totalNoOfFemales: json["total_no_of_females"],
        totalNoOfIlliterateMembers: json["total_no_of_illiterate_members"],
        caste: json["caste"],
        religion: json["religion"],
        minorityStatus: json["minority_status"],
    );

    Map<String, dynamic> toJson() => {
        "devices_id": devicesId,
        "survey_id": surveyId,
        "city": city,
        "phone_no": phoneNo,
        "name_of_locality": nameOfLocality,
        "ward": ward,
        "total_no_of_members": totalNoOfMembers,
        "full_name_of_family_head": fullNameOfFamilyHead,
        "total_no_of_males": totalNoOfMales,
        "total_no_of_females": totalNoOfFemales,
        "total_no_of_illiterate_members": totalNoOfIlliterateMembers,
        "caste": caste,
        "religion": religion,
        "minority_status": minorityStatus,
    };
}
