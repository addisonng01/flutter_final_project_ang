import 'package:flutter/material.dart';
import 'nba/stats.dart';

class DetailsScreen extends StatelessWidget {
  final Player player;

  DetailsScreen({required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              '${player.team.abbreviation.toLowerCase()}.png',
              width: 250,
              height: 250,
            ),
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

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26, // Adjust the font size as needed
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 26, // Adjust the font size as needed
            ),
          ),
        ],
      ),
    );
  }
}
