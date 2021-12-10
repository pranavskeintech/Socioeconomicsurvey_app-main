// To parse this JSON data, do
//
//     final houseHoldApiModel = houseHoldApiModelFromJson(jsonString);

import 'dart:convert';

HouseHoldApiModel houseHoldApiModelFromJson(String str) => HouseHoldApiModel.fromJson(json.decode(str));

String houseHoldApiModelToJson(HouseHoldApiModel data) => json.encode(data.toJson());

class HouseHoldApiModel {
    HouseHoldApiModel({
        this.surveyId,
        this.migrated,
        this.ifYesNoOfYears,
        this.placeOfOrigin,
        this.migrationType,
        this.reasonOfMigration,
        this.areYouWillingToMigrateToAnotherPlace,
        this.ifNoReasonsForNotGoingBackToTheNativePlace,
        this.afterCovid19SituationYouGoBackToYourNativePlace,
    });

    String surveyId;
    String migrated;
    String ifYesNoOfYears;
    String placeOfOrigin;
    String migrationType;
    String reasonOfMigration;
    String areYouWillingToMigrateToAnotherPlace;
    String ifNoReasonsForNotGoingBackToTheNativePlace;
    String afterCovid19SituationYouGoBackToYourNativePlace;

    factory HouseHoldApiModel.fromJson(Map<String, dynamic> json) => HouseHoldApiModel(
        surveyId: json["survey_id"],
        migrated: json["migrated"],
        ifYesNoOfYears: json["if_yes_no_of_years"],
        placeOfOrigin: json["place_of_origin"],
        migrationType: json["migration_type"],
        reasonOfMigration: json["reason_of_migration"],
        areYouWillingToMigrateToAnotherPlace: json["are_you_willing_to_migrate_to_another_place"],
        ifNoReasonsForNotGoingBackToTheNativePlace: json["if_no_reasons_for_not_going_back_to_the_native_place"],
        afterCovid19SituationYouGoBackToYourNativePlace: json["after_covid19_situation_you_go_back_to_your_native_place"],
    );

    Map<String, dynamic> toJson() => {
        "survey_id": surveyId,
        "migrated": migrated,
        "if_yes_no_of_years": ifYesNoOfYears,
        "place_of_origin": placeOfOrigin,
        "migration_type": migrationType,
        "reason_of_migration": reasonOfMigration,
        "are_you_willing_to_migrate_to_another_place": areYouWillingToMigrateToAnotherPlace,
        "if_no_reasons_for_not_going_back_to_the_native_place": ifNoReasonsForNotGoingBackToTheNativePlace,
        "after_covid19_situation_you_go_back_to_your_native_place": afterCovid19SituationYouGoBackToYourNativePlace,
    };
}
