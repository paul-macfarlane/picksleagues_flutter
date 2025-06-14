// sample data schema, use this to mock out the data
import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class LeagueCard extends StatelessWidget {
  final MockLeague league;
  const LeagueCard({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: league.logoUrl != null
            ? CircleAvatar(backgroundImage: NetworkImage(league.logoUrl!))
            : CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  league.name[0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
        title: Text(league.name),
        subtitle: Text('${league.sportLeague} • ${league.pickType}'),
        onTap: () {},
      ),
    );
  }
}
