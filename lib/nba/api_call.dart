import 'dart:convert';
import 'stats.dart';
import 'package:http/http.dart' as http;


class PlayerRepository {
  static const String baseUrl = 'https://www.balldontlie.io/api/v1/';

  Future<List<Player>> fetchPlayers() async {
    final response = await http.get(Uri.parse('$baseUrl/stats?seasons[]=2023&per_page=200'));
    List<Player> playerList = [];

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      for (var playerData in jsonData['data']) {
        Player player = Player.fromJson(playerData);
        playerList.add(player);
      }
      return playerList;
    } else {
      throw Exception('Failed to load players');
    }
  }
}