import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class LeagueMembersTab extends StatelessWidget {
  final String leagueId;
  const LeagueMembersTab({super.key, required this.leagueId});

  // Mock: Assume user is commissioner and not in season
  final bool isCommissioner = true;
  final bool inSeason = false;

  // Mock members list
  List<Map<String, dynamic>> get members => [
    {
      'id': '1',
      'name': 'Sam Smith',
      'username': 'nflfan',
      'avatarUrl': null,
      'role': 'commissioner',
    },
    {
      'id': '2',
      'name': 'Alex Johnson',
      'username': 'alexj',
      'avatarUrl': null,
      'role': 'member',
    },
    {
      'id': '3',
      'name': 'Taylor Lee',
      'username': 'tlee',
      'avatarUrl': null,
      'role': 'member',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: members.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, i) {
              final m = members[i];
              final isSelf = m['id'] == mockUser.id;
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                minVerticalPadding: 16,
                leading: m['avatarUrl'] != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(m['avatarUrl']),
                      )
                    : CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          m['name'][0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                title: Text(m['name']),
                subtitle: Text('@${m['username']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: m['role'] == 'commissioner'
                            ? Colors.amber.shade100
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        m['role'][0].toUpperCase() + m['role'].substring(1),
                        style: TextStyle(
                          color: m['role'] == 'commissioner'
                              ? Colors.amber.shade800
                              : Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (isCommissioner && !isSelf) ...[
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: m['role'],
                        items: const [
                          DropdownMenuItem(
                            value: 'member',
                            child: Text('Member'),
                          ),
                          DropdownMenuItem(
                            value: 'commissioner',
                            child: Text('Commissioner'),
                          ),
                        ],
                        onChanged: (val) {}, // Mock
                        underline: const SizedBox(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (!inSeason) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                          tooltip: 'Remove',
                          onPressed: () {}, // Mock
                        ),
                      ],
                    ],
                  ],
                ),
              );
            },
          ),
        ),
        if (isCommissioner && !inSeason)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.person_add),
                label: const Text('Invite Member'),
                onPressed: () {}, // Mock
              ),
            ),
          ),
      ],
    );
  }
}
