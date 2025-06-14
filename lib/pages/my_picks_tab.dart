import 'package:flutter/material.dart';

class MyPicksTab extends StatelessWidget {
  final String leagueId;
  const MyPicksTab({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('My Picks for $leagueId (mock)'));
  }
}
