// To parse this JSON data, do
//
//     final player = playerFromJson(jsonString);

import 'dart:convert';

Player playerFromJson(String str) => Player.fromJson(json.decode(str));

String playerToJson(Player data) => json.encode(data.toJson());

class Player {
  int id;
  String fullName;
  String firstName;
  String lastName;
  String position;
  int heightFeet;
  int heightInches;
  int weightPounds;
  Team team;

  Player({
    required this.id,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.heightFeet,
    required this.heightInches,
    required this.weightPounds,
    required this.team,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json["id"],
    fullName: json["first_name"] + json["last_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    position: json["position"],
    heightFeet: json["height_feet"],
    heightInches: json["height_inches"],
    weightPounds: json["weight_pounds"],
    team: Team.fromJson(json["team"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName.toString(),
    "last_name": lastName,
    "position": position,
    "height_feet": heightFeet,
    "height_inches": heightInches,
    "weight_pounds": weightPounds,
    "team": team.toJson(),
  };
}

class Team {
  int id;
  String abbreviation;
  String city;
  String conference;
  String division;
  String fullName;
  String name;

  Team({
    required this.id,
    required this.abbreviation,
    required this.city,
    required this.conference,
    required this.division,
    required this.fullName,
    required this.name,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    abbreviation: json["abbreviation"],
    city: json["city"],
    conference: json["conference"],
    division: json["division"],
    fullName: json["full_name"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "abbreviation": abbreviation,
    "city": city,
    "conference": conference,
    "division": division,
    "full_name": fullName,
    "name": name,
  };
}
