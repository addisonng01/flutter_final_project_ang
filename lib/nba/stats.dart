class Player {
  final String first_name;
  final String last_name;
  final int id;

  Player(
      {
        required this.first_name,
        required this.last_name,
        required this.id,
      });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      first_name: json['first_name'],
      last_name: json['last_name'],
      id: json['id'],
    );
  }
}

class Datum {
  int gamesPlayed;
  int playerId;
  int season;
  String min;
  double fgm;
  double fga;
  double fg3M;
  double fg3A;
  double ftm;
  double fta;
  double oreb;
  double dreb;
  double reb;
  double ast;
  double stl;
  double blk;
  double turnover;
  double pf;
  double pts;
  double fgPct;
  double fg3Pct;
  double ftPct;

  Datum({
    required this.gamesPlayed,
    required this.playerId,
    required this.season,
    required this.min,
    required this.fgm,
    required this.fga,
    required this.fg3M,
    required this.fg3A,
    required this.ftm,
    required this.fta,
    required this.oreb,
    required this.dreb,
    required this.reb,
    required this.ast,
    required this.stl,
    required this.blk,
    required this.turnover,
    required this.pf,
    required this.pts,
    required this.fgPct,
    required this.fg3Pct,
    required this.ftPct,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    gamesPlayed: json["games_played"],
    playerId: json["player_id"],
    season: json["season"],
    min: json["min"],
    fgm: json["fgm"]?.toDouble(),
    fga: json["fga"]?.toDouble(),
    fg3M: json["fg3m"]?.toDouble(),
    fg3A: json["fg3a"]?.toDouble(),
    ftm: json["ftm"]?.toDouble(),
    fta: json["fta"]?.toDouble(),
    oreb: json["oreb"]?.toDouble(),
    dreb: json["dreb"]?.toDouble(),
    reb: json["reb"]?.toDouble(),
    ast: json["ast"]?.toDouble(),
    stl: json["stl"]?.toDouble(),
    blk: json["blk"]?.toDouble(),
    turnover: json["turnover"]?.toDouble(),
    pf: json["pf"]?.toDouble(),
    pts: json["pts"]?.toDouble(),
    fgPct: json["fg_pct"]?.toDouble(),
    fg3Pct: json["fg3_pct"]?.toDouble(),
    ftPct: json["ft_pct"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "games_played": gamesPlayed,
    "player_id": playerId,
    "season": season,
    "min": min,
    "fgm": fgm,
    "fga": fga,
    "fg3m": fg3M,
    "fg3a": fg3A,
    "ftm": ftm,
    "fta": fta,
    "oreb": oreb,
    "dreb": dreb,
    "reb": reb,
    "ast": ast,
    "stl": stl,
    "blk": blk,
    "turnover": turnover,
    "pf": pf,
    "pts": pts,
    "fg_pct": fgPct,
    "fg3_pct": fg3Pct,
    "ft_pct": ftPct,
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