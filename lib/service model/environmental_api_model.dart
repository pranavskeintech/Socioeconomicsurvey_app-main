// To parse this JSON data, do
//
//     final environmentalApiModel = environmentalApiModelFromJson(jsonString);

import 'dart:convert';

EnvironmentalApiModel environmentalApiModelFromJson(String str) => EnvironmentalApiModel.fromJson(json.decode(str));

String environmentalApiModelToJson(EnvironmentalApiModel data) => json.encode(data.toJson());

class EnvironmentalApiModel {
    EnvironmentalApiModel({
        this.surveyId,
        this.familyOrNearbyPersonSufferedFromDiseasesInLastFewYears,
        this.ifYesWhichDiseasesSpecify,
        this.doYouOrFamilyMemberFaceAnyProblemInBreathing,
        this.majorCauseOfPollution,
        this.doYouFaceAnyIssuesDuringTheRainySeason,
        this.ifYesSpecifyIssuesFacedInRainySeason,
        this.whetherTheAreaIsProneToFloodingDueToRains,
        this.ifYesHowManyDaysItTakesToNormalCondition,
        this.duringFloodingIsRehabilitationCentresAvailable,
        this.whetherAnyFundsGrantedToYouForSuchDisaster,
        this.doHoardingsCreateAnyVisualDisturbanceWhileDriving,
        this.doesTrafficMovementAndNoiseAnIssueForYourLocality,
        this.ifYesSuggestionForImprovementInTrafficIssue,
        this.whetherTheWasteDisposedOffInANearbyRiverOrWaterBody,
        this.anyFurtherSuggestionForImprovementInEnvironment,
    });

    String surveyId;
    String familyOrNearbyPersonSufferedFromDiseasesInLastFewYears;
    String ifYesWhichDiseasesSpecify;
    String doYouOrFamilyMemberFaceAnyProblemInBreathing;
    String majorCauseOfPollution;
    String doYouFaceAnyIssuesDuringTheRainySeason;
    String ifYesSpecifyIssuesFacedInRainySeason;
    String whetherTheAreaIsProneToFloodingDueToRains;
    String ifYesHowManyDaysItTakesToNormalCondition;
    String duringFloodingIsRehabilitationCentresAvailable;
    String whetherAnyFundsGrantedToYouForSuchDisaster;
    String doHoardingsCreateAnyVisualDisturbanceWhileDriving;
    String doesTrafficMovementAndNoiseAnIssueForYourLocality;
    String ifYesSuggestionForImprovementInTrafficIssue;
    String whetherTheWasteDisposedOffInANearbyRiverOrWaterBody;
    String anyFurtherSuggestionForImprovementInEnvironment;

    factory EnvironmentalApiModel.fromJson(Map<String, dynamic> json) => EnvironmentalApiModel(
        surveyId: json["survey_id"],
        familyOrNearbyPersonSufferedFromDiseasesInLastFewYears: json["family_or_nearby_person_suffered_from_diseases_in_last_few_years"],
        ifYesWhichDiseasesSpecify: json["if_yes_which_diseases_specify"],
        doYouOrFamilyMemberFaceAnyProblemInBreathing: json["do_you_or_family_member_face_any_problem_in_breathing"],
        majorCauseOfPollution: json["major_cause_of_pollution"],
        doYouFaceAnyIssuesDuringTheRainySeason: json["do_you_face_any_issues_during_the_rainy_season"],
        ifYesSpecifyIssuesFacedInRainySeason: json["if_yes_specify_issues_faced_in_rainy_season"],
        whetherTheAreaIsProneToFloodingDueToRains: json["whether_the_area_is_prone_to_flooding_due_to_rains"],
        ifYesHowManyDaysItTakesToNormalCondition: json["if_yes_how_many_days_it_takes_to_normal_condition"],
        duringFloodingIsRehabilitationCentresAvailable: json["during_flooding_is_rehabilitation_centres_available"],
        whetherAnyFundsGrantedToYouForSuchDisaster: json["whether_any_funds_granted_to_you_for_such_disaster"],
        doHoardingsCreateAnyVisualDisturbanceWhileDriving: json["do_hoardings_create_any_visual_disturbance_while_driving"],
        doesTrafficMovementAndNoiseAnIssueForYourLocality: json["does_traffic_movement_and_noise_an_issue_for_your_locality"],
        ifYesSuggestionForImprovementInTrafficIssue: json["if_yes_suggestion_for_improvement_in_traffic_issue"],
        whetherTheWasteDisposedOffInANearbyRiverOrWaterBody: json["whether_the_waste_disposed_off_in_a_nearby_river_or_water_body"],
        anyFurtherSuggestionForImprovementInEnvironment: json["any_further_suggestion_for_improvement_in_environment"],
    );

    Map<String, dynamic> toJson() => {
        "survey_id": surveyId,
        "family_or_nearby_person_suffered_from_diseases_in_last_few_years": familyOrNearbyPersonSufferedFromDiseasesInLastFewYears,
        "if_yes_which_diseases_specify": ifYesWhichDiseasesSpecify,
        "do_you_or_family_member_face_any_problem_in_breathing": doYouOrFamilyMemberFaceAnyProblemInBreathing,
        "major_cause_of_pollution": majorCauseOfPollution,
        "do_you_face_any_issues_during_the_rainy_season": doYouFaceAnyIssuesDuringTheRainySeason,
        "if_yes_specify_issues_faced_in_rainy_season": ifYesSpecifyIssuesFacedInRainySeason,
        "whether_the_area_is_prone_to_flooding_due_to_rains": whetherTheAreaIsProneToFloodingDueToRains,
        "if_yes_how_many_days_it_takes_to_normal_condition": ifYesHowManyDaysItTakesToNormalCondition,
        "during_flooding_is_rehabilitation_centres_available": duringFloodingIsRehabilitationCentresAvailable,
        "whether_any_funds_granted_to_you_for_such_disaster": whetherAnyFundsGrantedToYouForSuchDisaster,
        "do_hoardings_create_any_visual_disturbance_while_driving": doHoardingsCreateAnyVisualDisturbanceWhileDriving,
        "does_traffic_movement_and_noise_an_issue_for_your_locality": doesTrafficMovementAndNoiseAnIssueForYourLocality,
        "if_yes_suggestion_for_improvement_in_traffic_issue": ifYesSuggestionForImprovementInTrafficIssue,
        "whether_the_waste_disposed_off_in_a_nearby_river_or_water_body": whetherTheWasteDisposedOffInANearbyRiverOrWaterBody,
        "any_further_suggestion_for_improvement_in_environment": anyFurtherSuggestionForImprovementInEnvironment,
    };
}
