import 'package:flutter/material.dart';

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
              final pick = game['pick'];
              final result = game['result'];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _TeamDisplay(
                            team: game['away'],
                            score: game['away']['score'],
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '@',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          _TeamDisplay(
                            team: game['home'],
                            score: game['home']['score'],
                          ),
                          const Spacer(),
                          Text(
                            game['clock'] ?? '',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      if (pickType == 'Against the Spread')
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Odds: ${game['odds']['favorite']} ${game['odds']['spread'] > 0 ? '+' : ''}${game['odds']['spread']}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            'Your pick: ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (pick != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                pick == 'away'
                                    ? game['away']['abbr']
                                    : game['home']['abbr'],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            )
                          else
                            const Text('No pick'),
                          const SizedBox(width: 16),
                          if (game['status'] == 'in_progress')
                            Chip(
                              label: Text('In Progress'),
                              backgroundColor: Colors.blue.shade100,
                              labelStyle: const TextStyle(color: Colors.blue),
                            )
                          else if (result == 'win')
                            Chip(
                              label: const Text('Win'),
                              backgroundColor: Colors.green.shade100,
                              labelStyle: const TextStyle(color: Colors.green),
                            )
                          else if (result == 'push')
                            Chip(
                              label: const Text('Push'),
                              backgroundColor: Colors.grey.shade300,
                              labelStyle: const TextStyle(
                                color: Colors.black87,
                              ),
                            )
                          else if (result == 'loss')
                            Chip(
                              label: const Text('Loss'),
                              backgroundColor: Colors.red.shade100,
                              labelStyle: const TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TeamDisplay extends StatelessWidget {
  final Map<String, dynamic> team;
  final int? score;
  const _TeamDisplay({required this.team, this.score});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            team['abbr'][0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 4),
        Text(team['abbr'], style: const TextStyle(fontWeight: FontWeight.bold)),
        if (score != null) ...[
          const SizedBox(width: 4),
          Text(
            score.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );
  }
}
