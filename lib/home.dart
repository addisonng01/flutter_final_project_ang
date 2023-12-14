import 'package:flutter/material.dart';
import 'package:flutter_final_project_ang/nba/stats.dart';
import 'nba/api_call.dart';
import 'edit.dart';
import 'details.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variables to initialize the list
  late Future<List<Player>> futurePlayer;
  final PlayerRepository playerRepository = PlayerRepository();
  // default value for dropdown menu
  String selectedTeam = 'All Teams';

  @override
  void initState() {
    super.initState();
    // calls fetchPlayers to populate the list
    futurePlayer = playerRepository.fetchPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NBA Player Index'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              'Players in the 2023-2024 NBA Season',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //calls method to create dropdown menu
          dropdownMenu(),
          //calls method to create list of players from 'balldontlie.io' api for the 2023-2024 season
          listPlayers(),
        ],
      ),
    );
  }

  //this method creates a dropdown menu that filters through the list of players and sorts them by team
  DropdownButton<String> dropdownMenu() {
    return DropdownButton<String>(
          value: selectedTeam,
          onChanged: (String? newValue) {
            setState(() {
              selectedTeam = newValue!;
            });
          },
          //small list of teams that are in the api. TODO: add all players from all 30 teams in the NBA
          items: ['All Teams','Orlando Magic', 'Boston Celtics', 'New York Knicks', 'Toronto Raptors', 'Washington Wizards']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
  }

  //method that creates the list that displays all players
  Expanded listPlayers() {
    return Expanded(
      //uses future builder to get players from the list made in api_call.dart
      child: FutureBuilder(
        future: futurePlayer,
        builder: (context, snapshot) {
          //checks the state of the data
          //if the data has not arrived yet, then a progress indicator is shown on screen
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          // if there is an error, then the error is printed on screen
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          //if the list is returned but it contains no data, then text is displayed to tell you that there are no items in the list
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No players available.');
          //if the list is returned properly and contains data, then it proceeds to make list
          } else {
            //myPlayerList is used to store the data from the future list
            List<Player> myPlayerList = snapshot.data!;
            //filteredPlayers is used to filter the data from myPlayerList
            List<Player> filteredPlayers = selectedTeam == 'All Teams'
                //checks whether the text from the dropdown menu matches any value from the stats
                //ex. dropdown list contains a value of 'Boston Celtics', checks for a player in the list that has the team.fullname value of 'Boston Celtics'
                ? List.from(myPlayerList)
                : myPlayerList.where((player) => player.team.fullName == selectedTeam).toList();
              return ListView.builder(
                itemCount: filteredPlayers.length,
                itemBuilder: (context, position) {
                  //variable that prints the full name of a player.
                  //ex. first name: 'Paolo', last name: 'Banchero'; returns their first and last name combined: 'Paolo Banchero'
                  final fullname = filteredPlayers[position].player.firstName + ' ' + filteredPlayers[position].player.lastName;
                  return Card(
                    child: ListTile(
                      onTap: () {
                        // Navigate to the details screen when the list tile is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(player: myPlayerList[position]),
                          ),
                        );
                      },
                      title: Text(fullname),
                      /*
                        prints the position of the player
                        PG = Point Guard
                        SG = Shooting Guard
                        SF = Small Forward
                        PF = Power Forward
                        C = Center
                        G = Guard, a player may play both Point Guard and Shooting Guard, so the player may be simply listed as a Guard instead
                        F = Forward, similar to the term Guard, a player that plays Forward may play both Small Forward and Power Forward
                       */
                      subtitle: Text(filteredPlayers[position].player.position),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }

}