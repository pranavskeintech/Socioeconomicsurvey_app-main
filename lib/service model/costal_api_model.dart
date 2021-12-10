// To parse this JSON data, do
//
//     final costalApiModel = costalApiModelFromJson(jsonString);

import 'dart:convert';

CostalApiModel costalApiModelFromJson(String str) => CostalApiModel.fromJson(json.decode(str));

String costalApiModelToJson(CostalApiModel data) => json.encode(data.toJson());

class CostalApiModel {
    CostalApiModel({
        this.surveyId,
        this.doYouHaveBoats,
        this.ifYesThePurposeOfUsingBoats,
        this.areYouAssociatedWithFishingRelatedActivities,
        this.ifYesThenSpecifyAsSellerCatcherSupplierOrOther,
        this.haveYouBeenEngagedInOtherActivitiesApartFromFishing,
        this.ifYesSpecifyTheActivities,
        this.doYouThinkLivingInCoastalRegionIsThreatOrOpportunity,
        this.howDoYouGetTheInformationRelatedToNaturalThreats,
        this.safePlaceDuringNaturalEvents,
        this.afterNaturalDisasterHowManyDaysTakeComeToNormal,
        this.majorDamagesDuringNaturalCalamities,
        this.availabilityOfRationDuringTheNaturalDisaster,
        this.whetherAnyFundAreaGrantedForTheFloodProneArea,
        this.doesThisRegionHaveAnyTourismOpportunities,
        this.anyFurtherSuggestionsOrIssuesInCoastalRegion,
    });

    String surveyId;
    String doYouHaveBoats;
    String ifYesThePurposeOfUsingBoats;
    String areYouAssociatedWithFishingRelatedActivities;
    String ifYesThenSpecifyAsSellerCatcherSupplierOrOther;
    String haveYouBeenEngagedInOtherActivitiesApartFromFishing;
    String ifYesSpecifyTheActivities;
    String doYouThinkLivingInCoastalRegionIsThreatOrOpportunity;
    String howDoYouGetTheInformationRelatedToNaturalThreats;
    String safePlaceDuringNaturalEvents;
    String afterNaturalDisasterHowManyDaysTakeComeToNormal;
    String majorDamagesDuringNaturalCalamities;
    String availabilityOfRationDuringTheNaturalDisaster;
    String whetherAnyFundAreaGrantedForTheFloodProneArea;
    String doesThisRegionHaveAnyTourismOpportunities;
    String anyFurtherSuggestionsOrIssuesInCoastalRegion;

    factory CostalApiModel.fromJson(Map<String, dynamic> json) => CostalApiModel(
        surveyId: json["survey_id"],
        doYouHaveBoats: json["do_you_have_boats"],
        ifYesThePurposeOfUsingBoats: json["if_yes_the_purpose_of_using_boats"],
        areYouAssociatedWithFishingRelatedActivities: json["are_you_associated_with_fishing_related_activities"],
        ifYesThenSpecifyAsSellerCatcherSupplierOrOther: json["if_yes_then_specify_as_seller_catcher_supplier_or_other"],
        haveYouBeenEngagedInOtherActivitiesApartFromFishing: json["have_you_been_engaged_in_other_activities_apart_from_fishing"],
        ifYesSpecifyTheActivities: json["if_yes_specify_the_activities"],
        doYouThinkLivingInCoastalRegionIsThreatOrOpportunity: json["do_you_think_living_in_coastal_region_is_threat_or_opportunity"],
        howDoYouGetTheInformationRelatedToNaturalThreats: json["how_do_you_get_the_information_related_to_natural_threats"],
        safePlaceDuringNaturalEvents: json["safe_place_during_natural_events"],
        afterNaturalDisasterHowManyDaysTakeComeToNormal: json["after_natural_disaster_how_many_days_take_come_to_normal"],
        majorDamagesDuringNaturalCalamities: json["major_damages_during_natural_calamities"],
        availabilityOfRationDuringTheNaturalDisaster: json["availability_of_ration_during_the_natural_disaster"],
        whetherAnyFundAreaGrantedForTheFloodProneArea: json["whether_any_fund_area_granted_for_the_flood_prone_area"],
        doesThisRegionHaveAnyTourismOpportunities: json["does_this_region_have_any_tourism_opportunities"],
        anyFurtherSuggestionsOrIssuesInCoastalRegion: json["any_further_suggestions_or_issues_in_coastal_region"],
    );

    Map<String, dynamic> toJson() => {
        "survey_id": surveyId,
        "do_you_have_boats": doYouHaveBoats,
        "if_yes_the_purpose_of_using_boats": ifYesThePurposeOfUsingBoats,
        "are_you_associated_with_fishing_related_activities": areYouAssociatedWithFishingRelatedActivities,
        "if_yes_then_specify_as_seller_catcher_supplier_or_other": ifYesThenSpecifyAsSellerCatcherSupplierOrOther,
        "have_you_been_engaged_in_other_activities_apart_from_fishing": haveYouBeenEngagedInOtherActivitiesApartFromFishing,
        "if_yes_specify_the_activities": ifYesSpecifyTheActivities,
        "do_you_think_living_in_coastal_region_is_threat_or_opportunity": doYouThinkLivingInCoastalRegionIsThreatOrOpportunity,
        "how_do_you_get_the_information_related_to_natural_threats": howDoYouGetTheInformationRelatedToNaturalThreats,
        "safe_place_during_natural_events": safePlaceDuringNaturalEvents,
        "after_natural_disaster_how_many_days_take_come_to_normal": afterNaturalDisasterHowManyDaysTakeComeToNormal,
        "major_damages_during_natural_calamities": majorDamagesDuringNaturalCalamities,
        "availability_of_ration_during_the_natural_disaster": availabilityOfRationDuringTheNaturalDisaster,
        "whether_any_fund_area_granted_for_the_flood_prone_area": whetherAnyFundAreaGrantedForTheFloodProneArea,
        "does_this_region_have_any_tourism_opportunities": doesThisRegionHaveAnyTourismOpportunities,
        "any_further_suggestions_or_issues_in_coastal_region": anyFurtherSuggestionsOrIssuesInCoastalRegion,
    };
}
