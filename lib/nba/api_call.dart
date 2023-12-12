import 'dart:convert';
import 'stats.dart';
import 'package:http/http.dart' as http;

class PlayerRepository {
  static const String baseUrl = 'https://www.balldontlie.io/api/v1';

  Future<List<Player>> fetchPlayers() async {
    final response = await http.get(Uri.parse('$baseUrl/players?per_page=50'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<Player> playerList = [];

      for (var playerData in jsonData['data']) {
        final player = Player.fromJson(playerData);
        playerList.add(player);
        //print(playerList);         //testing to check if players are received
      }

      return playerList;
    } else {
      throw Exception('Failed to load players');
    }
  }

  Future<Datum> fetchPlayerStats(int playerId) async {
    final response = await http.get(Uri.parse('$baseUrl/season_averages?season=2023&player_ids[]=$playerId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['data'] != null && jsonData['data'].isNotEmpty) {
        final playerStatsData = jsonData['data'][0];
        final playerStats = Datum.fromJson(playerStatsData);
        return playerStats;
      }
    }

    throw Exception('Failed to load player stats');
  }
}