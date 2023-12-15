import 'package:flutter/material.dart';
import 'nba/stats.dart';

/*
  The details.dart file is used to create a Details page for a player. It displays the player's information such as
  in-game statistics, position, and team.
 */

class DetailsScreen extends StatelessWidget {
  //creates a player to be able to use the data within it
  final Player player;
  DetailsScreen({required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //displays the logo of the team that the player plays for
            //ex. Jalen Suggs plays for the Orlando Magic, a logo of the Orlando Magic is displayed
            Image.asset(
              '${player.team.abbreviation.toLowerCase()}.png',
              width: 250,
              height: 250,
            ),
            //calls method to create categories of data for the player
            _buildDetail('Name', '${player.player.firstName} ${player.player.lastName}'),
            _buildDetail('Position', player.player.position ),
            _buildDetail('Team', player.team.fullName),
            _buildDetail('Points', player.pts.toString()),
            _buildDetail('Rebounds', player.reb.toString()),
            _buildDetail('Assists', player.ast.toString()),
            _buildDetail('Field Goal', player.fgPct.toString()),
            _buildDetail('3pt Field', player.fg3Pct.toString()),
            _buildDetail('Steals', player.stl.toString()),
            _buildDetail('Blocks', player.blk.toString()),
            // Add more stats as needed
          ],
        ),
      ),
    );
  }

  //creates a widget that formats the data for a player
  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          //for data type
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          //for player's data
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}
