// // To parse this JSON data, do
// //
// //     final deviceId = deviceIdFromJson(jsonString);

// import 'dart:convert';

// DeviceId deviceIdFromJson(String str) => DeviceId.fromJson(json.decode(str));

// String deviceIdToJson(DeviceId data) => json.encode(data.toJson());

// class DeviceId {
//   DeviceId({
//     this.status,
//     this.message,
//     this.data,
//   });

//   bool status;
//   String message;
//   List<Datum> data;

//   factory DeviceId.fromJson(Map<String, dynamic> json) => DeviceId(
//         status: json["status"],
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   Datum(
//       {this.surveyId,
//       this.migrated,
//       this.are_you_willing_to_migrate_to_another_place,
//       this.after_covid19_situation_you_go_back_to_your_native_place,
//       this.user_family_status,
//       this.household_status,
//       this.housing_status,
//       this.economy_status,
//       this.transportation_status,
//       this.physical_infrastructure_status,
//       this.social_infrastructure_status,
//       this.slums_status,
//       this.coastal_status,
//       this.environmental_related_status,
//       this.cultural_heritage_status,
//       this.tourism_status,
//       this.if_yes_no_of_years,
//       this.place_of_origin,
//       this.migration_type,
//       this.reason_of_migration,
//       this.if_no_reasons_for_not_going_back_to_the_native_place,
//       this.age_of_house,
//       this.approx_price_range_of_land_per_katha,
//       this.asset_owned_by_household,
//       this.cooking_fuel_used_in_the_kitchen,
//       this.do_you_have_any_other_land_property,
//       this.house_condition,
//       this.if_no_are_you_willing_to_buy,
//       this.if_rented_amount,
//       this.if_yes_where,
//       this.land_ownership,
//       this.number_of_floors,
//       this.ownership_type,
//       this.roof,
//       this.type_of_house,
//       this.usage_of_residential_building,
//       this.wall});

//   String surveyId;

//   String user_family_status;
//   String household_status;
//   String housing_status;
//   String economy_status;
//   String transportation_status;
//   String physical_infrastructure_status;
//   String social_infrastructure_status;
//   String slums_status;
//   String coastal_status;
//   String environmental_related_status;
//   String cultural_heritage_status;
//   String tourism_status;
//   /*Household profile*/
//   String migrated;
//   String are_you_willing_to_migrate_to_another_place;
//   String after_covid19_situation_you_go_back_to_your_native_place;
//   String if_yes_no_of_years;
//   String place_of_origin;
//   String migration_type;
//   String reason_of_migration;
//   String if_no_reasons_for_not_going_back_to_the_native_place;
//   /*housing*/
//   String type_of_house;
//   String number_of_floors;
//   String wall;
//   String roof;
//   String age_of_house;
//   String house_condition;
//   String ownership_type;
//   String if_rented_amount;
//   String land_ownership;
//   String approx_price_range_of_land_per_katha;
//   String do_you_have_any_other_land_property;
//   String if_yes_where;
//   String if_no_are_you_willing_to_buy;
//   String usage_of_residential_building;
//   String asset_owned_by_household;
//   String cooking_fuel_used_in_the_kitchen;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//       user_family_status: json["user_family_status"],
//       household_status: json["household_status"],
//       housing_status: json["housing_status"],
//       economy_status: json["economy_status"],
//       transportation_status: json["transportation_status"],
//       physical_infrastructure_status: json["physical_infrastructure_status"],
//       social_infrastructure_status: json["social_infrastructure_status"],
//       slums_status: json["slums_status"],
//       coastal_status: json["coastal_status"],
//       environmental_related_status: json["environmental_related_status"],
//       cultural_heritage_status: json["cultural_heritage_status"],
//       tourism_status: json["tourism_status"],
//       surveyId: json["surveyId"],
//       migrated: json["migrated"],
//       are_you_willing_to_migrate_to_another_place:
//           json["are_you_willing_to_migrate_to_another_place"],
//       after_covid19_situation_you_go_back_to_your_native_place:
//           json["after_covid19_situation_you_go_back_to_your_native_place"],
//       if_yes_no_of_years: json["if_yes_no_of_years"],
//       place_of_origin: json["place_of_origin"],
//       migration_type: json["migration_type"],
//       reason_of_migration: json["reason_of_migration"],
//       if_no_reasons_for_not_going_back_to_the_native_place:
//           json["if_no_reasons_for_not_going_back_to_the_native_place"],
//       type_of_house: json["type_of_house"],
//       number_of_floors: json["number_of_floors"],
//       wall: json["wall"],
//       roof: json["roof"],
//       age_of_house: json["age_of_house"],
//       house_condition: json["house_condition"],
//       ownership_type: json["ownership_type"],
//       if_rented_amount: json["if_rented_amount"],
//       land_ownership: json["land_ownership"],
//       approx_price_range_of_land_per_katha:
//           json["approx_price_range_of_land_per_katha"],
//       do_you_have_any_other_land_property:
//           json["do_you_have_any_other_land_property"],
//       if_yes_where: json["if_yes_where"],
//       if_no_are_you_willing_to_buy: json["if_no_are_you_willing_to_buy"],
//       usage_of_residential_building: json["usage_of_residential_building"],
//       asset_owned_by_household: json["asset_owned_by_household"],
//       cooking_fuel_used_in_the_kitchen:
//           json["cooking_fuel_used_in_the_kitchen"]);

//   Map<String, dynamic> toJson() => {
//         "surveyId": surveyId,
//         "user_family_status": user_family_status,
//         "migrated": migrated,
//         "are_you_willing_to_migrate_to_another_place":
//             are_you_willing_to_migrate_to_another_place,
//         "after_covid19_situation_you_go_back_to_your_native_place":
//             after_covid19_situation_you_go_back_to_your_native_place
//       };
// }

// class SurveyDetailsSchema {
//   SurveyDetailsSchema(
//       {this.surveyId,
//       this.user_family_status,
//       this.household_status,
//       this.housing_status,
//       this.economy_status,
//       this.transportation_status,
//       this.physical_infrastructure_status,
//       this.social_infrastructure_status,
//       this.slums_status,
//       this.coastal_status,
//       this.environmental_related_status,
//       this.cultural_heritage_status,
//       this.tourism_status});

//   String surveyId;
//   String user_family_status;
//   String household_status;
//   String housing_status;
//   String economy_status;
//   String transportation_status;
//   String physical_infrastructure_status;
//   String social_infrastructure_status;
//   String slums_status;
//   String coastal_status;
//   String environmental_related_status;
//   String cultural_heritage_status;
//   String tourism_status;

//   factory SurveyDetailsSchema.fromJson(Map<String, dynamic> json) =>
//       SurveyDetailsSchema(
//           surveyId: json["surveyId"],
//           user_family_status: json["user_family_status"],
//           household_status: json["household_status"],
//           housing_status: json["housing_status"],
//           economy_status: json["economy_status"],
//           transportation_status: json["transportation_status"],
//           physical_infrastructure_status:
//               json["physical_infrastructure_status"],
//           social_infrastructure_status: json["social_infrastructure_status"],
//           slums_status: json["slums_status"],
//           coastal_status: json["coastal_status"],
//           environmental_related_status: json["environmental_related_status"],
//           cultural_heritage_status: json["cultural_heritage_status"],
//           tourism_status: json["tourism_status"]);

//   // Map<String, dynamic> toJson() =>
//   //     {"surveyId": surveyId, "user_family_status": user_family_status};
// }
// To parse this JSON data, do
//
//     final deviceId = deviceIdFromJson(jsonString);

import 'dart:convert';

DeviceId deviceIdFromJson(String str) => DeviceId.fromJson(json.decode(str));

String deviceIdToJson(DeviceId data) => json.encode(data.toJson());

class DeviceId {
  DeviceId({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory DeviceId.fromJson(Map<String, dynamic> json) => DeviceId(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum(
      {this.surveyId,
      this.migrated,
      this.are_you_willing_to_migrate_to_another_place,
      this.after_covid19_situation_you_go_back_to_your_native_place,
      this.user_family_status,
      this.household_status,
      this.housing_status,
      this.economy_status,
      this.transportation_status,
      this.physical_infrastructure_status,
      this.social_infrastructure_status,
      this.slums_status,
      this.coastal_status,
      this.environmental_related_status,
      this.cultural_heritage_status,
      this.tourism_status,
      this.if_yes_no_of_years,
      this.place_of_origin,
      this.migration_type,
      this.reason_of_migration,
      this.if_no_reasons_for_not_going_back_to_the_native_place,
      this.age_of_house,
      this.approx_price_range_of_land_per_katha,
      this.asset_owned_by_household,
      this.cooking_fuel_used_in_the_kitchen,
      this.do_you_have_any_other_land_property,
      this.house_condition,
      this.if_no_are_you_willing_to_buy,
      this.if_rented_amount,
      this.if_yes_where,
      this.land_ownership,
      this.number_of_floors,
      this.ownership_type,
      this.roof,
      this.type_of_house,
      this.usage_of_residential_building,
      this.usage_of_residential_building_text,
      this.wall,


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
        this.economyStatus,
        this.areTransportationAndConveyanceFacilitiesSatisfactory,
        this.beforeCovid19TheMostPreferredModeOfTransport,
        this.afterCovid19TheMostPreferredModeOfTransport,
        this.selfOwnedVehicles,
        this.modeOfTransportationPreferForSchoolOrCollege,
        this.distanceForSchoolCollege,
        this.modeOfTransportationPreferForMarketOrShoppingCentre,
        this.distanceForMarketOrShoppingCentre,
        this.modeOfTransportationPreferForHospitalOrHealthCentre,
        this.distanceForHospitalOrHealthCentre,
        this.modeOfTransportationPreferForParksCinemaMall,
        this.distanceForParksCinemaMall,
        this.modeOfTransportationForRailwayStationOrBusTerminal,
        this.distanceForRailwayStationOrBusTerminal,
        this.modeOfTransportationPreferForAirport,
        this.distanceForAirport,
        this.modeOfTransportationPreferForBankOrPostoffice,
        this.distanceForBankOrPostoffice,
        this.howOftenDoYouTravelOutstation,
        this.locationOfOutstation,
        this.preferredModeOfTransportationForOutstation,
        this.areThereAnySignagesProvided,
        this.isThereAnyFootpathProvided,
        this.isZebraCrossingProvidedNearJunctions,
        this.availabilityOfCycleTrackAndPedestrianPathway,
        this.ifYesIsThePathShadedWithTrees,
        this.anyFurtherSuggestionForImprovement,
        this.transportationStatus,
        this.sourceOfDrinkingWaterPotableWater,
        this.isConnectionAvailableWithinPremises,
        this.frequencyOfMunicipalSupply,
        this.durationOfSupply,
        this.qualityOfWater,
        this.areYouSatisfiedWithTheDrinkingWaterSupply,
        this.typeOfComplaints,
        this.complaintsRedressedTime,
        this.sourceOfElectricity,
        this.electricityConnection,
        this.powerCutDuration,
        this.availabilityOfStreetLights,
        this.ifYesConditionOfStreetLight,
        this.typeOfStreetLights,
        this.availabilityOfDrainageLine,
        this.householdWasteWaterOutlet,
        this.whereIsStormOrRainWaterCollected,
        this.whereIsHouseholdSolidWasteDisposedOff,
        this.ifDoorToDoorCollection,
        this.isSolidWasteSegregationAtHouseholdLevel,
        this.theBinsProvidedByMunicipality,
        this.physicalInfrastructureStatus,
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
        this.socialInfrastructureStatus,
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
        this.slumsStatus,
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
        this.coastalStatus,
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
        this.environmentalRelatedStatus,
        this.popularFestivalOccasion,
        this.thisPlaceHaveAnySignificantHeritageSiteStructure,
        this.visitorsDuringTheFestivalsOrOccasion,
        this.problemFacedDuringTheFestivalsAndOccasion,
        this.festiveOccasionPresenceHelpYouInTheEconomicGeneration,
        this.ifYesSpecifyHowFestivalsHelps,
        this.doTouristsVisitThisPlaceRegularlyOrDuringFestivals,
        this.anyFurtherSuggestionInCulturalHeritage,
        this.culturalHeritageStatus,
        this.doTouristsComeToThisRegionRegularly,
        this.bestSeasonForTouristToVisitAndWhy,
        this.areYouInvolvedInTouristsRelatedActivities,
        this.whichTypeOfActivitiesYoureInvolvedIn,
        this.anyOtherWorkEngagementApartFromTouristActivity,
        this.noOfPersonOrFamilyMemberEngageInSuchActivity,
        this.ifHandicraftWhatItemsDoYouSell,
        this.whomDoYouSellYourProductsToMostOften,
        this.participateInAnyFairOrMelaForProductShowcaseAndSell,
        this.ifYesWhereAndHowOftenDoYouVisit,
        this.availabilityOfTrainingCentreAndExhibitionCentre,
        this.sellOfProducts,
        this.tourismSectorHelpsInEconomicGrowthOfThisRegion,
        this.anyFurtherSuggestionForImprovementInTourism,
        this.tourismStatus,
      });

  String surveyId;

  String user_family_status;
  String household_status;
  String housing_status;
  String economy_status;
  String transportation_status;
  String physical_infrastructure_status;
  String social_infrastructure_status;
  String slums_status;
  String coastal_status;
  String environmental_related_status;
  String cultural_heritage_status;
  String tourism_status;
  /*Household profile*/
  String migrated;
  String are_you_willing_to_migrate_to_another_place;
  String after_covid19_situation_you_go_back_to_your_native_place;
  String if_yes_no_of_years;
  String place_of_origin;
  String migration_type;
  String reason_of_migration;
  String if_no_reasons_for_not_going_back_to_the_native_place;
  /*housing*/
  String type_of_house;
  String number_of_floors;
  String wall;
  String roof;
  String age_of_house;
  String house_condition;
  String ownership_type;
  String if_rented_amount;
  String land_ownership;
  String approx_price_range_of_land_per_katha;
  String do_you_have_any_other_land_property;
  String if_yes_where;
  String if_no_are_you_willing_to_buy;
  String usage_of_residential_building;
  String usage_of_residential_building_text;
  String asset_owned_by_household;
  String cooking_fuel_used_in_the_kitchen;

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
  String economyStatus;
  String areTransportationAndConveyanceFacilitiesSatisfactory;
  String beforeCovid19TheMostPreferredModeOfTransport;
  String afterCovid19TheMostPreferredModeOfTransport;
  String selfOwnedVehicles;
  String modeOfTransportationPreferForSchoolOrCollege;
  String distanceForSchoolCollege;
  String modeOfTransportationPreferForMarketOrShoppingCentre;
  String distanceForMarketOrShoppingCentre;
  String modeOfTransportationPreferForHospitalOrHealthCentre;
  String distanceForHospitalOrHealthCentre;
  String modeOfTransportationPreferForParksCinemaMall;
  String distanceForParksCinemaMall;
  String modeOfTransportationForRailwayStationOrBusTerminal;
  String distanceForRailwayStationOrBusTerminal;
  String modeOfTransportationPreferForAirport;
  String distanceForAirport;
  String modeOfTransportationPreferForBankOrPostoffice;
  String distanceForBankOrPostoffice;
  String howOftenDoYouTravelOutstation;
  String locationOfOutstation;
  String preferredModeOfTransportationForOutstation;
  String areThereAnySignagesProvided;
  String isThereAnyFootpathProvided;
  String isZebraCrossingProvidedNearJunctions;
  String availabilityOfCycleTrackAndPedestrianPathway;
  String ifYesIsThePathShadedWithTrees;
  String anyFurtherSuggestionForImprovement;
  String transportationStatus;
  String sourceOfDrinkingWaterPotableWater;
  String isConnectionAvailableWithinPremises;
  String frequencyOfMunicipalSupply;
  String durationOfSupply;
  String qualityOfWater;
  String areYouSatisfiedWithTheDrinkingWaterSupply;
  String typeOfComplaints;
  String complaintsRedressedTime;
  String sourceOfElectricity;
  String electricityConnection;
  String powerCutDuration;
  String availabilityOfStreetLights;
  String ifYesConditionOfStreetLight;
  String typeOfStreetLights;
  String availabilityOfDrainageLine;
  String householdWasteWaterOutlet;
  String whereIsStormOrRainWaterCollected;
  String whereIsHouseholdSolidWasteDisposedOff;
  String ifDoorToDoorCollection;
  String isSolidWasteSegregationAtHouseholdLevel;
  String theBinsProvidedByMunicipality;
  String physicalInfrastructureStatus;
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
  String socialInfrastructureStatus;
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
  String slumsStatus;
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
  String coastalStatus;
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
  String environmentalRelatedStatus;
  String popularFestivalOccasion;
  String thisPlaceHaveAnySignificantHeritageSiteStructure;
  String visitorsDuringTheFestivalsOrOccasion;
  String problemFacedDuringTheFestivalsAndOccasion;
  String festiveOccasionPresenceHelpYouInTheEconomicGeneration;
  String ifYesSpecifyHowFestivalsHelps;
  String doTouristsVisitThisPlaceRegularlyOrDuringFestivals;
  String anyFurtherSuggestionInCulturalHeritage;
  String culturalHeritageStatus;
  String doTouristsComeToThisRegionRegularly;
  String bestSeasonForTouristToVisitAndWhy;
  String areYouInvolvedInTouristsRelatedActivities;
  String whichTypeOfActivitiesYoureInvolvedIn;
  String anyOtherWorkEngagementApartFromTouristActivity;
  String noOfPersonOrFamilyMemberEngageInSuchActivity;
  String ifHandicraftWhatItemsDoYouSell;
  String whomDoYouSellYourProductsToMostOften;
  String participateInAnyFairOrMelaForProductShowcaseAndSell;
  Null ifYesWhereAndHowOftenDoYouVisit;
  String availabilityOfTrainingCentreAndExhibitionCentre;
  String sellOfProducts;
  String tourismSectorHelpsInEconomicGrowthOfThisRegion;
  String anyFurtherSuggestionForImprovementInTourism;
  String tourismStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      user_family_status: json["user_family_status"],
      household_status: json["household_status"],
      housing_status: json["housing_status"],
      economy_status: json["economy_status"],
      transportation_status: json["transportation_status"],
      physical_infrastructure_status: json["physical_infrastructure_status"],
      social_infrastructure_status: json["social_infrastructure_status"],
      slums_status: json["slums_status"],
      coastal_status: json["coastal_status"],
      environmental_related_status: json["environmental_related_status"],
      cultural_heritage_status: json["cultural_heritage_status"],
      tourism_status: json["tourism_status"],
      surveyId: json["surveyId"],
      migrated: json["migrated"],
      are_you_willing_to_migrate_to_another_place:
          json["are_you_willing_to_migrate_to_another_place"],
      after_covid19_situation_you_go_back_to_your_native_place:
          json["after_covid19_situation_you_go_back_to_your_native_place"],
      if_yes_no_of_years: json["if_yes_no_of_years"],
      place_of_origin: json["place_of_origin"],
      migration_type: json["migration_type"],
      reason_of_migration: json["reason_of_migration"],
      if_no_reasons_for_not_going_back_to_the_native_place:
          json["if_no_reasons_for_not_going_back_to_the_native_place"],
      type_of_house: json["type_of_house"],
      number_of_floors: json["number_of_floors"],
      wall: json["wall"],
      roof: json["roof"],
      age_of_house: json["age_of_house"],
      house_condition: json["house_condition"],
      ownership_type: json["ownership_type"],
      if_rented_amount: json["if_rented_amount"],
      land_ownership: json["land_ownership"],
      approx_price_range_of_land_per_katha:
          json["approx_price_range_of_land_per_katha"],
      do_you_have_any_other_land_property:
          json["do_you_have_any_other_land_property"],
      if_yes_where: json["if_yes_where"],
      if_no_are_you_willing_to_buy: json["if_no_are_you_willing_to_buy"],
      usage_of_residential_building: json["usage_of_residential_building"],
      usage_of_residential_building_text: json["usage_of_residential_building_text"],
      asset_owned_by_household: json["asset_owned_by_household"],
      cooking_fuel_used_in_the_kitchen:
          json["cooking_fuel_used_in_the_kitchen"],

    typeOfEmploymentEngagement : json['type_of_employment_engagement'],
    occupation : json['occupation'],
    ifConstructionWorker : json['if_construction_worker'],
    ifIndustrialWorkerInWhichIndustryDoYouWork :
    json['if_industrial_worker_in_which_industry_do_you_work'],
    ifThereIsAnotherFamilyMemberWhoIsEmployed :
    json['if_there_is_another_family_member_who_is_employed'],
    typeOfEmploymentEngagementAnotherFamilyMember :
    json['type_of_employment_engagement_another_family_member'],
    occupationAnotherFamilyMember : json['occupation_another_family_member'],
    ifConstructionWorkerAnotherFamilyMember :
    json['if_construction_worker_another_family_member'],
    ifIndustrialWorkerAnotherFamilyMember :
    json['if_industrial_worker_another_family_member'],
    isAnyOfTheFamilyMembersWorkingAsPartTimeEmployees :
    json['is_any_of_the_family_members_working_as_part_time_employees'],
    ifYesWhichTypeOfIndustryCompanyOffice :
    json['if_yes_which_type_of_industry_company_Office'],
    afterCovid19ImpactOnJobOpportunityAvailability :
    json['after_covid19_impact_on_job_opportunity_Availability'],
    doesTheIndustrialSectorBeenAffectedAfterCovid19 :
    json['does_the_industrial_sector_been_affected_after_covid19'],
    suggestionsForHowJobOpportunitiesCanBeMadeAvailable :
    json['suggestions_for_how_job_opportunities_can_be_made_available'],
    doesAnyFamilyMemberReceiveAPension :
    json['does_any_family_member_receive_a_pension'],
    ifYesSpecifyWhich : json['if_yes_specify_which'],
    whatIsYourMonthlyExpenditure : json['what_is_your_monthly_expenditure'],
    impactOnMonthlyExpenditureAfterCovid19 :
    json['impact_on_monthly_expenditure_after_covid19'],
    howOftenYouVisitTheMarketBeforeCovid19 :
    json['how_often_you_visit_the_market_before_covid19'],
    howOftenYouVisitTheMarketAfterCovid19 :
    json['how_often_you_visit_the_market_after_covid19'],
    mostPreferredWayOfShoppingAfterCovid19 :
    json['most_preferred_way_of_shopping_after_covid19'],
    mostPreferredWayOfShoppingBeforeCovid19 :
    json['most_preferred_way_of_shopping_before_covid19'],
    howOftenDoYouDoOnlineShopping : json['how_often_do_you_do_online_shopping'],
    economyStatus : json['economy_status'],
    areTransportationAndConveyanceFacilitiesSatisfactory :
    json['are_transportation_and_conveyance_facilities_satisfactory'],
    beforeCovid19TheMostPreferredModeOfTransport :
    json['before_Covid19_the_most_preferred_mode_of_transport'],
    afterCovid19TheMostPreferredModeOfTransport :
    json['after_covid19_the_most_preferred_mode_of_transport'],
    selfOwnedVehicles : json['self_owned_vehicles'],
    modeOfTransportationPreferForSchoolOrCollege :
    json['mode_of_transportation_prefer_for_school_or_college'],
    distanceForSchoolCollege : json['distance_for_school_college'],
    modeOfTransportationPreferForMarketOrShoppingCentre :
    json['mode_of_transportation_prefer_for_market_or_shopping_centre'],
    distanceForMarketOrShoppingCentre :
    json['distance_for_market_or_shopping_centre'],
    modeOfTransportationPreferForHospitalOrHealthCentre :
    json['mode_of_transportation_prefer_for_hospital_or_health_centre'],
    distanceForHospitalOrHealthCentre :
    json['distance_for_hospital_or_health_centre'],
    modeOfTransportationPreferForParksCinemaMall :
    json['mode_of_transportation_prefer_for_parks_cinema_mall'],
    distanceForParksCinemaMall : json['distance_for_parks_cinema_mall'],
    modeOfTransportationForRailwayStationOrBusTerminal :
    json['mode_of_transportation_for_railway_station_or_bus_terminal'],
    distanceForRailwayStationOrBusTerminal :
    json['distance_for_railway_station_or_bus_terminal'],
    modeOfTransportationPreferForAirport :
    json['mode_of_transportation_prefer_for_airport'],
    distanceForAirport : json['distance_for_airport'],
    modeOfTransportationPreferForBankOrPostoffice :
    json['mode_of_transportation_prefer_for_bank_or_postoffice'],
    distanceForBankOrPostoffice : json['distance_for_bank_or_postoffice'],
    howOftenDoYouTravelOutstation : json['how_often_do_you_travel_outstation'],
    locationOfOutstation : json['location_of_outstation'],
    preferredModeOfTransportationForOutstation :
    json['preferred_mode_of_transportation_for_outstation'],
    areThereAnySignagesProvided : json['are_there_any_signages_provided'],
    isThereAnyFootpathProvided : json['is_there_any_footpath_provided'],
    isZebraCrossingProvidedNearJunctions :
    json['is_zebra_crossing_provided_near_junctions'],
    availabilityOfCycleTrackAndPedestrianPathway :
    json['availability_of_cycle_track_and_pedestrian_pathway'],
    ifYesIsThePathShadedWithTrees :
    json['if_yes_is_the_path_shaded_with_trees'],
    anyFurtherSuggestionForImprovement :
    json['any_further_suggestion_for_improvement'],
    transportationStatus : json['transportation_status'],
    sourceOfDrinkingWaterPotableWater :
    json['source_of_drinking_water_potable_water'],
    isConnectionAvailableWithinPremises :
    json['is_connection_available_within_premises'],
    frequencyOfMunicipalSupply : json['frequency_of_municipal_supply'],
    durationOfSupply : json['duration_of_supply'],
    qualityOfWater : json['quality_of_water'],
    areYouSatisfiedWithTheDrinkingWaterSupply :
    json['are_you_satisfied_with_the_drinking_water_supply'],
    typeOfComplaints : json['type_of_complaints'],
    complaintsRedressedTime : json['complaints_redressed_time'],
    sourceOfElectricity : json['source_of_electricity'],
    electricityConnection : json['electricity_connection'],
    powerCutDuration : json['power_cut_duration'],
    availabilityOfStreetLights : json['availability_of_street_lights'],
    ifYesConditionOfStreetLight : json['if_yes_condition_of_street_light'],
    typeOfStreetLights : json['type_of_street_lights'],
    availabilityOfDrainageLine : json['availability_of_drainage_line'],
    householdWasteWaterOutlet : json['household_waste_water_outlet'],
    whereIsStormOrRainWaterCollected :
    json['where_is_storm_or_rain_water_collected'],
    whereIsHouseholdSolidWasteDisposedOff :
    json['where_is_household_solid_waste_disposed_off'],
    ifDoorToDoorCollection : json['if_door_to_door_collection'],
    isSolidWasteSegregationAtHouseholdLevel :
    json['is_solid_waste_segregation_at_household_level'],
    theBinsProvidedByMunicipality : json['the_bins_provided_by_municipality'],
    physicalInfrastructureStatus : json['physical_infrastructure_status'],
    whichTypeOfSchoolorEducationInfrastructureDoYouPrefer :
    json['which_type_of_schoolor_education_infrastructure_do_you_prefer'],
    typeOfEducationAvailabilityAndTheirDistance :
    json['type_of_education_availability_and_their_distance'],
    mostPreferredMode : json['most_preferred_mode'],
    doYouThinkYourRegionHasGoodOpportunitiesInEducation :
    json['do_you_think_your_region_has_good_opportunities_in_education'],
    anyFurtherSuggestionsOrIssuesForImprovementInEducation :
    json['any_further_suggestions_or_issues_for_improvement_in_education'],
    mostPreferredHealthFacility : json['most_preferred_health_facility'],
    distance : json['distance'],
    doYouThinkYourRegionHasGoodInHealthFacilities :
    json['do_you_think_your_region_has_good_in_health_facilities'],
    anySuggestionsForImprovementInHealthFacilities :
    json['any_suggestions_for_improvement_in_health_facilities'],
    availabilityOfParksPlaygroundOrOtherRecreationSpaces :
    json['availability_of_parks_playground_or_other_recreation_spaces'],
    doYouOrYourFamilyMembersGoToAParkOrPlayground :
    json['do_you_or_your_family_members_go_to_a_park_or_playground'],
    ifYesHowRegularYouGoToParkOrPlayground :
    json['if_yes_how_regular_you_go_to_park_or_playground'],
    anyFurtherSuggestionOrIssuesForImprovementInParks :
    json['any_further_suggestion_or_issues_for_improvement_in_parks'],
    doYouReceiveAnyGrantFromAnyStateGovtFlagshipScheme :
    json['do_you_receive_any_grant_from_any_state_govt_flagship_scheme'],
    ifAvailingAnyOtherSchemesPleaseSpecify :
    json['if_availing_any_other_schemes_please_specify'],
    socialInfrastructureStatus : json['social_infrastructure_status'],
    doesThisPlaceIsAllottedToYouByAnyAuthority :
    json['does_this_place_is_allotted_to_you_by_any_authority'],
    statusOfLand : json['status_of_land'],
    ifGovernmentLandIsThereAnyPatta :
    json['if_government_land_is_there_any_patta'],
    howLongHaveYouStayedHere : json['how_long_have_you_stayed_here'],
    typesOfWorkInWhichYouAreEngaged :
    json['types_of_work_in_which_you_are_engaged'],
    areYouSkilledLabour : json['are_you_skilled_labour'],
    ifYesSkillTypeCarpenterElectricianEtc :
    json['if_yes_skill_type_carpenter_electrician_etc'],
    dueToTheCovid19HasTheIncomeAndJobBeenAffected :
    json['due_to_the_covid19_has_the_income_and_job_been_affected'],
    doYouGetAnyRationAssistanceFromTheGovernment :
    json['do_you_get_any_ration_assistance_from_the_government'],
    typeOfRationCardYouAvailable : json['type_of_ration_card_you_available'],
    doYouGetAnyFinancialAssistanceFromTheGovernment :
    json['do_you_get_any_financial_assistance_from_the_government'],
    getAnyBenefitsFromAnyStateOrCentralHousingSchemes :
    json['get_any_benefits_from_any_state_or_central_housing_schemes'],
    allottedHouseUnderSlumRehabilitationProjectOfGovernment :
    json['allotted_house_under_slum_rehabilitation_project_of_government'],
    ifGovernmentProvidesAHouseWouldYouMoveToThatPlace :
    json['if_government_provides_a_house_would_you_move_to_that_place'],
    doYouGetAnyBenefitOfSwasthyaSathiForHealthAssistance :
    json['do_you_get_any_benefit_of_swasthya_sathi_for_health_assistance'],
    willingToGoBackToNativeIfSuitableJobsAreMadeAvailable : json[
    'willing_to_go_back_to_native_if_suitable_jobs_are_made_available'],
    whatDoYouSayAboutLifeInSlumAreas :
    json['what_do_you_say_about_life_in_slum_areas'],
    whatKindOfProblemsDoYouFace : json['what_kind_of_problems_do_you_face'],
    doYouFaceAnyProblemsFromIndustriesAroundYou :
    json['do_you_face_any_problems_from_industries_around_you'],
    whetherAllChildrenEnrolledInTheSchool :
    json['whether_all_children_enrolled_in_the_school'],
    ifYesWhichTypeOfSchool : json['if_yes_which_type_of_school'],
    ifNotGoingToSchoolDropOutAge : json['if_not_going_to_school_drop_out_age'],
    reasonOfDropOut : json['reason_of_drop_out'],
    ifMoreThanOneStudent : json['if_more_than_one_student'],
    alternativeEconomicActivitiesForLivelihood :
    json['alternative_economic_activities_for_livelihood'],
    anyFurtherSuggestionOrIssuesForImprovementRegardingSlums : json[
    'any_further_suggestion_or_issues_for_improvement_regarding_slums'],
    slumsStatus : json['slums_status'],
    doYouHaveBoats : json['do_you_have_boats'],
    ifYesThePurposeOfUsingBoats : json['if_yes_the_purpose_of_using_boats'],
    areYouAssociatedWithFishingRelatedActivities :
    json['are_you_associated_with_fishing_related_activities'],
    ifYesThenSpecifyAsSellerCatcherSupplierOrOther :
    json['if_yes_then_specify_as_seller_catcher_supplier_or_other'],
    haveYouBeenEngagedInOtherActivitiesApartFromFishing :
    json['have_you_been_engaged_in_other_activities_apart_from_fishing'],
    ifYesSpecifyTheActivities : json['if_yes_specify_the_activities'],
    doYouThinkLivingInCoastalRegionIsThreatOrOpportunity :
    json['do_you_think_living_in_coastal_region_is_threat_or_opportunity'],
    howDoYouGetTheInformationRelatedToNaturalThreats :
    json['how_do_you_get_the_information_related_to_natural_threats'],
    safePlaceDuringNaturalEvents : json['safe_place_during_natural_events'],
    afterNaturalDisasterHowManyDaysTakeComeToNormal :
    json['after_natural_disaster_how_many_days_take_come_to_normal'],
    majorDamagesDuringNaturalCalamities :
    json['major_damages_during_natural_calamities'],
    availabilityOfRationDuringTheNaturalDisaster :
    json['availability_of_ration_during_the_natural_disaster'],
    whetherAnyFundAreaGrantedForTheFloodProneArea :
    json['whether_any_fund_area_granted_for_the_flood_prone_area'],
    doesThisRegionHaveAnyTourismOpportunities :
    json['does_this_region_have_any_tourism_opportunities'],
    anyFurtherSuggestionsOrIssuesInCoastalRegion :
    json['any_further_suggestions_or_issues_in_coastal_region'],
    coastalStatus : json['coastal_status'],
    familyOrNearbyPersonSufferedFromDiseasesInLastFewYears : json[
    'family_or_nearby_person_suffered_from_diseases_in_last_few_years'],
    ifYesWhichDiseasesSpecify : json['if_yes_which_diseases_specify'],
    doYouOrFamilyMemberFaceAnyProblemInBreathing :
    json['do_you_or_family_member_face_any_problem_in_breathing'],
    majorCauseOfPollution : json['major_cause_of_pollution'],
    doYouFaceAnyIssuesDuringTheRainySeason :
    json['do_you_face_any_issues_during_the_rainy_season'],
    ifYesSpecifyIssuesFacedInRainySeason :
    json['if_yes_specify_issues_faced_in_rainy_season'],
    whetherTheAreaIsProneToFloodingDueToRains :
    json['whether_the_area_is_prone_to_flooding_due_to_rains'],
    ifYesHowManyDaysItTakesToNormalCondition :
    json['if_yes_how_many_days_it_takes_to_normal_condition'],
    duringFloodingIsRehabilitationCentresAvailable :
    json['during_flooding_is_rehabilitation_centres_available'],
    whetherAnyFundsGrantedToYouForSuchDisaster :
    json['whether_any_funds_granted_to_you_for_such_disaster'],
    doHoardingsCreateAnyVisualDisturbanceWhileDriving :
    json['do_hoardings_create_any_visual_disturbance_while_driving'],
    doesTrafficMovementAndNoiseAnIssueForYourLocality :
    json['does_traffic_movement_and_noise_an_issue_for_your_locality'],
    ifYesSuggestionForImprovementInTrafficIssue :
    json['if_yes_suggestion_for_improvement_in_traffic_issue'],
    whetherTheWasteDisposedOffInANearbyRiverOrWaterBody :
    json['whether_the_waste_disposed_off_in_a_nearby_river_or_water_body'],
    anyFurtherSuggestionForImprovementInEnvironment :
    json['any_further_suggestion_for_improvement_in_environment'],
    environmentalRelatedStatus : json['environmental_related_status'],
    popularFestivalOccasion : json['popular_festival_occasion'],
    thisPlaceHaveAnySignificantHeritageSiteStructure :
    json['this_place_have_any_significant_heritage_site_structure'],
    visitorsDuringTheFestivalsOrOccasion :
    json['visitors_during_the_festivals_or_occasion'],
    problemFacedDuringTheFestivalsAndOccasion :
    json['problem_faced_during_the_festivals_and_occasion'],
    festiveOccasionPresenceHelpYouInTheEconomicGeneration :
    json['festive_occasion_presence_help_you_in_the_economic_generation'],
    ifYesSpecifyHowFestivalsHelps : json['if_yes_specify_how_festivals_helps'],
    doTouristsVisitThisPlaceRegularlyOrDuringFestivals :
    json['do_tourists_visit_this_place_regularly_or_during_festivals'],
    anyFurtherSuggestionInCulturalHeritage :
    json['any_further_suggestion_in_cultural_heritage'],
    culturalHeritageStatus : json['cultural_heritage_status'],
    doTouristsComeToThisRegionRegularly :
    json['do_tourists_come_to_this_region_regularly'],
    bestSeasonForTouristToVisitAndWhy :
    json['best_season_for_tourist_to_visit_and_why'],
    areYouInvolvedInTouristsRelatedActivities :
    json['are_you_involved_in_tourists_related_activities'],
    whichTypeOfActivitiesYoureInvolvedIn :
    json['which_type_of_activities_youre_involved_in'],
    anyOtherWorkEngagementApartFromTouristActivity :
    json['any_other_work_engagement_apart_from_tourist_activity'],
    noOfPersonOrFamilyMemberEngageInSuchActivity :
    json['no_of_person_or_family_member_engage_in_such_activity'],
    ifHandicraftWhatItemsDoYouSell :
    json['if_handicraft_what_items_do_you_sell'],
    whomDoYouSellYourProductsToMostOften :
    json['whom_do_you_sell_your_products_to_most_often'],
    participateInAnyFairOrMelaForProductShowcaseAndSell :
    json['participate_in_any_fair_or_mela_for_product_showcase_and_sell'],
    ifYesWhereAndHowOftenDoYouVisit :
    json['if_yes_where_and_how_often_do_you_visit'],
    availabilityOfTrainingCentreAndExhibitionCentre :
    json['availability_of_training_centre_and_exhibition_centre'],
    sellOfProducts : json['sell_of_products'],
    tourismSectorHelpsInEconomicGrowthOfThisRegion :
    json['tourism_sector_helps_in_economic_growth_of_this_region'],
    anyFurtherSuggestionForImprovementInTourism :
    json['any_further_suggestion_for_improvement_in_tourism'],
    tourismStatus : json['tourism_status'],
  );



  Map<String, dynamic> toJson() => {
        "surveyId": surveyId,
        "user_family_status": user_family_status,
        "migrated": migrated,
        "are_you_willing_to_migrate_to_another_place":
            are_you_willing_to_migrate_to_another_place,
        "after_covid19_situation_you_go_back_to_your_native_place":
            after_covid19_situation_you_go_back_to_your_native_place
      };
}
