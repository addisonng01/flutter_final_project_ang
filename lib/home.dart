import 'package:flutter/material.dart';
import 'package:flutter_final_project_ang/nba/stats.dart';
//gives the player's information in a list
import 'nba/api_call.dart';
//used to enhance the UI by adding functionality to view further details of a player
import 'details.dart';
//used to enhance the user experience by detailing the application's purpose and function
import 'app_info.dart';

/*
  The home.dart file is used to create the user interface of the application.
  It uses other dart.files to get data and widgets to populate the screen.
 */

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
        title: const Text('Flutter Final Project ANG'),
      ),
      backgroundColor: Colors.lightBlue.shade50,
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
          // calls class from app_info.dart and populates the right half of the screen
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
            //sets data from future to myPlayerList
            List<Player> myPlayerList = snapshot.data!;
            //filters myPlayerList by team name
            List<Player> filteredPlayers = selectedTeam == 'All Teams'
                ? List.from(myPlayerList)
                : myPlayerList.where((player) => player.team.fullName == selectedTeam).toList();
            //calls method to create the list view
            return playerListBuilder(context, filteredPlayers, myPlayerList);
          }
        },
      ),
    );
  }

  //this method creates a list view within a container
  Container playerListBuilder(BuildContext context, List<Player> filteredPlayers, List<Player> myPlayerList) {
    return Container(
      // Set the width to half of the screen width
      width: MediaQuery.of(context).size.width / 2,
      child: ListView.builder(
        itemCount: filteredPlayers.length,
        itemBuilder: (context, position) {
          //combines the first and last name for a player
          //ex. first name: 'Brandon', last name: 'Miller'; combined fullname: 'Brandon Miller'
          final fullname = '${filteredPlayers[position].player.firstName} ${filteredPlayers[position].player.lastName}';
          //uses the player's team's abbreviation to match name of .png files located in assets folder
          //ex. Jayson Tatum's stats data from json contains the team he plays for, which is the Boston Celtics
          // the Boston Celtics have a team abbreviation of 'bos'
          // teamLogo = 'bos' + '.png' = bos.png which is the name of the png file in assets
          final teamLogo = '${filteredPlayers[position].team.abbreviation.toLowerCase()}.png';
          return Card(
            child: ListTile(
              //navigates the user to the details screen (details.dart) when a player's card is tapped
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
                  //uses the png images in assets folder to add an image of the logo of the team of the player
                  //ex. Paolo Banchero plays for the Orlando Magic
                  // on the left side of the tile, Orlando Magic's logo is displayed
                  Image.asset(
                    teamLogo,
                    width: 75,
                    height: 75,
                  ),
                  //spacing box
                  const SizedBox(width: 10),
                  //prints the player's first and last name
                  Text(fullname),
                ],
              ),
              //prints the player's position if they have one
              /*
              Positions in basketball:
              PG = Point Guard
              SG = Shooting Guard
              SF = Small Forward
              PF = Power Forward
              C = Center
              Sometimes a player may play multiple positions, so they may be listed as a combination of those positions
              G-F = A player that can play SG or SF
              F-C = A player that can play PF or C
              G = A player that can play both guard positions (PG + SG)
              F = A player that can play both forward positions (SF + PF)
               */
              subtitle: Text(filteredPlayers[position].player.position),
            ),
          );
        },
      ),
    );
  }
}
