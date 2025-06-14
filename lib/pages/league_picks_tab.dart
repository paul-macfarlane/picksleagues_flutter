import 'package:flutter/material.dart';

class LeaguePicksTab extends StatelessWidget {
  final String leagueId;
  const LeaguePicksTab({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('League Picks for $leagueId (mock)'));
  }
}
