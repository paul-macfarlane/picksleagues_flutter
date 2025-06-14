import 'package:flutter/material.dart';

class PickCard extends StatelessWidget {
  final Map<String, dynamic> game;
  final String? pick; // 'away' or 'home'
  final String pickType; // 'Against the Spread' or 'Straight Up'
  final String? result; // 'win', 'push', 'loss', or null
  final String? status; // 'in_progress', 'final', etc.

  const PickCard({
    super.key,
    required this.game,
    required this.pick,
    required this.pickType,
    required this.result,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _TeamDisplay(team: game['away'], score: game['away']['score']),
                const SizedBox(width: 8),
                const Text('@', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                _TeamDisplay(team: game['home'], score: game['home']['score']),
                const Spacer(),
                Text(game['clock'] ?? '', style: const TextStyle(fontSize: 12)),
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
                  'Pick: ',
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
                if (status == 'in_progress')
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
                    labelStyle: const TextStyle(color: Colors.black87),
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
