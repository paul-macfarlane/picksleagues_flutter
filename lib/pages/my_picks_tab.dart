import 'package:flutter/material.dart';
import '../widgets/pick_card.dart';

class MyPicksTab extends StatefulWidget {
  final String leagueId;
  const MyPicksTab({super.key, required this.leagueId});

  @override
  State<MyPicksTab> createState() => _MyPicksTabState();
}

class _MyPicksTabState extends State<MyPicksTab> {
  // Mock state
  String _selectedWeek = 'Week 1';
  final List<String> _weeks = [
    'Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
    'Week 5',
  ];
  final String pickType = 'Against the Spread'; // or 'Straight Up'
  final bool beforeLock = false; // now after lock

  // Mock games data with status and results
  final List<Map<String, dynamic>> _games = [
    {
      'id': 'g1',
      'away': {'abbr': 'NYJ', 'logo': null, 'score': 17},
      'home': {'abbr': 'BUF', 'logo': null, 'score': 21},
      'start': 'Sun 1:00pm',
      'odds': {'favorite': 'BUF', 'spread': -6.5},
      'status': 'in_progress',
      'clock': 'Q3 12:34',
      'pick': 'home',
      'result': null, // in progress
    },
    {
      'id': 'g2',
      'away': {'abbr': 'NE', 'logo': null, 'score': 24},
      'home': {'abbr': 'MIA', 'logo': null, 'score': 27},
      'start': 'Sun 4:25pm',
      'odds': {'favorite': 'MIA', 'spread': -3.0},
      'status': 'final',
      'clock': 'Final',
      'pick': 'away',
      'result': 'win',
    },
    {
      'id': 'g3',
      'away': {'abbr': 'KC', 'logo': null, 'score': 21},
      'home': {'abbr': 'DEN', 'logo': null, 'score': 21},
      'start': 'Sun 8:20pm',
      'odds': {'favorite': 'KC', 'spread': -7.0},
      'status': 'final',
      'clock': 'Final',
      'pick': 'home',
      'result': 'push',
    },
    {
      'id': 'g4',
      'away': {'abbr': 'DAL', 'logo': null, 'score': 10},
      'home': {'abbr': 'PHI', 'logo': null, 'score': 24},
      'start': 'Mon 8:15pm',
      'odds': {'favorite': 'PHI', 'spread': -4.0},
      'status': 'final',
      'clock': 'Final',
      'pick': 'away',
      'result': 'loss',
    },
  ];

  // Mock picks state
  // Map<String, String> _picks = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Week selector
        Padding(
          padding: const EdgeInsets.all(16),
          child: DropdownButtonFormField<String>(
            value: _selectedWeek,
            decoration: const InputDecoration(
              labelText: 'Week',
              border: OutlineInputBorder(),
            ),
            items: _weeks
                .map((w) => DropdownMenuItem(value: w, child: Text(w)))
                .toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedWeek = val);
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _games.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, i) {
              final game = _games[i];
              return PickCard(
                game: game,
                pick: game['pick'],
                pickType: pickType,
                result: game['result'],
                status: game['status'],
              );
            },
          ),
        ),
      ],
    );
  }
}
