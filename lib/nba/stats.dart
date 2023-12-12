// To parse this JSON data, do
//
//     final player = playerFromJson(jsonString);

import 'dart:convert';

Player playerFromJson(String str) => Player.fromJson(json.decode(str));

String playerToJson(Player data) => json.encode(data.toJson());

class Player {
  int id;
  int ast;
  int blk;
  int dreb;
  double fg3Pct;
  int fg3A;
  int fg3M;
  double fgPct;
  int fga;
  int fgm;
  double ftPct;
  int fta;
  int ftm;
  Game game;
  String min;
  int oreb;
  int pf;
  PlayerClass player;
  int pts;
  int reb;
  int stl;
  Team team;
  int turnover;

  Player({
    required this.id,
    required this.ast,
    required this.blk,
    required this.dreb,
    required this.fg3Pct,
    required this.fg3A,
    required this.fg3M,
    required this.fgPct,
    required this.fga,
    required this.fgm,
    required this.ftPct,
    required this.fta,
    required this.ftm,
    required this.game,
    required this.min,
    required this.oreb,
    required this.pf,
    required this.player,
    required this.pts,
    required this.reb,
    required this.stl,
    required this.team,
    required this.turnover,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json["id"],
    ast: json["ast"],
    blk: json["blk"],
    dreb: json["dreb"],
    fg3Pct: json["fg3_pct"]?.toDouble(),
    fg3A: json["fg3a"],
    fg3M: json["fg3m"],
    fgPct: json["fg_pct"]?.toDouble(),
    fga: json["fga"],
    fgm: json["fgm"],
    ftPct: json["ft_pct"]?.toDouble(),
    fta: json["fta"],
    ftm: json["ftm"],
    game: Game.fromJson(json["game"]),
    min: json["min"],
    oreb: json["oreb"],
    pf: json["pf"],
    player: PlayerClass.fromJson(json["player"]),
    pts: json["pts"],
    reb: json["reb"],
    stl: json["stl"],
    team: Team.fromJson(json["team"]),
    turnover: json["turnover"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ast": ast,
    "blk": blk,
    "dreb": dreb,
    "fg3_pct": fg3Pct,
    "fg3a": fg3A,
    "fg3m": fg3M,
    "fg_pct": fgPct,
    "fga": fga,
    "fgm": fgm,
    "ft_pct": ftPct,
    "fta": fta,
    "ftm": ftm,
    "game": game.toJson(),
    "min": min,
    "oreb": oreb,
    "pf": pf,
    "player": player.toJson(),
    "pts": pts,
    "reb": reb,
    "stl": stl,
    "team": team.toJson(),
    "turnover": turnover,
  };
}

class Game {
  int id;
  DateTime date;
  int homeTeamId;
  int homeTeamScore;
  int season;
  int visitorTeamId;
  int visitorTeamScore;

  Game({
    required this.id,
    required this.date,
    required this.homeTeamId,
    required this.homeTeamScore,
    required this.season,
    required this.visitorTeamId,
    required this.visitorTeamScore,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    homeTeamId: json["home_team_id"],
    homeTeamScore: json["home_team_score"],
    season: json["season"],
    visitorTeamId: json["visitor_team_id"],
    visitorTeamScore: json["visitor_team_score"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date.toIso8601String(),
    "home_team_id": homeTeamId,
    "home_team_score": homeTeamScore,
    "season": season,
    "visitor_team_id": visitorTeamId,
    "visitor_team_score": visitorTeamScore,
  };
}

class PlayerClass {
  int id;
  String firstName;
  String lastName;
  String position;
  int teamId;

  PlayerClass({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.teamId,
  });

  factory PlayerClass.fromJson(Map<String, dynamic> json) => PlayerClass(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    position: json["position"],
    teamId: json["team_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "position": position,
    "team_id": teamId,
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
