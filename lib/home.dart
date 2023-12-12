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
  late Future<List<Player>> playerList;
  final PlayerRepository playerRepository = PlayerRepository();

  @override
  void initState() {
    super.initState();
    playerList = playerRepository.fetchPlayers();

    setState(() {
      playerList = playerList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Builder Example'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(
              'Top 5 PPG in 2023',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          listMonth(),
          //SizedBox(width: 500, height: 10,),
        ],
      ),
    );
  }

  Expanded listMonth() {
    return Expanded(
      child: FutureBuilder(
        future: playerList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No players available.');
          } else {
            return listViewBuilder(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget listViewBuilder(List<Player> players) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, position) {
        final fullname = players[position].player.firstName + ' ' + players[position].player.lastName;
        return Card(
          child: ListTile(
            title: Text(fullname),
            subtitle: Text('test'),
          ),
        );
      },
    );
  }
}