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
                onPressed: () => _showInviteModal(context),
              ),
            ),
          ),
      ],
    );
  }

  void _showInviteModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DefaultTabController(
          length: 2,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              height: 350,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Copy Link'),
                      Tab(text: 'Search User'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Copy Link Tab
                        _InviteLinkTab(),
                        // Search User Tab
                        _InviteSearchTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InviteLinkTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inviteLink = 'https://picksleagues.app/invite/abc123';
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Share this link to invite someone to the league:'),
          const SizedBox(height: 16),
          SelectableText(
            inviteLink,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.copy),
            label: const Text('Copy Link'),
            onPressed: () {
              // Clipboard.setData(ClipboardData(text: inviteLink));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Link copied! (mock)')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _InviteSearchTab extends StatefulWidget {
  @override
  State<_InviteSearchTab> createState() => _InviteSearchTabState();
}

class _InviteSearchTabState extends State<_InviteSearchTab> {
  final _searchController = TextEditingController();
  final List<Map<String, String>> _mockUsers = [
    {'id': '4', 'name': 'Chris Green', 'username': 'cgreen'},
    {'id': '5', 'name': 'Morgan Blue', 'username': 'mblue'},
    {'id': '6', 'name': 'Jordan Red', 'username': 'jred'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase();
    final filtered = _mockUsers
        .where(
          (u) =>
              u['name']!.toLowerCase().contains(query) ||
              u['username']!.toLowerCase().contains(query),
        )
        .toList();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search by name or username',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No users found.'))
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final user = filtered[i];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          child: Text(
                            user['name']![0],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(user['name']!),
                        subtitle: Text('@${user['username']}'),
                        trailing: ElevatedButton(
                          child: const Text('Invite'),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Invited ${user['name']} (mock)!',
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
