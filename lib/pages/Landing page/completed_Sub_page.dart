// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:socio_survey/main.dart';

// import '../../components/survey_id_model.dart';

// class SubPage extends StatefulWidget {
//   final String index;
//   SubPage({Key key, this.index}) : super(key: key);

//   @override
//   _SubPageState createState() => _SubPageState();
// }

// class _SubPageState extends State<SubPage> {
//   Future<SurveyIdModel> futureData;
//   @override
//   void initState() {
//     futureData = getId(widget.index);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Color(0xfff89d4cf),
//           title: Text(
//             "${widget.index} Data",
//             style: GoogleFonts.quicksand(
//                 fontSize: 22, fontWeight: FontWeight.bold),
//           )),
//       body: SingleChildScrollView(
//         child: Column(
//           // crossAxisAlignment: CrossAxisAlignment.center,

//           children: [
//             Row(
//               //mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Expanded(
//                 //     flex: 1,
//                 //     child: Text(
//                 //       "Id",
//                 //       style: GoogleFonts.quicksand(
//                 //         fontSize: 20,
//                 //       ),
//                 //     )),
//                 Expanded(
//                     flex: 3,
//                     child: Text(
//                       "Question",
//                       style: GoogleFonts.quicksand(
//                         fontSize: 20,
//                       ),
//                     )),
//                 Expanded(
//                     flex: 2,
//                     child: Text(
//                       "Value",
//                       style: GoogleFonts.quicksand(
//                         fontSize: 20,
//                       ),
//                     )),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Divider(
//               thickness: 0.5,
//               color: Colors.grey.shade400,
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                     flex: 2,
//                     child: ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: dataLocal.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               dataLocal[index],
//                               style: TextStyle(fontSize: 18),
//                             ),
//                           );
//                         })),
//                 Expanded(
//                     flex: 3,
//                     child: FutureBuilder<SurveyIdModel>(
//                         future: futureData,
//                         // ignore: missing_return
//                         builder: (context, snapshot) {
//                           if (snapshot.hasData) {
//                             return ListView.builder(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: snapshot.data.data.length,
//                                 itemBuilder: (BuildContext context, index) {
//                                   final userData = snapshot.data.data;
//                                   return Text(
//                                       userData[index].values.toString());
//                                 });
//                           } else if (snapshot.hasError) {
//                             return Text('${snapshot.error}');
//                           }
//                           return Center(
//                               child: const CircularProgressIndicator());
//                         })),
//               ],
//             ),
//             SizedBox(
//               height: 15,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<SurveyIdModel> getId(id) async {
//     final response = await http.get(Uri.parse(
//         "http://13.232.140.106:5000/rsi-field-force-api/survey/get-individual-survey-details?survey_id=$id"));
//     if (response.statusCode == 200) {
//       print("Response===${response.body}");
//       return SurveyIdModel.fromJson(jsonDecode(response.body));
//       // var items = jsonDecode(response.body);
//       // users = items;
//     } else {
//       throw Exception('Failed to load Data');
//     }
//   }
// }

// var dataLocal = [
//   "devices_id",
//   "survey_id",
//   "date",
//   "city",
//   "phone_no",
//   "name_of_locality",
//   "ward",
//   "total_no_of_members",
//   "full_name_of_family_head",
//   "total_no_of_males",
//   "total_no_of_females",
//   "total_no_of_illiterate_members",
//   "caste",
//   "religion",
//   "minority_status",
//   "migrated",
//   "if_yes_no_of_years",
//   "place_of_origin",
//   "migration_type",
//   "reason_of_migration",
//   "are_you_willing_to_migrate_to_another_place",
//   "if_no_reasons_for_not_going_back_to_the_native_place",
//   "after_covid19_situation_you_go_back_to_your_native_place",
//   "type_of_house",
//   "number_of_floors",
//   "wall",
//   "roof",
//   "age_of_house",
//   "house_condition",
//   "ownership_type",
//   "if_rented_amount",
//   "land_ownership",
//   "approx_price_range_of_land_per_katha",
//   "do_you_have_any_other_land_property",
//   "if_yes_where",
//   "if_no_are_you_willing_to_buy",
//   "usage_of_residential_building",
//   "asset_owned_by_household",
//   "cooking_fuel_used_in_the_kitchen",
//   "type_of_employment_engagement",
//   "occupation",
//   "if_construction_worker",
//   "if_industrial_worker_in_which_industry_do_you_work",
//   "if_there_is_another_family_member_who_is_employed",
//   "type_of_employment_engagement_another_family_member",
//   "occupation_another_family_member",
//   "if_construction_worker_another_family_member",
//   "if_industrial_worker_another_family_member",
//   "is_any_of_the_family_members_working_as_part_time_employees",
//   "if_yes_which_type_of_industry_company_Office",
//   "after_covid19_impact_on_job_opportunity_Availability",
//   "does_the_industrial_sector_been_affected_after_covid19",
//   "suggestions_for_how_job_opportunities_can_be_made_available",
//   "does_any_family_member_receive_a_pension",
//   "if_yes_specify_which",
//   "what_is_your_monthly_expenditure",
//   "impact_on_monthly_expenditure_after_covid19",
//   "how_often_you_visit_the_market_before_covid19",
//   "how_often_you_visit_the_market_after_covid19",
//   "most_preferred_way_of_shopping_after_covid19",
//   "most_preferred_way_of_shopping_before_covid19",
//   "how_often_do_you_do_online_shopping",
//   "are_transportation_and_conveyance_facilities_satisfactory",
//   "before_Covid19_the_most_preferred_mode_of_transport",
//   "after_covid19_the_most_preferred_mode_of_transport",
//   "self_owned_vehicles",
//   "mode_of_transportation_prefer_for_school_or_college",
//   "distance_for_school_college",
//   "mode_of_transportation_prefer_for_market_or_shopping_centre",
//   "distance_for_market_or_shopping_centre",
//   "mode_of_transportation_prefer_for_hospital_or_health_centre",
//   "distance_for_hospital_or_health_centre",
//   "mode_of_transportation_prefer_for_parks_cinema_mall",
//   "distance_for_parks_cinema_mall",
//   "mode_of_transportation_for_railway_station_or_bus_terminal",
//   "distance_for_railway_station_or_bus_terminal",
//   "mode_of_transportation_prefer_for_airport",
//   "distance_for_airport",
//   "mode_of_transportation_prefer_for_bank_or_postoffice",
//   "distance_for_bank_or_postoffice",
//   "how_often_do_you_travel_outstation",
//   "location_of_outstation",
//   "preferred_mode_of_transportation_for_outstation",
//   "are_there_any_signages_provided",
//   "is_there_any_footpath_provided",
//   "is_zebra_crossing_provided_near_junctions",
//   "availability_of_cycle_track_and_pedestrian_pathway",
//   "if_yes_is_the_path_shaded_with_trees",
//   "any_further_suggestion_for_improvement",
//   "source_of_drinking_water_potable_water",
//   "is_connection_available_within_premises",
//   "frequency_of_municipal_supply",
//   "duration_of_supply",
//   "quality_of_water",
//   "are_you_satisfied_with_the_drinking_water_supply",
//   "type_of_complaints",
//   "complaints_redressed_time",
//   "source_of_electricity",
//   "electricity_connection",
//   "power_cut_duration",
//   "availability_of_street_lights",
//   "if_yes_condition_of_street_light",
//   "type_of_street_lights",
//   "availability_of_drainage_line",
//   "household_waste_water_outlet",
//   "where_is_storm_or_rain_water_collected",
//   "where_is_household_solid_waste_disposed_off",
//   "if_door_to_door_collection",
//   "is_solid_waste_segregation_at_household_level",
//   "the_bins_provided_by_municipality",
//   "which_type_of_schoolor_education_infrastructure_do_you_prefer",
//   "type_of_education_availability_and_their_distance",
//   "most_preferred_mode",
//   "do_you_think_your_region_has_good_opportunities_in_education",
//   "any_further_suggestions_or_issues_for_improvement_in_education",
//   "most_preferred_health_facility",
//   "distance",
//   "do_you_think_your_region_has_good_in_health_facilities",
//   "any_suggestions_for_improvement_in_health_facilities",
//   "availability_of_parks_playground_or_other_recreation_spaces",
//   "do_you_or_your_family_members_go_to_a_park_or_playground",
//   "if_yes_how_regular_you_go_to_park_or_playground",
//   "any_further_suggestion_or_issues_for_improvement_in_parks",
//   "do_you_receive_any_grant_from_any_state_govt_flagship_scheme",
//   "if_availing_any_other_schemes_please_specify",
//   "does_this_place_is_allotted_to_you_by_any_authority",
//   "status_of_land",
//   "if_government_land_is_there_any_patta",
//   "how_long_have_you_stayed_here",
//   "types_of_work_in_which_you_are_engaged",
//   "are_you_skilled_labour",
//   "if_yes_skill_type_carpenter_electrician_etc",
//   "due_to_the_covid19_has_the_income_and_job_been_affected",
//   "do_you_get_any_ration_assistance_from_the_government",
//   "type_of_ration_card_you_available",
//   "do_you_get_any_financial_assistance_from_the_government",
//   "get_any_benefits_from_any_state_or_central_housing_schemes",
//   "allotted_house_under_slum_rehabilitation_project_of_government",
//   "if_government_provides_a_house_would_you_move_to_that_place",
//   "do_you_get_any_benefit_of_swasthya_sathi_for_health_assistance",
//   "willing_to_go_back_to_native_if_suitable_jobs_are_made_available",
//   "what_do_you_say_about_life_in_slum_areas",
//   "what_kind_of_problems_do_you_face",
//   "do_you_face_any_problems_from_industries_around_you",
//   "whether_all_children_enrolled_in_the_school",
//   "if_yes_which_type_of_school",
//   "if_not_going_to_school_drop_out_age",
//   "reason_of_drop_out",
//   "if_more_than_one_student",
//   "alternative_economic_activities_for_livelihood",
//   "any_further_suggestion_or_issues_for_improvement_regarding_slums",
//   "do_you_have_boats",
//   "if_yes_the_purpose_of_using_boats",
//   "are_you_associated_with_fishing_related_activities",
//   "if_yes_then_specify_as_seller_catcher_supplier_or_other",
//   "have_you_been_engaged_in_other_activities_apart_from_fishing",
//   "if_yes_specify_the_activities",
//   "do_you_think_living_in_coastal_region_is_threat_or_opportunity",
//   "how_do_you_get_the_information_related_to_natural_threats",
//   "safe_place_during_natural_events",
//   "after_natural_disaster_how_many_days_take_come_to_normal",
//   "major_damages_during_natural_calamities",
//   "availability_of_ration_during_the_natural_disaster",
//   "whether_any_fund_area_granted_for_the_flood_prone_area",
//   "does_this_region_have_any_tourism_opportunities",
//   "any_further_suggestions_or_issues_in_coastal_region",
//   "family_or_nearby_person_suffered_from_diseases_in_last_few_years",
//   "if_yes_which_diseases_specify",
//   "do_you_or_family_member_face_any_problem_in_breathing",
//   "major_cause_of_pollution",
//   "do_you_face_any_issues_during_the_rainy_season",
//   "if_yes_specify_issues_faced_in_rainy_season",
//   "whether_the_area_is_prone_to_flooding_due_to_rains",
//   "if_yes_how_many_days_it_takes_to_normal_condition",
//   "during_flooding_is_rehabilitation_centres_available",
//   "whether_any_funds_granted_to_you_for_such_disaster",
//   "do_hoardings_create_any_visual_disturbance_while_driving",
//   "does_traffic_movement_and_noise_an_issue_for_your_locality",
//   "if_yes_suggestion_for_improvement_in_traffic_issue",
//   "whether_the_waste_disposed_off_in_a_nearby_river_or_water_body",
//   "any_further_suggestion_for_improvement_in_environment",
//   "popular_festival_occasion",
//   "this_place_have_any_significant_heritage_site_structure",
//   "visitors_during_the_festivals_or_occasion",
//   "problem_faced_during_the_festivals_and_occasion",
//   "festive_occasion_presence_help_you_in_the_economic_generation",
//   "if_yes_specify_how_festivals_helps",
//   "do_tourists_visit_this_place_regularly_or_during_festivals",
//   "any_further_suggestion_in_cultural_heritage",
//   "do_tourists_come_to_this_region_regularly",
//   "best_season_for_tourist_to_visit_and_why",
//   "are_you_involved_in_tourists_related_activities",
//   "which_type_of_activities_youre_involved_in",
//   "any_other_work_engagement_apart_from_tourist_activity",
//   "no_of_person_or_family_member_engage_in_such_activity",
//   "if_handicraft_what_items_do_you_sell",
//   "whom_do_you_sell_your_products_to_most_often",
//   "participate_in_any_fair_or_mela_for_product_showcase_and_sell",
//   "if_yes_where_and_how_often_do_you_visit",
//   "availability_of_training_centre_and_exhibition_centre",
//   "sell_of_products",
//   "tourism_sector_helps_in_economic_growth_of_this_region",
//   "any_further_suggestion_for_improvement_in_tourism"
// ];
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../components/survey_id_model.dart';

class SubPage extends StatefulWidget {
  final String index;
  SubPage({Key key, this.index}) : super(key: key);

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  Future<SurveyIdModel> futureData;
  @override
  void initState() {
    futureData = getId(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xfff89d4cf),
          title: Text(
            "${widget.index} Data",
            style: GoogleFonts.quicksand(
                fontSize: 22, fontWeight: FontWeight.bold),
          )),
      body: FutureBuilder<SurveyIdModel>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.data.length,
                itemBuilder: (BuildContext context, index) {
                  final userData = snapshot.data.data;
                  var values = userData[index];

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        index == 0
                            ? HeadingValue(
                                quiz: "Question",
                                value: "Value",
                              )
                            : SizedBox(),
                        index == 0
                            ? SizedBox(
                                height: 20,
                              )
                            : SizedBox(),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                        Center(
                          child: Text(
                            "User Details",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[2],
                          value: values["date"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[3],
                          value: values["city"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[4],
                          value: values["phone_no"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[5],
                          value: values["name_of_locality"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[6],
                          value: values["ward"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[7],
                          value: values["total_no_of_members"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[8],
                          value: values["full_name_of_family_head"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[9],
                          value: values["total_no_of_males"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[10],
                          value: values["total_no_of_females"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[11],
                          value: values["total_no_of_illiterate_members"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[12],
                          value: values["caste"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[13],
                          value: values["religion"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[14],
                          value: values["minority_status"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            "HouseHold Profile",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[15],
                          value: values["migrated"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[16],
                          value: values["if_yes_no_of_years"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[17],
                          value: values["place_of_origin"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[18],
                          value: values["migration_type"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[19],
                          value: values["reason_of_migration"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[20],
                          value: values[
                              "are_you_willing_to_migrate_to_another_place"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[21],
                          value: values[
                              "if_no_reasons_for_not_going_back_to_the_native_place"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[22],
                          value: values[
                              "after_covid19_situation_you_go_back_to_your_native_place"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            "Housing",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[23],
                          value: values["type_of_house"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[24],
                          value: values["number_of_floors"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[25],
                          value: values["wall"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[26],
                          value: values["roof"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[27],
                          value: values["age_of_house"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[28],
                          value: values["house_condition"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[29],
                          value: values["ownership_type"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[30],
                          value: values["if_rented_amount"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[31],
                          value: values["land_ownership"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[32],
                          value: values["approx_price_range_of_land_per_katha"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[33],
                          value: values["do_you_have_any_other_land_property"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[34],
                          value: values["if_yes_where"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[35],
                          value: values["if_no_are_you_willing_to_buy"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[36],
                          value: values["usage_of_residential_building"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[37],
                          value: values["asset_owned_by_household"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[38],
                          value: values["cooking_fuel_used_in_the_kitchen"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            "Economy Related",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[39],
                          value: values["type_of_employment_engagement"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[40],
                          value: values["occupation"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[41],
                          value: values["if_construction_worker"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[42],
                          value: values[
                              "if_industrial_worker_in_which_industry_do_you_work"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[43],
                          value: values[
                              "if_there_is_another_family_member_who_is_employed"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[44],
                          value: values[
                              "type_of_employment_engagement_another_family_member"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[45],
                          value: values["occupation_another_family_member"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[46],
                          value: values[
                              "if_construction_worker_another_family_member"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[47],
                          value: values[
                              "if_industrial_worker_another_family_member"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[48],
                          value: values[
                              "is_any_of_the_family_members_working_as_part_time_employees"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[49],
                          value: values[
                              "if_yes_which_type_of_industry_company_Office"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[50],
                          value: values[
                              "after_covid19_impact_on_job_opportunity_Availability"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[51],
                          value: values[
                              "does_the_industrial_sector_been_affected_after_covid19"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[52],
                          value: values[
                              "suggestions_for_how_job_opportunities_can_be_made_available"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[53],
                          value: values[
                              "does_any_family_member_receive_a_pension"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[54],
                          value: values["if_yes_specify_which"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[55],
                          value: values["what_is_your_monthly_expenditure"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[56],
                          value: values[
                              "impact_on_monthly_expenditure_after_covid19"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[57],
                          value: values[
                              "how_often_you_visit_the_market_before_covid19"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[58],
                          value: values[
                              "how_often_you_visit_the_market_after_covid19"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[59],
                          value: values[
                              "most_preferred_way_of_shopping_after_covid19"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[60],
                          value: values[
                              "most_preferred_way_of_shopping_before_covid19"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[61],
                          value: values["how_often_do_you_do_online_shopping"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            "TransPortation",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        ///
                        ListData(
                          quiz: dataLocal[62],
                          value: values[
                              "are_transportation_and_conveyance_facilities_satisfactory"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[63],
                          value: values[
                              "before_Covid19_the_most_preferred_mode_of_transport"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[64],
                          value: values[
                              "after_covid19_the_most_preferred_mode_of_transport"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[65],
                          value: values["self_owned_vehicles"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[66],
                          value: values[
                              "mode_of_transportation_prefer_for_school_or_college"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[67],
                          value: values["distance_for_school_college"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[68],
                          value: values[
                              "mode_of_transportation_prefer_for_market_or_shopping_centre"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[69],
                          value:
                              values["distance_for_market_or_shopping_centre"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[70],
                          value: values[
                              "mode_of_transportation_prefer_for_hospital_or_health_centre"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[71],
                          value:
                              values["distance_for_hospital_or_health_centre"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[72],
                          value: values[
                              "mode_of_transportation_prefer_for_parks_cinema_mall"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[73],
                          value: values["distance_for_parks_cinema_mall"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[74],
                          value: values[
                              "mode_of_transportation_for_railway_station_or_bus_terminal"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[75],
                          value: values[
                              "distance_for_railway_station_or_bus_terminal"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[76],
                          value: values[
                              "mode_of_transportation_prefer_for_airport"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[77],
                          value: values["distance_for_airport"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[78],
                          value: values[
                              "mode_of_transportation_prefer_for_bank_or_postoffice"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[79],
                          value: values["distance_for_bank_or_postoffice"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[80],
                          value: values["how_often_do_you_travel_outstation"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[81],
                          value: values["location_of_outstation"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[82],
                          value: values[
                              "preferred_mode_of_transportation_for_outstation"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[83],
                          value: values["are_there_any_signages_provided"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[84],
                          value: values["is_there_any_footpath_provided"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[85],
                          value: values[
                              "is_zebra_crossing_provided_near_junctions"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[86],
                          value: values[
                              "availability_of_cycle_track_and_pedestrian_pathway"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[87],
                          value: values["if_yes_is_the_path_shaded_with_trees"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[88],
                          value:
                              values["any_further_suggestion_for_improvement"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            "Physical Infrastructure",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[89],
                          value:
                              values["source_of_drinking_water_potable_water"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[90],
                          value:
                              values["is_connection_available_within_premises"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[91],
                          value: values["frequency_of_municipal_supply"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[92],
                          value: values["frequency_of_municipal_supply"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[93],
                          value: values["quality_of_water"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[94],
                          value: values[
                              "are_you_satisfied_with_the_drinking_water_supply"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[95],
                          value: values["type_of_complaints"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[96],
                          value: values["complaints_redressed_time"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[97],
                          value: values["source_of_electricity"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[98],
                          value: values["electricity_connection"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[99],
                          value: values["power_cut_duration"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[100],
                          value: values["availability_of_street_lights"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[101],
                          value: values["if_yes_condition_of_street_light"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[102],
                          value: values["type_of_street_lights"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[103],
                          value: values["availability_of_drainage_line"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[104],
                          value: values["household_waste_water_outlet"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[105],
                          value:
                              values["where_is_storm_or_rain_water_collected"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[106],
                          value: values[
                              "where_is_household_solid_waste_disposed_off"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[107],
                          value: values["if_door_to_door_collection"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[108],
                          value: values[
                              "is_solid_waste_segregation_at_household_level"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[109],
                          value: values["the_bins_provided_by_municipality"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ///////////////
                        Center(
                          child: Text(
                            "Social Infrastructure",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[110],
                          value: values[
                              "which_type_of_schoolor_education_infrastructure_do_you_prefer"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[111],
                          value: values[
                              "type_of_education_availability_and_their_distance"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[112],
                          value: values["most_preferred_mode"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[113],
                          value: values[
                              "do_you_think_your_region_has_good_opportunities_in_education"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[114],
                          value: values[
                              "any_further_suggestions_or_issues_for_improvement_in_education"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[115],
                          value: values["most_preferred_health_facility"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[116],
                          value: values["distance"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[117],
                          value: values[
                              "do_you_think_your_region_has_good_in_health_facilities"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[118],
                          value: values[
                              "any_suggestions_for_improvement_in_health_facilities"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[119],
                          value: values[
                              "availability_of_parks_playground_or_other_recreation_spaces"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[120],
                          value: values[
                              "do_you_or_your_family_members_go_to_a_park_or_playground"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[121],
                          value: values[
                              "if_yes_how_regular_you_go_to_park_or_playground"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[122],
                          value: values[
                              "any_further_suggestion_or_issues_for_improvement_in_parks"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[123],
                          value: values[
                              "do_you_receive_any_grant_from_any_state_govt_flagship_scheme"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[124],
                          value: values[
                              "if_availing_any_other_schemes_please_specify"],
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        ///
                        Center(
                          child: Text(
                            "Slums",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListData(
                          quiz: dataLocal[125],
                          value: values[
                              "does_this_place_is_allotted_to_you_by_any_authority"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[126],
                          value: values["status_of_land"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[127],
                          value:
                              values["if_government_land_is_there_any_patta"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[128],
                          value: values["how_long_have_you_stayed_here"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[129],
                          value:
                              values["types_of_work_in_which_you_are_engaged"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[130],
                          value: values["are_you_skilled_labour"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[131],
                          value: values[
                              "if_yes_skill_type_carpenter_electrician_etc"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[132],
                          value: values[
                              "due_to_the_covid19_has_the_income_and_job_been_affected"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[133],
                          value: values[
                              "do_you_get_any_ration_assistance_from_the_government"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[134],
                          value: values["type_of_ration_card_you_available"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[135],
                          value: values[
                              "do_you_get_any_financial_assistance_from_the_government"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[136],
                          value: values[
                              "get_any_benefits_from_any_state_or_central_housing_schemes"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[137],
                          value: values[
                              "allotted_house_under_slum_rehabilitation_project_of_government"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[138],
                          value: values[
                              "if_government_provides_a_house_would_you_move_to_that_place"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[139],
                          value: values[
                              "do_you_get_any_benefit_of_swasthya_sathi_for_health_assistance"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[140],
                          value: values[
                              "willing_to_go_back_to_native_if_suitable_jobs_are_made_available"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[141],
                          value: values[
                              "what_do_you_say_about_life_in_slum_areas"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[142],
                          value: values["what_kind_of_problems_do_you_face"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[143],
                          value: values[
                              "do_you_face_any_problems_from_industries_around_you"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[144],
                          value: values[
                              "whether_all_children_enrolled_in_the_school"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[145],
                          value: values["if_yes_which_type_of_school"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[146],
                          value: values["if_not_going_to_school_drop_out_age"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[147],
                          value: values["reason_of_drop_out"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[148],
                          value: values["if_more_than_one_student"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[149],
                          value: values[
                                  "alternative_economic_activities_for_livelihood"] ??
                              null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[150],
                          value: values[
                              "any_further_suggestion_or_issues_for_improvement_regarding_slums"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            "Coastal",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[151],
                          value: values["do_you_have_boats"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[152],
                          value: values["if_yes_the_purpose_of_using_boats"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[153],
                          value: values[
                              "are_you_associated_with_fishing_related_activities"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[154],
                          value: values[
                              "if_yes_then_specify_as_seller_catcher_supplier_or_other"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[155],
                          value: values[
                              "have_you_been_engaged_in_other_activities_apart_from_fishing"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[156],
                          value: values["if_yes_specify_the_activities"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[157],
                          value: values[
                              "do_you_think_living_in_coastal_region_is_threat_or_opportunity"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[158],
                          value: values[
                              "how_do_you_get_the_information_related_to_natural_threats"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[159],
                          value: values["safe_place_during_natural_events"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[160],
                          value: values[
                              "after_natural_disaster_how_many_days_take_come_to_normal"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[161],
                          value:
                              values["major_damages_during_natural_calamities"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[162],
                          value: values[
                              "availability_of_ration_during_the_natural_disaster"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[163],
                          value: values[
                              "whether_any_fund_area_granted_for_the_flood_prone_area"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[164],
                          value: values[
                              "does_this_region_have_any_tourism_opportunities"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[165],
                          value: values[
                              "any_further_suggestions_or_issues_in_coastal_region"],
                        ),

                        ///
                        Center(
                          child: Text(
                            "Environmetal Related",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[166],
                          value: values[
                              "family_or_nearby_person_suffered_from_diseases_in_last_few_years"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[167],
                          value: values["if_yes_which_diseases_specify"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[168],
                          value: values[
                              "do_you_or_family_member_face_any_problem_in_breathing"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[169],
                          value: values["major_cause_of_pollution"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[170],
                          value: values[
                              "do_you_face_any_issues_during_the_rainy_season"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[171],
                          value: values[
                              "if_yes_specify_issues_faced_in_rainy_season"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[172],
                          value: values[
                              "whether_the_area_is_prone_to_flooding_due_to_rains"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[173],
                          value: values[
                              "if_yes_how_many_days_it_takes_to_normal_condition"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[174],
                          value: values[
                              "during_flooding_is_rehabilitation_centres_available"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[175],
                          value: values[
                              "whether_any_funds_granted_to_you_for_such_disaster"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[176],
                          value: values[
                              "do_hoardings_create_any_visual_disturbance_while_driving"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[177],
                          value: values[
                              "does_traffic_movement_and_noise_an_issue_for_your_locality"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[178],
                          value: values[
                              "if_yes_suggestion_for_improvement_in_traffic_issue"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[179],
                          value: values[
                              "whether_the_waste_disposed_off_in_a_nearby_river_or_water_body"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[180],
                          value: values[
                              "any_further_suggestion_for_improvement_in_environment"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            "Cultural & Heritage",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[181],
                          value: values["popular_festival_occasion"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[182],
                          value: values[
                              "this_place_have_any_significant_heritage_site_structure"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[183],
                          value: values[
                              "visitors_during_the_festivals_or_occasion"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[184],
                          value: values[
                              "problem_faced_during_the_festivals_and_occasion"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[185],
                          value: values[
                              "festive_occasion_presence_help_you_in_the_economic_generation"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[186],
                          value: values["if_yes_specify_how_festivals_helps"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[187],
                          value: values[
                              "do_tourists_visit_this_place_regularly_or_during_festivals"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[188],
                          value: values[
                              "any_further_suggestion_in_cultural_heritage"],
                        ),
                        Center(
                          child: Text(
                            "Tourism",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[189],
                          value: values[
                              "do_tourists_come_to_this_region_regularly"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[190],
                          value: values[
                              "best_season_for_tourist_to_visit_and_why"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[191],
                          value: values[
                              "are_you_involved_in_tourists_related_activities"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[192],
                          value: values[
                              "which_type_of_activities_youre_involved_in"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[193],
                          value: values[
                              "any_other_work_engagement_apart_from_tourist_activity"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[194],
                          value: values[
                              "no_of_person_or_family_member_engage_in_such_activity"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[195],
                          value: values["if_handicraft_what_items_do_you_sell"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[196],
                          value: values[
                              "whom_do_you_sell_your_products_to_most_often"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[197],
                          value: values[
                              "participate_in_any_fair_or_mela_for_product_showcase_and_sell"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[198],
                          value:
                              values["if_yes_where_and_how_often_do_you_visit"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[199],
                          value: values[
                              "availability_of_training_centre_and_exhibition_centre"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[200],
                          value: values["sell_of_products"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[201],
                          value: values[
                              "tourism_sector_helps_in_economic_growth_of_this_region"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListData(
                          quiz: dataLocal[202],
                          value: values[
                              "any_further_suggestion_for_improvement_in_tourism"],
                        ),
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }

  Future<SurveyIdModel> getId(id) async {
    final response = await http.get(Uri.parse(
        "http://13.232.140.106:5000/rsi-field-force-api/survey/get-individual-survey-details?survey_id=$id"));
    if (response.statusCode == 200) {
      print("Response===${response.body}");
      return SurveyIdModel.fromJson(jsonDecode(response.body));
      // var items = jsonDecode(response.body);
      // users = items;
    } else {
      throw Exception('Failed to load Data');
    }
  }
}

class ListData extends StatelessWidget {
  final String quiz;
  final String value;
  const ListData({
    Key key,
    this.quiz,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: Text(
              quiz,
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            )),
        SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 2,
            child: Text(
              value,
              style: GoogleFonts.quicksand(fontSize: 15),
            )),
      ],
    );
  }
}

class HeadingValue extends StatelessWidget {
  final String quiz;
  final String value;

  const HeadingValue({
    Key key,
    this.quiz,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 3,
            child: Text(
              quiz,
              style: GoogleFonts.quicksand(
                fontSize: 22,
              ),
            )),
        Expanded(
            flex: 2,
            child: Text(
              value,
              style: GoogleFonts.quicksand(
                fontSize: 22,
              ),
            )),
      ],
    );
  }
}

var dataLocal = [
  "devices_id",
  "survey_id",
  "date",
  "city",
  "phone_no",
  "name_of_locality",
  "ward",
  "total_no_of_members",
  "full_name_of_family_head",
  "total_no_of_males",
  "total_no_of_females",
  "total_no_of_illiterate_members",
  "caste",
  "religion",
  "minority_status",
  "migrated",
  "if_yes_no_of_years",
  "place_of_origin",
  "migration_type",
  "reason_of_migration",
  "are_you_willing_to_migrate_to_another_place",
  "if_no_reasons_for_not_going_back_to_the_native_place",
  "after_covid19_situation_you_go_back_to_your_native_place",
  "type_of_house",
  "number_of_floors",
  "wall",
  "roof",
  "age_of_house",
  "house_condition",
  "ownership_type",
  "if_rented_amount",
  "land_ownership",
  "approx_price_range_of_land_per_katha",
  "do_you_have_any_other_land_property",
  "if_yes_where",
  "if_no_are_you_willing_to_buy",
  "usage_of_residential_building",
  "asset_owned_by_household",
  "cooking_fuel_used_in_the_kitchen",
  "type_of_employment_engagement",
  "occupation",
  "if_construction_worker",
  "if_industrial_worker_in_which_industry_do_you_work",
  "if_there_is_another_family_member_who_is_employed",
  "type_of_employment_engagement_another_family_member",
  "occupation_another_family_member",
  "if_construction_worker_another_family_member",
  "if_industrial_worker_another_family_member",
  "is_any_of_the_family_members_working_as_part_time_employees",
  "if_yes_which_type_of_industry_company_Office",
  "after_covid19_impact_on_job_opportunity_Availability",
  "does_the_industrial_sector_been_affected_after_covid19",
  "suggestions_for_how_job_opportunities_can_be_made_available",
  "does_any_family_member_receive_a_pension",
  "if_yes_specify_which",
  "what_is_your_monthly_expenditure",
  "impact_on_monthly_expenditure_after_covid19",
  "how_often_you_visit_the_market_before_covid19",
  "how_often_you_visit_the_market_after_covid19",
  "most_preferred_way_of_shopping_after_covid19",
  "most_preferred_way_of_shopping_before_covid19",
  "how_often_do_you_do_online_shopping",
  "are_transportation_and_conveyance_facilities_satisfactory",
  "before_Covid19_the_most_preferred_mode_of_transport",
  "after_covid19_the_most_preferred_mode_of_transport",
  "self_owned_vehicles",
  "mode_of_transportation_prefer_for_school_or_college",
  "distance_for_school_college",
  "mode_of_transportation_prefer_for_market_or_shopping_centre",
  "distance_for_market_or_shopping_centre",
  "mode_of_transportation_prefer_for_hospital_or_health_centre",
  "distance_for_hospital_or_health_centre",
  "mode_of_transportation_prefer_for_parks_cinema_mall",
  "distance_for_parks_cinema_mall",
  "mode_of_transportation_for_railway_station_or_bus_terminal",
  "distance_for_railway_station_or_bus_terminal",
  "mode_of_transportation_prefer_for_airport",
  "distance_for_airport",
  "mode_of_transportation_prefer_for_bank_or_postoffice",
  "distance_for_bank_or_postoffice",
  "how_often_do_you_travel_outstation",
  "location_of_outstation",
  "preferred_mode_of_transportation_for_outstation",
  "are_there_any_signages_provided",
  "is_there_any_footpath_provided",
  "is_zebra_crossing_provided_near_junctions",
  "availability_of_cycle_track_and_pedestrian_pathway",
  "if_yes_is_the_path_shaded_with_trees",
  "any_further_suggestion_for_improvement",
  "source_of_drinking_water_potable_water",
  "is_connection_available_within_premises",
  "frequency_of_municipal_supply",
  "duration_of_supply",
  "quality_of_water",
  "are_you_satisfied_with_the_drinking_water_supply",
  "type_of_complaints",
  "complaints_redressed_time",
  "source_of_electricity",
  "electricity_connection",
  "power_cut_duration",
  "availability_of_street_lights",
  "if_yes_condition_of_street_light",
  "type_of_street_lights",
  "availability_of_drainage_line",
  "household_waste_water_outlet",
  "where_is_storm_or_rain_water_collected",
  "where_is_household_solid_waste_disposed_off",
  "if_door_to_door_collection",
  "is_solid_waste_segregation_at_household_level",
  "the_bins_provided_by_municipality",
  "which_type_of_schoolor_education_infrastructure_do_you_prefer",
  "type_of_education_availability_and_their_distance",
  "most_preferred_mode",
  "do_you_think_your_region_has_good_opportunities_in_education",
  "any_further_suggestions_or_issues_for_improvement_in_education",
  "most_preferred_health_facility",
  "distance",
  "do_you_think_your_region_has_good_in_health_facilities",
  "any_suggestions_for_improvement_in_health_facilities",
  "availability_of_parks_playground_or_other_recreation_spaces",
  "do_you_or_your_family_members_go_to_a_park_or_playground",
  "if_yes_how_regular_you_go_to_park_or_playground",
  "any_further_suggestion_or_issues_for_improvement_in_parks",
  "do_you_receive_any_grant_from_any_state_govt_flagship_scheme",
  "if_availing_any_other_schemes_please_specify",
  "does_this_place_is_allotted_to_you_by_any_authority",
  "status_of_land",
  "if_government_land_is_there_any_patta",
  "how_long_have_you_stayed_here",
  "types_of_work_in_which_you_are_engaged",
  "are_you_skilled_labour",
  "if_yes_skill_type_carpenter_electrician_etc",
  "due_to_the_covid19_has_the_income_and_job_been_affected",
  "do_you_get_any_ration_assistance_from_the_government",
  "type_of_ration_card_you_available",
  "do_you_get_any_financial_assistance_from_the_government",
  "get_any_benefits_from_any_state_or_central_housing_schemes",
  "allotted_house_under_slum_rehabilitation_project_of_government",
  "if_government_provides_a_house_would_you_move_to_that_place",
  "do_you_get_any_benefit_of_swasthya_sathi_for_health_assistance",
  "willing_to_go_back_to_native_if_suitable_jobs_are_made_available",
  "what_do_you_say_about_life_in_slum_areas",
  "what_kind_of_problems_do_you_face",
  "do_you_face_any_problems_from_industries_around_you",
  "whether_all_children_enrolled_in_the_school",
  "if_yes_which_type_of_school",
  "if_not_going_to_school_drop_out_age",
  "reason_of_drop_out",
  "if_more_than_one_student",
  "alternative_economic_activities_for_livelihood",
  "any_further_suggestion_or_issues_for_improvement_regarding_slums",
  "do_you_have_boats",
  "if_yes_the_purpose_of_using_boats",
  "are_you_associated_with_fishing_related_activities",
  "if_yes_then_specify_as_seller_catcher_supplier_or_other",
  "have_you_been_engaged_in_other_activities_apart_from_fishing",
  "if_yes_specify_the_activities",
  "do_you_think_living_in_coastal_region_is_threat_or_opportunity",
  "how_do_you_get_the_information_related_to_natural_threats",
  "safe_place_during_natural_events",
  "after_natural_disaster_how_many_days_take_come_to_normal",
  "major_damages_during_natural_calamities",
  "availability_of_ration_during_the_natural_disaster",
  "whether_any_fund_area_granted_for_the_flood_prone_area",
  "does_this_region_have_any_tourism_opportunities",
  "any_further_suggestions_or_issues_in_coastal_region",
  "family_or_nearby_person_suffered_from_diseases_in_last_few_years",
  "if_yes_which_diseases_specify",
  "do_you_or_family_member_face_any_problem_in_breathing",
  "major_cause_of_pollution",
  "do_you_face_any_issues_during_the_rainy_season",
  "if_yes_specify_issues_faced_in_rainy_season",
  "whether_the_area_is_prone_to_flooding_due_to_rains",
  "if_yes_how_many_days_it_takes_to_normal_condition",
  "during_flooding_is_rehabilitation_centres_available",
  "whether_any_funds_granted_to_you_for_such_disaster",
  "do_hoardings_create_any_visual_disturbance_while_driving",
  "does_traffic_movement_and_noise_an_issue_for_your_locality",
  "if_yes_suggestion_for_improvement_in_traffic_issue",
  "whether_the_waste_disposed_off_in_a_nearby_river_or_water_body",
  "any_further_suggestion_for_improvement_in_environment",
  "popular_festival_occasion",
  "this_place_have_any_significant_heritage_site_structure",
  "visitors_during_the_festivals_or_occasion",
  "problem_faced_during_the_festivals_and_occasion",
  "festive_occasion_presence_help_you_in_the_economic_generation",
  "if_yes_specify_how_festivals_helps",
  "do_tourists_visit_this_place_regularly_or_during_festivals",
  "any_further_suggestion_in_cultural_heritage",
  "do_tourists_come_to_this_region_regularly",
  "best_season_for_tourist_to_visit_and_why",
  "are_you_involved_in_tourists_related_activities",
  "which_type_of_activities_youre_involved_in",
  "any_other_work_engagement_apart_from_tourist_activity",
  "no_of_person_or_family_member_engage_in_such_activity",
  "if_handicraft_what_items_do_you_sell",
  "whom_do_you_sell_your_products_to_most_often",
  "participate_in_any_fair_or_mela_for_product_showcase_and_sell",
  "if_yes_where_and_how_often_do_you_visit",
  "availability_of_training_centre_and_exhibition_centre",
  "sell_of_products",
  "tourism_sector_helps_in_economic_growth_of_this_region",
  "any_further_suggestion_for_improvement_in_tourism"
];
