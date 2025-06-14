import 'package:flutter/material.dart';

class LeagueStandingsTab extends StatelessWidget {
  final String leagueId;
  const LeagueStandingsTab({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('League Standings for $leagueId (mock)'));
  }
}
