// To parse this JSON data, do
//
//     final transportationApiModel = transportationApiModelFromJson(jsonString);

import 'dart:convert';

TransportationApiModel transportationApiModelFromJson(String str) => TransportationApiModel.fromJson(json.decode(str));

String transportationApiModelToJson(TransportationApiModel data) => json.encode(data.toJson());

class TransportationApiModel {
    TransportationApiModel({
        this.surveyId,
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
    });

    String surveyId;
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

    factory TransportationApiModel.fromJson(Map<String, dynamic> json) => TransportationApiModel(
        surveyId: json["survey_id"],
        areTransportationAndConveyanceFacilitiesSatisfactory: json["are_transportation_and_conveyance_facilities_satisfactory"],
        beforeCovid19TheMostPreferredModeOfTransport: json["before_Covid19_the_most_preferred_mode_of_transport"],
        afterCovid19TheMostPreferredModeOfTransport: json["after_covid19_the_most_preferred_mode_of_transport"],
        selfOwnedVehicles: json["self_owned_vehicles"],
        modeOfTransportationPreferForSchoolOrCollege: json["mode_of_transportation_prefer_for_school_or_college"],
        distanceForSchoolCollege: json["distance_for_school_college"],
        modeOfTransportationPreferForMarketOrShoppingCentre: json["mode_of_transportation_prefer_for_market_or_shopping_centre"],
        distanceForMarketOrShoppingCentre: json["distance_for_market_or_shopping_centre"],
        modeOfTransportationPreferForHospitalOrHealthCentre: json["mode_of_transportation_prefer_for_hospital_or_health_centre"],
        distanceForHospitalOrHealthCentre: json["distance_for_hospital_or_health_centre"],
        modeOfTransportationPreferForParksCinemaMall: json["mode_of_transportation_prefer_for_parks_cinema_mall"],
        distanceForParksCinemaMall: json["distance_for_parks_cinema_mall"],
        modeOfTransportationForRailwayStationOrBusTerminal: json["mode_of_transportation_for_railway_station_or_bus_terminal"],
        distanceForRailwayStationOrBusTerminal: json["distance_for_railway_station_or_bus_terminal"],
        modeOfTransportationPreferForAirport: json["mode_of_transportation_prefer_for_airport"],
        distanceForAirport: json["distance_for_airport"],
        modeOfTransportationPreferForBankOrPostoffice: json["mode_of_transportation_prefer_for_bank_or_postoffice"],
        distanceForBankOrPostoffice: json["distance_for_bank_or_postoffice"],
        howOftenDoYouTravelOutstation: json["how_often_do_you_travel_outstation"],
        locationOfOutstation: json["location_of_outstation"],
        preferredModeOfTransportationForOutstation: json["preferred_mode_of_transportation_for_outstation"],
        areThereAnySignagesProvided: json["are_there_any_signages_provided"],
        isThereAnyFootpathProvided: json["is_there_any_footpath_provided"],
        isZebraCrossingProvidedNearJunctions: json["is_zebra_crossing_provided_near_junctions"],
        availabilityOfCycleTrackAndPedestrianPathway: json["availability_of_cycle_track_and_pedestrian_pathway"],
        ifYesIsThePathShadedWithTrees: json["if_yes_is_the_path_shaded_with_trees"],
        anyFurtherSuggestionForImprovement: json["any_further_suggestion_for_improvement"],
    );

    Map<String, dynamic> toJson() => {
        "survey_id": surveyId,
        "are_transportation_and_conveyance_facilities_satisfactory": areTransportationAndConveyanceFacilitiesSatisfactory,
        "before_Covid19_the_most_preferred_mode_of_transport": beforeCovid19TheMostPreferredModeOfTransport,
        "after_covid19_the_most_preferred_mode_of_transport": afterCovid19TheMostPreferredModeOfTransport,
        "self_owned_vehicles": selfOwnedVehicles,
        "mode_of_transportation_prefer_for_school_or_college": modeOfTransportationPreferForSchoolOrCollege,
        "distance_for_school_college": distanceForSchoolCollege,
        "mode_of_transportation_prefer_for_market_or_shopping_centre": modeOfTransportationPreferForMarketOrShoppingCentre,
        "distance_for_market_or_shopping_centre": distanceForMarketOrShoppingCentre,
        "mode_of_transportation_prefer_for_hospital_or_health_centre": modeOfTransportationPreferForHospitalOrHealthCentre,
        "distance_for_hospital_or_health_centre": distanceForHospitalOrHealthCentre,
        "mode_of_transportation_prefer_for_parks_cinema_mall": modeOfTransportationPreferForParksCinemaMall,
        "distance_for_parks_cinema_mall": distanceForParksCinemaMall,
        "mode_of_transportation_for_railway_station_or_bus_terminal": modeOfTransportationForRailwayStationOrBusTerminal,
        "distance_for_railway_station_or_bus_terminal": distanceForRailwayStationOrBusTerminal,
        "mode_of_transportation_prefer_for_airport": modeOfTransportationPreferForAirport,
        "distance_for_airport": distanceForAirport,
        "mode_of_transportation_prefer_for_bank_or_postoffice": modeOfTransportationPreferForBankOrPostoffice,
        "distance_for_bank_or_postoffice": distanceForBankOrPostoffice,
        "how_often_do_you_travel_outstation": howOftenDoYouTravelOutstation,
        "location_of_outstation": locationOfOutstation,
        "preferred_mode_of_transportation_for_outstation": preferredModeOfTransportationForOutstation,
        "are_there_any_signages_provided": areThereAnySignagesProvided,
        "is_there_any_footpath_provided": isThereAnyFootpathProvided,
        "is_zebra_crossing_provided_near_junctions": isZebraCrossingProvidedNearJunctions,
        "availability_of_cycle_track_and_pedestrian_pathway": availabilityOfCycleTrackAndPedestrianPathway,
        "if_yes_is_the_path_shaded_with_trees": ifYesIsThePathShadedWithTrees,
        "any_further_suggestion_for_improvement": anyFurtherSuggestionForImprovement,
    };
}
