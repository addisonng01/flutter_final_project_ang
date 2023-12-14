import 'package:flutter/material.dart';
import 'nba/stats.dart'; // Import the Player class

class DetailsScreen extends StatelessWidget {
  final Player player; // Change the type to Player

  DetailsScreen({required this.player}); // Change the constructor parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetail('Name', '${player.player.firstName} ${player.player.lastName}'),
          _buildDetail('Position', player.player.position),
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
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text('$label:'),
          SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}
