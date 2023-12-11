import 'dart:convert';
import 'stats.dart';
import 'package:http/http.dart' as http;

// get players
Future<Player> fetchPlayers() async {
  final response = await http.get(Uri.parse('https://www.balldontlie.io/api/v1/players?per_page=5'));

  if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final player = Player.fromJson(jsonData);
      print(player);
      return player;
    } else {
      // Return null when no player data is available
      throw Exception('Failed to load players');
  }
}