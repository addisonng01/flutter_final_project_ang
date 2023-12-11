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
  late Future<Player> futurePlayer;
  List<Player> playerList = [];

  @override
  void initState() {
    super.initState();
    print('in InitState about to get player...');
    futurePlayer = fetchPlayers() as Future<Player>;

    setState(() {
      playerList = playerList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Builder Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text(
              'Top 5 Best Players of the Month',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          listMonth(),
          //SizedBox(width: 500, height: 10,),
          Text('asdsadsa'),
        ],
      ),
    );
  }

  Expanded listMonth() {
    return Expanded(
      child: FutureBuilder(
        future: futurePlayer,
        builder: (context, snapshot){
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.none) {
            return Container();
          }
          List<Player> myPlayer = snapshot.data! as List<Player>;
          return ListView.builder(
            itemCount: playerList.length,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                child: ListTile(
                title: Text(playerList[position].fullName),
                subtitle: Text('ID: ${playerList[position].id}'),
                ),
              );
            },
          );
        }
      )
    );
  }
}