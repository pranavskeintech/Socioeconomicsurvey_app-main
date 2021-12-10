// To parse this JSON data, do
//
//     final physicalInfraApiModel = physicalInfraApiModelFromJson(jsonString);

import 'dart:convert';

PhysicalInfraApiModel physicalInfraApiModelFromJson(String str) => PhysicalInfraApiModel.fromJson(json.decode(str));

String physicalInfraApiModelToJson(PhysicalInfraApiModel data) => json.encode(data.toJson());

class PhysicalInfraApiModel {
    PhysicalInfraApiModel({
        this.surveyId,
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
    });

    String surveyId;
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

    factory PhysicalInfraApiModel.fromJson(Map<String, dynamic> json) => PhysicalInfraApiModel(
        surveyId: json["survey_id"],
        sourceOfDrinkingWaterPotableWater: json["source_of_drinking_water_potable_water"],
        isConnectionAvailableWithinPremises: json["is_connection_available_within_premises"],
        frequencyOfMunicipalSupply: json["frequency_of_municipal_supply"],
        durationOfSupply: json["duration_of_supply"],
        qualityOfWater: json["quality_of_water"],
        areYouSatisfiedWithTheDrinkingWaterSupply: json["are_you_satisfied_with_the_drinking_water_supply"],
        typeOfComplaints: json["type_of_complaints"],
        complaintsRedressedTime: json["complaints_redressed_time"],
        sourceOfElectricity: json["source_of_electricity"],
        electricityConnection: json["electricity_connection"],
        powerCutDuration: json["power_cut_duration"],
        availabilityOfStreetLights: json["availability_of_street_lights"],
        ifYesConditionOfStreetLight: json["if_yes_condition_of_street_light"],
        typeOfStreetLights: json["type_of_street_lights"],
        availabilityOfDrainageLine: json["availability_of_drainage_line"],
        householdWasteWaterOutlet: json["household_waste_water_outlet"],
        whereIsStormOrRainWaterCollected: json["where_is_storm_or_rain_water_collected"],
        whereIsHouseholdSolidWasteDisposedOff: json["where_is_household_solid_waste_disposed_off"],
        ifDoorToDoorCollection: json["if_door_to_door_collection"],
        isSolidWasteSegregationAtHouseholdLevel: json["is_solid_waste_segregation_at_household_level"],
        theBinsProvidedByMunicipality: json["the_bins_provided_by_municipality"],
    );

    Map<String, dynamic> toJson() => {
        "survey_id": surveyId,
        "source_of_drinking_water_potable_water": sourceOfDrinkingWaterPotableWater,
        "is_connection_available_within_premises": isConnectionAvailableWithinPremises,
        "frequency_of_municipal_supply": frequencyOfMunicipalSupply,
        "duration_of_supply": durationOfSupply,
        "quality_of_water": qualityOfWater,
        "are_you_satisfied_with_the_drinking_water_supply": areYouSatisfiedWithTheDrinkingWaterSupply,
        "type_of_complaints": typeOfComplaints,
        "complaints_redressed_time": complaintsRedressedTime,
        "source_of_electricity": sourceOfElectricity,
        "electricity_connection": electricityConnection,
        "power_cut_duration": powerCutDuration,
        "availability_of_street_lights": availabilityOfStreetLights,
        "if_yes_condition_of_street_light": ifYesConditionOfStreetLight,
        "type_of_street_lights": typeOfStreetLights,
        "availability_of_drainage_line": availabilityOfDrainageLine,
        "household_waste_water_outlet": householdWasteWaterOutlet,
        "where_is_storm_or_rain_water_collected": whereIsStormOrRainWaterCollected,
        "where_is_household_solid_waste_disposed_off": whereIsHouseholdSolidWasteDisposedOff,
        "if_door_to_door_collection": ifDoorToDoorCollection,
        "is_solid_waste_segregation_at_household_level": isSolidWasteSegregationAtHouseholdLevel,
        "the_bins_provided_by_municipality": theBinsProvidedByMunicipality,
    };
}
