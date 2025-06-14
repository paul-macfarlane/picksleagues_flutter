import 'package:flutter/material.dart';

class LeagueMembersTab extends StatelessWidget {
  final String leagueId;
  const LeagueMembersTab({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('League Members for $leagueId (mock)'));
  }
}
