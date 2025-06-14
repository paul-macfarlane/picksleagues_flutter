import 'package:flutter/material.dart';

class LeagueSettingsTab extends StatelessWidget {
  final String leagueId;
  const LeagueSettingsTab({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('League Settings for $leagueId (mock)'));
  }
}
