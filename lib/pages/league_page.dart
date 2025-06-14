import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_data.dart';
import 'league_members_tab.dart';
import 'league_standings_tab.dart';
import 'my_picks_tab.dart';
import 'league_picks_tab.dart';
import 'league_settings_tab.dart';

class LeaguePage extends StatelessWidget {
  final String leagueId;
  const LeaguePage({super.key, required this.leagueId});

  String getLeagueName() {
    // Mock: find league by id
    final league = mockLeagues.firstWhere(
      (l) => l.id == leagueId,
      orElse: () => mockLeagues.first,
    );
    return league.name;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(getLeagueName()),
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              tooltip: 'Home',
              onPressed: () => context.go('/home'),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Members'),
              Tab(text: 'Standings'),
              Tab(text: 'My Picks'),
              Tab(text: 'League Picks'),
              Tab(text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LeagueMembersTab(leagueId: leagueId),
            LeagueStandingsTab(leagueId: leagueId),
            MyPicksTab(leagueId: leagueId),
            LeaguePicksTab(leagueId: leagueId),
            LeagueSettingsTab(leagueId: leagueId),
          ],
        ),
      ),
    );
  }
}
