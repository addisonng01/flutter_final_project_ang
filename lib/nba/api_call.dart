import 'dart:convert';
import 'stats.dart';
import 'package:http/http.dart' as http;


class PlayerRepository {
  static const String baseUrl = 'https://www.balldontlie.io/api/v1/stats';

  Future<List<Player>> fetchPlayers() async {
    final response = await http.get(Uri.parse('$baseUrl/?seasons[]=2018&player_ids[]'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print('got response.body, getting data');

      List<Player> playerList = [];

      for (var playerData in jsonData['data']) {
        Player player = playerFromJson(playerData);
        playerList.add(player);
        print(playerList);         //testing to check if players are received
      }

      return playerList;
    } else {
      throw Exception('Failed to load players');
    }
  }
}