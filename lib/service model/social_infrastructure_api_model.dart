// To parse this JSON data, do
//
//     final socialInfraApiModel = socialInfraApiModelFromJson(jsonString);

import 'dart:convert';

SocialInfraApiModel socialInfraApiModelFromJson(String str) => SocialInfraApiModel.fromJson(json.decode(str));

String socialInfraApiModelToJson(SocialInfraApiModel data) => json.encode(data.toJson());

class SocialInfraApiModel {
    SocialInfraApiModel({
        this.surveyId,
        this.whichTypeOfSchoolorEducationInfrastructureDoYouPrefer,
        this.typeOfEducationAvailabilityAndTheirDistance,
        this.mostPreferredMode,
        this.doYouThinkYourRegionHasGoodOpportunitiesInEducation,
        this.anyFurtherSuggestionsOrIssuesForImprovementInEducation,
        this.mostPreferredHealthFacility,
        this.distance,
        this.doYouThinkYourRegionHasGoodInHealthFacilities,
        this.anySuggestionsForImprovementInHealthFacilities,
        this.availabilityOfParksPlaygroundOrOtherRecreationSpaces,
        this.doYouOrYourFamilyMembersGoToAParkOrPlayground,
        this.ifYesHowRegularYouGoToParkOrPlayground,
        this.anyFurtherSuggestionOrIssuesForImprovementInParks,
        this.doYouReceiveAnyGrantFromAnyStateGovtFlagshipScheme,
        this.ifAvailingAnyOtherSchemesPleaseSpecify,
    });

    String surveyId;
    String whichTypeOfSchoolorEducationInfrastructureDoYouPrefer;
    String typeOfEducationAvailabilityAndTheirDistance;
    String mostPreferredMode;
    String doYouThinkYourRegionHasGoodOpportunitiesInEducation;
    String anyFurtherSuggestionsOrIssuesForImprovementInEducation;
    String mostPreferredHealthFacility;
    String distance;
    String doYouThinkYourRegionHasGoodInHealthFacilities;
    String anySuggestionsForImprovementInHealthFacilities;
    String availabilityOfParksPlaygroundOrOtherRecreationSpaces;
    String doYouOrYourFamilyMembersGoToAParkOrPlayground;
    String ifYesHowRegularYouGoToParkOrPlayground;
    String anyFurtherSuggestionOrIssuesForImprovementInParks;
    String doYouReceiveAnyGrantFromAnyStateGovtFlagshipScheme;
    String ifAvailingAnyOtherSchemesPleaseSpecify;

    factory SocialInfraApiModel.fromJson(Map<String, dynamic> json) => SocialInfraApiModel(
        surveyId: json["survey_id"],
        whichTypeOfSchoolorEducationInfrastructureDoYouPrefer: json["which_type_of_schoolor_education_infrastructure_do_you_prefer"],
        typeOfEducationAvailabilityAndTheirDistance: json["type_of_education_availability_and_their_distance"],
        mostPreferredMode: json["most_preferred_mode"],
        doYouThinkYourRegionHasGoodOpportunitiesInEducation: json["do_you_think_your_region_has_good_opportunities_in_education"],
        anyFurtherSuggestionsOrIssuesForImprovementInEducation: json["any_further_suggestions_or_issues_for_improvement_in_education"],
        mostPreferredHealthFacility: json["most_preferred_health_facility"],
        distance: json["distance"],
        doYouThinkYourRegionHasGoodInHealthFacilities: json["do_you_think_your_region_has_good_in_health_facilities"],
        anySuggestionsForImprovementInHealthFacilities: json["any_suggestions_for_improvement_in_health_facilities"],
        availabilityOfParksPlaygroundOrOtherRecreationSpaces: json["availability_of_parks_playground_or_other_recreation_spaces"],
        doYouOrYourFamilyMembersGoToAParkOrPlayground: json["do_you_or_your_family_members_go_to_a_park_or_playground"],
        ifYesHowRegularYouGoToParkOrPlayground: json["if_yes_how_regular_you_go_to_park_or_playground"],
        anyFurtherSuggestionOrIssuesForImprovementInParks: json["any_further_suggestion_or_issues_for_improvement_in_parks"],
        doYouReceiveAnyGrantFromAnyStateGovtFlagshipScheme: json["do_you_receive_any_grant_from_any_state_govt_flagship_scheme"],
        ifAvailingAnyOtherSchemesPleaseSpecify: json["if_availing_any_other_schemes_please_specify"],
    );

    Map<String, dynamic> toJson() => {
        "survey_id": surveyId,
        "which_type_of_schoolor_education_infrastructure_do_you_prefer": whichTypeOfSchoolorEducationInfrastructureDoYouPrefer,
        "type_of_education_availability_and_their_distance": typeOfEducationAvailabilityAndTheirDistance,
        "most_preferred_mode": mostPreferredMode,
        "do_you_think_your_region_has_good_opportunities_in_education": doYouThinkYourRegionHasGoodOpportunitiesInEducation,
        "any_further_suggestions_or_issues_for_improvement_in_education": anyFurtherSuggestionsOrIssuesForImprovementInEducation,
        "most_preferred_health_facility": mostPreferredHealthFacility,
        "distance": distance,
        "do_you_think_your_region_has_good_in_health_facilities": doYouThinkYourRegionHasGoodInHealthFacilities,
        "any_suggestions_for_improvement_in_health_facilities": anySuggestionsForImprovementInHealthFacilities,
        "availability_of_parks_playground_or_other_recreation_spaces": availabilityOfParksPlaygroundOrOtherRecreationSpaces,
        "do_you_or_your_family_members_go_to_a_park_or_playground": doYouOrYourFamilyMembersGoToAParkOrPlayground,
        "if_yes_how_regular_you_go_to_park_or_playground": ifYesHowRegularYouGoToParkOrPlayground,
        "any_further_suggestion_or_issues_for_improvement_in_parks": anyFurtherSuggestionOrIssuesForImprovementInParks,
        "do_you_receive_any_grant_from_any_state_govt_flagship_scheme": doYouReceiveAnyGrantFromAnyStateGovtFlagshipScheme,
        "if_availing_any_other_schemes_please_specify": ifAvailingAnyOtherSchemesPleaseSpecify,
    };
}
