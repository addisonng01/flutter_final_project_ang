import 'dart:convert';
import 'stats.dart';
import 'package:http/http.dart' as http;

/*
  The api_call.dart file is used to pull information from the balldontlie.io API.
 */

class PlayerRepository {
  //method to parse data from the balldontlie.io API and populate a list of player
  Future<List<Player>> fetchPlayers() async {
    //pulls data for the current season of the NBA (2023-2024). In the string, it used 'seasons[]=2023'
    //because the season parameter pulls from the beginning(2023) to the end(2024) of the season.
    //This means if you want to find the current season, then you must use 2023.
    final response = await http.get(Uri.parse('https://www.balldontlie.io/api/v1//stats?seasons[]=2023&per_page=200'));
    List<Player> playerList = [];

    //these print statements are used for testing to check whether or not
    //the API is accessed and whether the data from the API is pulled properly
      //print('Response status code: ${response.statusCode}');
      //print('Response body: ${response.body}');

    //checks whether you have successfully received the data from the API
    //and then generates a list for all players that are retrieved from the API
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      //creates a player object for all players in the API string
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