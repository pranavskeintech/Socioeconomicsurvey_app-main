// To parse this JSON data, do
//
//     final costalApiModel = costalApiModelFromJson(jsonString);

import 'dart:convert';

CostalApiModel costalApiModelFromJson(String str) => CostalApiModel.fromJson(json.decode(str));

String costalApiModelToJson(CostalApiModel data) => json.encode(data.toJson());

class CostalApiModel {
    CostalApiModel({
        this.surveyId,
        this.popularFestivalOccasion,
        this.thisPlaceHaveAnySignificantHeritageSiteStructure,
        this.visitorsDuringTheFestivalsOrOccasion,
        this.problemFacedDuringTheFestivalsAndOccasion,
        this.festiveOccasionPresenceHelpYouInTheEconomicGeneration,
        this.ifYesSpecifyHowFestivalsHelps,
        this.doTouristsVisitThisPlaceRegularlyOrDuringFestivals,
        this.anyFurtherSuggestionInCulturalHeritage,
    });

    String surveyId;
    String popularFestivalOccasion;
    String thisPlaceHaveAnySignificantHeritageSiteStructure;
    String visitorsDuringTheFestivalsOrOccasion;
    String problemFacedDuringTheFestivalsAndOccasion;
    String festiveOccasionPresenceHelpYouInTheEconomicGeneration;
    String ifYesSpecifyHowFestivalsHelps;
    String doTouristsVisitThisPlaceRegularlyOrDuringFestivals;
    String anyFurtherSuggestionInCulturalHeritage;

    factory CostalApiModel.fromJson(Map<String, dynamic> json) => CostalApiModel(
        surveyId: json["survey_id"],
        popularFestivalOccasion: json["popular_festival_occasion"],
        thisPlaceHaveAnySignificantHeritageSiteStructure: json["this_place_have_any_significant_heritage_site_structure"],
        visitorsDuringTheFestivalsOrOccasion: json["visitors_during_the_festivals_or_occasion"],
        problemFacedDuringTheFestivalsAndOccasion: json["problem_faced_during_the_festivals_and_occasion"],
        festiveOccasionPresenceHelpYouInTheEconomicGeneration: json["festive_occasion_presence_help_you_in_the_economic_generation"],
        ifYesSpecifyHowFestivalsHelps: json["if_yes_specify_how_festivals_helps"],
        doTouristsVisitThisPlaceRegularlyOrDuringFestivals: json["do_tourists_visit_this_place_regularly_or_during_festivals"],
        anyFurtherSuggestionInCulturalHeritage: json["any_further_suggestion_in_cultural_heritage"],
    );

    Map<String, dynamic> toJson() => {
        "survey_id": surveyId,
        "popular_festival_occasion": popularFestivalOccasion,
        "this_place_have_any_significant_heritage_site_structure": thisPlaceHaveAnySignificantHeritageSiteStructure,
        "visitors_during_the_festivals_or_occasion": visitorsDuringTheFestivalsOrOccasion,
        "problem_faced_during_the_festivals_and_occasion": problemFacedDuringTheFestivalsAndOccasion,
        "festive_occasion_presence_help_you_in_the_economic_generation": festiveOccasionPresenceHelpYouInTheEconomicGeneration,
        "if_yes_specify_how_festivals_helps": ifYesSpecifyHowFestivalsHelps,
        "do_tourists_visit_this_place_regularly_or_during_festivals": doTouristsVisitThisPlaceRegularlyOrDuringFestivals,
        "any_further_suggestion_in_cultural_heritage": anyFurtherSuggestionInCulturalHeritage,
    };
}
