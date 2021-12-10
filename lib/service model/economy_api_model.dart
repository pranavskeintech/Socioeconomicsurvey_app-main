// To parse this JSON data, do
//
//     final economyApiModel = economyApiModelFromJson(jsonString);

import 'dart:convert';

EconomyApiModel economyApiModelFromJson(String str) => EconomyApiModel.fromJson(json.decode(str));

String economyApiModelToJson(EconomyApiModel data) => json.encode(data.toJson());

class EconomyApiModel {
    EconomyApiModel({
        this.surveyId,
        this.typeOfEmploymentEngagement,
        this.occupation,
        this.ifConstructionWorker,
        this.ifIndustrialWorkerInWhichIndustryDoYouWork,
        this.ifThereIsAnotherFamilyMemberWhoIsEmployed,
        this.typeOfEmploymentEngagementAnotherFamilyMember,
        this.occupationAnotherFamilyMember,
        this.ifConstructionWorkerAnotherFamilyMember,
        this.ifIndustrialWorkerAnotherFamilyMember,
        this.isAnyOfTheFamilyMembersWorkingAsPartTimeEmployees,
        this.ifYesWhichTypeOfIndustryCompanyOffice,
        this.afterCovid19ImpactOnJobOpportunityAvailability,
        this.doesTheIndustrialSectorBeenAffectedAfterCovid19,
        this.suggestionsForHowJobOpportunitiesCanBeMadeAvailable,
        this.doesAnyFamilyMemberReceiveAPension,
        this.ifYesSpecifyWhich,
        this.whatIsYourMonthlyExpenditure,
        this.impactOnMonthlyExpenditureAfterCovid19,
        this.howOftenYouVisitTheMarketBeforeCovid19,
        this.howOftenYouVisitTheMarketAfterCovid19,
        this.mostPreferredWayOfShoppingAfterCovid19,
        this.mostPreferredWayOfShoppingBeforeCovid19,
        this.howOftenDoYouDoOnlineShopping,
    });

    String surveyId;
    String typeOfEmploymentEngagement;
    String occupation;
    String ifConstructionWorker;
    String ifIndustrialWorkerInWhichIndustryDoYouWork;
    String ifThereIsAnotherFamilyMemberWhoIsEmployed;
    String typeOfEmploymentEngagementAnotherFamilyMember;
    String occupationAnotherFamilyMember;
    String ifConstructionWorkerAnotherFamilyMember;
    String ifIndustrialWorkerAnotherFamilyMember;
    String isAnyOfTheFamilyMembersWorkingAsPartTimeEmployees;
    String ifYesWhichTypeOfIndustryCompanyOffice;
    String afterCovid19ImpactOnJobOpportunityAvailability;
    String doesTheIndustrialSectorBeenAffectedAfterCovid19;
    String suggestionsForHowJobOpportunitiesCanBeMadeAvailable;
    String doesAnyFamilyMemberReceiveAPension;
    String ifYesSpecifyWhich;
    String whatIsYourMonthlyExpenditure;
    String impactOnMonthlyExpenditureAfterCovid19;
    String howOftenYouVisitTheMarketBeforeCovid19;
    String howOftenYouVisitTheMarketAfterCovid19;
    String mostPreferredWayOfShoppingAfterCovid19;
    String mostPreferredWayOfShoppingBeforeCovid19;
    String howOftenDoYouDoOnlineShopping;

    factory EconomyApiModel.fromJson(Map<String, dynamic> json) => EconomyApiModel(
        surveyId: json["survey_id"],
        typeOfEmploymentEngagement: json["type_of_employment_engagement"],
        occupation: json["occupation"],
        ifConstructionWorker: json["if_construction_worker"],
        ifIndustrialWorkerInWhichIndustryDoYouWork: json["if_industrial_worker_in_which_industry_do_you_work"],
        ifThereIsAnotherFamilyMemberWhoIsEmployed: json["if_there_is_another_family_member_who_is_employed"],
        typeOfEmploymentEngagementAnotherFamilyMember: json["type_of_employment_engagement_another_family_member"],
        occupationAnotherFamilyMember: json["occupation_another_family_member"],
        ifConstructionWorkerAnotherFamilyMember: json["if_construction_worker_another_family_member"],
        ifIndustrialWorkerAnotherFamilyMember: json["if_industrial_worker_another_family_member"],
        isAnyOfTheFamilyMembersWorkingAsPartTimeEmployees: json["is_any_of_the_family_members_working_as_part_time_employees"],
        ifYesWhichTypeOfIndustryCompanyOffice: json["if_yes_which_type_of_industry_company_Office"],
        afterCovid19ImpactOnJobOpportunityAvailability: json["after_covid19_impact_on_job_opportunity_Availability"],
        doesTheIndustrialSectorBeenAffectedAfterCovid19: json["does_the_industrial_sector_been_affected_after_covid19"],
        suggestionsForHowJobOpportunitiesCanBeMadeAvailable: json["suggestions_for_how_job_opportunities_can_be_made_available"],
        doesAnyFamilyMemberReceiveAPension: json["does_any_family_member_receive_a_pension"],
        ifYesSpecifyWhich: json["if_yes_specify_which"],
        whatIsYourMonthlyExpenditure: json["what_is_your_monthly_expenditure"],
        impactOnMonthlyExpenditureAfterCovid19: json["impact_on_monthly_expenditure_after_covid19"],
        howOftenYouVisitTheMarketBeforeCovid19: json["how_often_you_visit_the_market_before_covid19"],
        howOftenYouVisitTheMarketAfterCovid19: json["how_often_you_visit_the_market_after_covid19"],
        mostPreferredWayOfShoppingAfterCovid19: json["most_preferred_way_of_shopping_after_covid19"],
        mostPreferredWayOfShoppingBeforeCovid19: json["most_preferred_way_of_shopping_before_covid19"],
        howOftenDoYouDoOnlineShopping: json["how_often_do_you_do_online_shopping"],
    );

    Map<String, dynamic> toJson() => {
        "survey_id": surveyId,
        "type_of_employment_engagement": typeOfEmploymentEngagement,
        "occupation": occupation,
        "if_construction_worker": ifConstructionWorker,
        "if_industrial_worker_in_which_industry_do_you_work": ifIndustrialWorkerInWhichIndustryDoYouWork,
        "if_there_is_another_family_member_who_is_employed": ifThereIsAnotherFamilyMemberWhoIsEmployed,
        "type_of_employment_engagement_another_family_member": typeOfEmploymentEngagementAnotherFamilyMember,
        "occupation_another_family_member": occupationAnotherFamilyMember,
        "if_construction_worker_another_family_member": ifConstructionWorkerAnotherFamilyMember,
        "if_industrial_worker_another_family_member": ifIndustrialWorkerAnotherFamilyMember,
        "is_any_of_the_family_members_working_as_part_time_employees": isAnyOfTheFamilyMembersWorkingAsPartTimeEmployees,
        "if_yes_which_type_of_industry_company_Office": ifYesWhichTypeOfIndustryCompanyOffice,
        "after_covid19_impact_on_job_opportunity_Availability": afterCovid19ImpactOnJobOpportunityAvailability,
        "does_the_industrial_sector_been_affected_after_covid19": doesTheIndustrialSectorBeenAffectedAfterCovid19,
        "suggestions_for_how_job_opportunities_can_be_made_available": suggestionsForHowJobOpportunitiesCanBeMadeAvailable,
        "does_any_family_member_receive_a_pension": doesAnyFamilyMemberReceiveAPension,
        "if_yes_specify_which": ifYesSpecifyWhich,
        "what_is_your_monthly_expenditure": whatIsYourMonthlyExpenditure,
        "impact_on_monthly_expenditure_after_covid19": impactOnMonthlyExpenditureAfterCovid19,
        "how_often_you_visit_the_market_before_covid19": howOftenYouVisitTheMarketBeforeCovid19,
        "how_often_you_visit_the_market_after_covid19": howOftenYouVisitTheMarketAfterCovid19,
        "most_preferred_way_of_shopping_after_covid19": mostPreferredWayOfShoppingAfterCovid19,
        "most_preferred_way_of_shopping_before_covid19": mostPreferredWayOfShoppingBeforeCovid19,
        "how_often_do_you_do_online_shopping": howOftenDoYouDoOnlineShopping,
    };
}
