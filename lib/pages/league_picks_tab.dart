import 'package:flutter/material.dart';
import '../widgets/pick_card.dart';

class LeaguePicksTab extends StatefulWidget {
  final String leagueId;
  const LeaguePicksTab({super.key, required this.leagueId});

  @override
  State<LeaguePicksTab> createState() => _LeaguePicksTabState();
}

class _LeaguePicksTabState extends State<LeaguePicksTab> {
  String _selectedWeek = 'Week 1';
  final List<String> _weeks = [
    'Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
    'Week 5',
  ];
  final String pickType = 'Against the Spread';
  final bool beforeLock = false; // set to true to test locked state

  // Mock users and picks
  final List<Map<String, dynamic>> _users = [
    {
      'id': '1',
      'name': 'Sam Smith',
      'username': 'nflfan',
      'avatarUrl': null,
      'rank': 1,
      'weekRank': 1,
      'pointsEarned': 3.0,
      'pointsAvailable': 4.0,
      'picks': [
        // Each is a game map as in PickCard
        {
          'id': 'g1',
          'away': {'abbr': 'NYJ', 'logo': null, 'score': 17},
          'home': {'abbr': 'BUF', 'logo': null, 'score': 21},
          'clock': 'Q3 12:34',
          'odds': {'favorite': 'BUF', 'spread': -6.5},
          'pick': 'home',
          'pickType': 'Against the Spread',
          'result': null,
          'status': 'in_progress',
        },
        {
          'id': 'g2',
          'away': {'abbr': 'NE', 'logo': null, 'score': 24},
          'home': {'abbr': 'MIA', 'logo': null, 'score': 27},
          'clock': 'Final',
          'odds': {'favorite': 'MIA', 'spread': -3.0},
          'pick': 'away',
          'pickType': 'Against the Spread',
          'result': 'win',
          'status': 'final',
        },
      ],
    },
    {
      'id': '2',
      'name': 'Alex Johnson',
      'username': 'alexj',
      'avatarUrl': null,
      'rank': 2,
      'weekRank': 2,
      'pointsEarned': 2.0,
      'pointsAvailable': 4.0,
      'picks': [
        {
          'id': 'g1',
          'away': {'abbr': 'NYJ', 'logo': null, 'score': 17},
          'home': {'abbr': 'BUF', 'logo': null, 'score': 21},
          'clock': 'Q3 12:34',
          'odds': {'favorite': 'BUF', 'spread': -6.5},
          'pick': 'away',
          'pickType': 'Against the Spread',
          'result': null,
          'status': 'in_progress',
        },
        {
          'id': 'g2',
          'away': {'abbr': 'NE', 'logo': null, 'score': 24},
          'home': {'abbr': 'MIA', 'logo': null, 'score': 27},
          'clock': 'Final',
          'odds': {'favorite': 'MIA', 'spread': -3.0},
          'pick': 'home',
          'pickType': 'Against the Spread',
          'result': 'loss',
          'status': 'final',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        if (beforeLock)
          const Padding(
            padding: EdgeInsets.all(32),
            child: Center(
              child: Text(
                "Picks are locked and can't be viewed yet.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _users.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, i) {
                final user = _users[i];
                return _UserPicksCard(user: user);
              },
            ),
          ),
      ],
    );
  }
}

class _UserPicksCard extends StatefulWidget {
  final Map<String, dynamic> user;
  const _UserPicksCard({required this.user});

  @override
  State<_UserPicksCard> createState() => _UserPicksCardState();
}

class _UserPicksCardState extends State<_UserPicksCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Avatar, name, username
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    user['avatarUrl'] != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(user['avatarUrl']),
                          )
                        : CircleAvatar(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            child: Text(
                              user['name'][0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                    const SizedBox(height: 8),
                    Text(
                      user['name'],
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '@${user['username']}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                // Right: Stats and expand/collapse
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Week Rank: ${user['weekRank']}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Season Rank: ${user['rank']}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Points: ${user['pointsEarned']} / ${user['pointsAvailable']}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Season Points: ${user['seasonPoints'] ?? 12.0}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            _expanded ? Icons.expand_less : Icons.expand_more,
                          ),
                          onPressed: () =>
                              setState(() => _expanded = !_expanded),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  for (final pick in user['picks'])
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: PickCard(
                        game: pick,
                        pick: pick['pick'],
                        pickType: pick['pickType'],
                        result: pick['result'],
                        status: pick['status'],
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
