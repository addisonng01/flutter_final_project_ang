import 'package:flutter/material.dart';
import 'package:flutter_final_project_ang/nba/stats.dart';
import 'nba/api_call.dart';
import 'details.dart';
import 'app_info.dart';

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
      body: Row(
        children: [
          Expanded(
            child: Column(
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
                dropdownMenu(),
                listPlayers(),
              ],
            ),
          ),
          // Use the RightHalfWidget here
          appInfo(),
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
      child: FutureBuilder(
        future: futurePlayer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No players available.');
          } else {
            List<Player> myPlayerList = snapshot.data!;
            List<Player> filteredPlayers = selectedTeam == 'All Teams'
                ? List.from(myPlayerList)
                : myPlayerList.where((player) => player.team.fullName == selectedTeam).toList();
            return playerListBuilder(context, filteredPlayers, myPlayerList);
          }
        },
      ),
    );
  }

  Container playerListBuilder(BuildContext context, List<Player> filteredPlayers, List<Player> myPlayerList) {
    return Container(
      // Set the width to half of the screen width
      width: MediaQuery.of(context).size.width / 2,
      child: ListView.builder(
        itemCount: filteredPlayers.length,
        itemBuilder: (context, position) {
          final fullname = '${filteredPlayers[position].player.firstName} ${filteredPlayers[position].player.lastName}';
          final teamLogo = '${filteredPlayers[position].team.abbreviation.toLowerCase()}.png';
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(player: myPlayerList[position]),
                  ),
                );
              },
              title: Row(
                children: [
                  Image.asset(
                    teamLogo,
                    width: 75,
                    height: 75,
                  ),
                  const SizedBox(width: 10),
                  Text(fullname),
                ],
              ),
              subtitle: Text(filteredPlayers[position].player.position),
            ),
          );
        },
      ),
    );
  }
}
