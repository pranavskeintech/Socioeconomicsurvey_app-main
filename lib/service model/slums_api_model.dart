// To parse this JSON data, do
//
//     final slumsApiModel = slumsApiModelFromJson(jsonString);

import 'dart:convert';

SlumsApiModel slumsApiModelFromJson(String str) => SlumsApiModel.fromJson(json.decode(str));

String slumsApiModelToJson(SlumsApiModel data) => json.encode(data.toJson());

class SlumsApiModel {
    SlumsApiModel({
        this.surveyId,
        this.doesThisPlaceIsAllottedToYouByAnyAuthority,
        this.statusOfLand,
        this.ifGovernmentLandIsThereAnyPatta,
        this.howLongHaveYouStayedHere,
        this.typesOfWorkInWhichYouAreEngaged,
        this.areYouSkilledLabour,
        this.ifYesSkillTypeCarpenterElectricianEtc,
        this.dueToTheCovid19HasTheIncomeAndJobBeenAffected,
        this.doYouGetAnyRationAssistanceFromTheGovernment,
        this.typeOfRationCardYouAvailable,
        this.doYouGetAnyFinancialAssistanceFromTheGovernment,
        this.getAnyBenefitsFromAnyStateOrCentralHousingSchemes,
        this.allottedHouseUnderSlumRehabilitationProjectOfGovernment,
        this.ifGovernmentProvidesAHouseWouldYouMoveToThatPlace,
        this.doYouGetAnyBenefitOfSwasthyaSathiForHealthAssistance,
        this.willingToGoBackToNativeIfSuitableJobsAreMadeAvailable,
        this.whatDoYouSayAboutLifeInSlumAreas,
        this.whatKindOfProblemsDoYouFace,
        this.doYouFaceAnyProblemsFromIndustriesAroundYou,
        this.whetherAllChildrenEnrolledInTheSchool,
        this.ifYesWhichTypeOfSchool,
        this.ifNotGoingToSchoolDropOutAge,
        this.reasonOfDropOut,
        this.ifMoreThanOneStudent,
        this.alternativeEconomicActivitiesForLivelihood,
        this.anyFurtherSuggestionOrIssuesForImprovementRegardingSlums,
    });

    String surveyId;
    String doesThisPlaceIsAllottedToYouByAnyAuthority;
    String statusOfLand;
    String ifGovernmentLandIsThereAnyPatta;
    String howLongHaveYouStayedHere;
    String typesOfWorkInWhichYouAreEngaged;
    String areYouSkilledLabour;
    String ifYesSkillTypeCarpenterElectricianEtc;
    String dueToTheCovid19HasTheIncomeAndJobBeenAffected;
    String doYouGetAnyRationAssistanceFromTheGovernment;
    String typeOfRationCardYouAvailable;
    String doYouGetAnyFinancialAssistanceFromTheGovernment;
    String getAnyBenefitsFromAnyStateOrCentralHousingSchemes;
    String allottedHouseUnderSlumRehabilitationProjectOfGovernment;
    String ifGovernmentProvidesAHouseWouldYouMoveToThatPlace;
    String doYouGetAnyBenefitOfSwasthyaSathiForHealthAssistance;
    String willingToGoBackToNativeIfSuitableJobsAreMadeAvailable;
    String whatDoYouSayAboutLifeInSlumAreas;
    String whatKindOfProblemsDoYouFace;
    String doYouFaceAnyProblemsFromIndustriesAroundYou;
    String whetherAllChildrenEnrolledInTheSchool;
    String ifYesWhichTypeOfSchool;
    String ifNotGoingToSchoolDropOutAge;
    String reasonOfDropOut;
    String ifMoreThanOneStudent;
    String alternativeEconomicActivitiesForLivelihood;
    String anyFurtherSuggestionOrIssuesForImprovementRegardingSlums;

    factory SlumsApiModel.fromJson(Map<String, dynamic> json) => SlumsApiModel(
        surveyId: json["survey_id"],
        doesThisPlaceIsAllottedToYouByAnyAuthority: json["does_this_place_is_allotted_to_you_by_any_authority"],
        statusOfLand: json["status_of_land"],
        ifGovernmentLandIsThereAnyPatta: json["if_government_land_is_there_any_patta"],
        howLongHaveYouStayedHere: json["how_long_have_you_stayed_here"],
        typesOfWorkInWhichYouAreEngaged: json["types_of_work_in_which_you_are_engaged"],
        areYouSkilledLabour: json["are_you_skilled_labour"],
        ifYesSkillTypeCarpenterElectricianEtc: json["if_yes_skill_type_carpenter_electrician_etc"],
        dueToTheCovid19HasTheIncomeAndJobBeenAffected: json["due_to_the_covid19_has_the_income_and_job_been_affected"],
        doYouGetAnyRationAssistanceFromTheGovernment: json["do_you_get_any_ration_assistance_from_the_government"],
        typeOfRationCardYouAvailable: json["type_of_ration_card_you_available"],
        doYouGetAnyFinancialAssistanceFromTheGovernment: json["do_you_get_any_financial_assistance_from_the_government"],
        getAnyBenefitsFromAnyStateOrCentralHousingSchemes: json["get_any_benefits_from_any_state_or_central_housing_schemes"],
        allottedHouseUnderSlumRehabilitationProjectOfGovernment: json["allotted_house_under_slum_rehabilitation_project_of_government"],
        ifGovernmentProvidesAHouseWouldYouMoveToThatPlace: json["if_government_provides_a_house_would_you_move_to_that_place"],
        doYouGetAnyBenefitOfSwasthyaSathiForHealthAssistance: json["do_you_get_any_benefit_of_swasthya_sathi_for_health_assistance"],
        willingToGoBackToNativeIfSuitableJobsAreMadeAvailable: json["willing_to_go_back_to_native_if_suitable_jobs_are_made_available"],
        whatDoYouSayAboutLifeInSlumAreas: json["what_do_you_say_about_life_in_slum_areas"],
        whatKindOfProblemsDoYouFace: json["what_kind_of_problems_do_you_face"],
        doYouFaceAnyProblemsFromIndustriesAroundYou: json["do_you_face_any_problems_from_industries_around_you"],
        whetherAllChildrenEnrolledInTheSchool: json["whether_all_children_enrolled_in_the_school"],
        ifYesWhichTypeOfSchool: json["if_yes_which_type_of_school"],
        ifNotGoingToSchoolDropOutAge: json["if_not_going_to_school_drop_out_age"],
        reasonOfDropOut: json["reason_of_drop_out"],
        ifMoreThanOneStudent: json["if_more_than_one_student"],
        alternativeEconomicActivitiesForLivelihood: json["alternative_economic_activities_for_livelihood"],
        anyFurtherSuggestionOrIssuesForImprovementRegardingSlums: json["any_further_suggestion_or_issues_for_improvement_regarding_slums"],
    );

    Map<String, dynamic> toJson() => {
        "survey_id": surveyId,
        "does_this_place_is_allotted_to_you_by_any_authority": doesThisPlaceIsAllottedToYouByAnyAuthority,
        "status_of_land": statusOfLand,
        "if_government_land_is_there_any_patta": ifGovernmentLandIsThereAnyPatta,
        "how_long_have_you_stayed_here": howLongHaveYouStayedHere,
        "types_of_work_in_which_you_are_engaged": typesOfWorkInWhichYouAreEngaged,
        "are_you_skilled_labour": areYouSkilledLabour,
        "if_yes_skill_type_carpenter_electrician_etc": ifYesSkillTypeCarpenterElectricianEtc,
        "due_to_the_covid19_has_the_income_and_job_been_affected": dueToTheCovid19HasTheIncomeAndJobBeenAffected,
        "do_you_get_any_ration_assistance_from_the_government": doYouGetAnyRationAssistanceFromTheGovernment,
        "type_of_ration_card_you_available": typeOfRationCardYouAvailable,
        "do_you_get_any_financial_assistance_from_the_government": doYouGetAnyFinancialAssistanceFromTheGovernment,
        "get_any_benefits_from_any_state_or_central_housing_schemes": getAnyBenefitsFromAnyStateOrCentralHousingSchemes,
        "allotted_house_under_slum_rehabilitation_project_of_government": allottedHouseUnderSlumRehabilitationProjectOfGovernment,
        "if_government_provides_a_house_would_you_move_to_that_place": ifGovernmentProvidesAHouseWouldYouMoveToThatPlace,
        "do_you_get_any_benefit_of_swasthya_sathi_for_health_assistance": doYouGetAnyBenefitOfSwasthyaSathiForHealthAssistance,
        "willing_to_go_back_to_native_if_suitable_jobs_are_made_available": willingToGoBackToNativeIfSuitableJobsAreMadeAvailable,
        "what_do_you_say_about_life_in_slum_areas": whatDoYouSayAboutLifeInSlumAreas,
        "what_kind_of_problems_do_you_face": whatKindOfProblemsDoYouFace,
        "do_you_face_any_problems_from_industries_around_you": doYouFaceAnyProblemsFromIndustriesAroundYou,
        "whether_all_children_enrolled_in_the_school": whetherAllChildrenEnrolledInTheSchool,
        "if_yes_which_type_of_school": ifYesWhichTypeOfSchool,
        "if_not_going_to_school_drop_out_age": ifNotGoingToSchoolDropOutAge,
        "reason_of_drop_out": reasonOfDropOut,
        "if_more_than_one_student": ifMoreThanOneStudent,
        "alternative_economic_activities_for_livelihood": alternativeEconomicActivitiesForLivelihood,
        "any_further_suggestion_or_issues_for_improvement_regarding_slums": anyFurtherSuggestionOrIssuesForImprovementRegardingSlums,
    };
}
