// To parse this JSON data, do
//
//     final housingApiModel = housingApiModelFromJson(jsonString);

import 'dart:convert';

HousingApiModel housingApiModelFromJson(String str) => HousingApiModel.fromJson(json.decode(str));

String housingApiModelToJson(HousingApiModel data) => json.encode(data.toJson());

class HousingApiModel {
    HousingApiModel({
        this.surveyId,
        this.typeOfHouse,
        this.numberOfFloors,
        this.wall,
        this.roof,
        this.ageOfHouse,
        this.houseCondition,
        this.ownershipType,
        this.ifRentedAmount,
        this.landOwnership,
        this.approxPriceRangeOfLandPerKatha,
        this.doYouHaveAnyOtherLandProperty,
        this.ifYesWhere,
        this.ifNoAreYouWillingToBuy,
        this.usageOfResidentialBuilding,
        this.assetOwnedByHousehold,
        this.cookingFuelUsedInTheKitchen,
    });

    String surveyId;
    String typeOfHouse;
    String numberOfFloors;
    String wall;
    String roof;
    String ageOfHouse;
    String houseCondition;
    String ownershipType;
    String ifRentedAmount;
    String landOwnership;
    String approxPriceRangeOfLandPerKatha;
    String doYouHaveAnyOtherLandProperty;
    String ifYesWhere;
    String ifNoAreYouWillingToBuy;
    String usageOfResidentialBuilding;
    String assetOwnedByHousehold;
    String cookingFuelUsedInTheKitchen;

    factory HousingApiModel.fromJson(Map<String, dynamic> json) => HousingApiModel(
        surveyId: json["survey_id"],
        typeOfHouse: json["type_of_house"],
        numberOfFloors: json["number_of_floors"],
        wall: json["wall"],
        roof: json["roof"],
        ageOfHouse: json["age_of_house"],
        houseCondition: json["house_condition"],
        ownershipType: json["ownership_type"],
        ifRentedAmount: json["if_rented_amount"],
        landOwnership: json["land_ownership"],
        approxPriceRangeOfLandPerKatha: json["approx_price_range_of_land_per_katha"],
        doYouHaveAnyOtherLandProperty: json["do_you_have_any_other_land_property"],
        ifYesWhere: json["if_yes_where"],
        ifNoAreYouWillingToBuy: json["if_no_are_you_willing_to_buy"],
        usageOfResidentialBuilding: json["usage_of_residential_building"],
        assetOwnedByHousehold: json["asset_owned_by_household"],
        cookingFuelUsedInTheKitchen: json["cooking_fuel_used_in_the_kitchen"],
    );

    Map<String, dynamic> toJson() => {
        "survey_id": surveyId,
        "type_of_house": typeOfHouse,
        "number_of_floors": numberOfFloors,
        "wall": wall,
        "roof": roof,
        "age_of_house": ageOfHouse,
        "house_condition": houseCondition,
        "ownership_type": ownershipType,
        "if_rented_amount": ifRentedAmount,
        "land_ownership": landOwnership,
        "approx_price_range_of_land_per_katha": approxPriceRangeOfLandPerKatha,
        "do_you_have_any_other_land_property": doYouHaveAnyOtherLandProperty,
        "if_yes_where": ifYesWhere,
        "if_no_are_you_willing_to_buy": ifNoAreYouWillingToBuy,
        "usage_of_residential_building": usageOfResidentialBuilding,
        "asset_owned_by_household": assetOwnedByHousehold,
        "cooking_fuel_used_in_the_kitchen": cookingFuelUsedInTheKitchen,
    };
}
