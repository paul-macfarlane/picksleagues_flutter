import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../widgets/league_card.dart';
import '../app_theme.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                backgroundImage: mockUser.avatarUrl != null
                    ? NetworkImage(mockUser.avatarUrl!)
                    : null,
                child: Text(
                  mockUser.avatarUrl == null ? mockUser.firstName[0] : '',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.go('/profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign Out'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Toggle Theme'),
                onTap: () {
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).toggleTheme();
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (mockInvites.isNotEmpty) ...[
            Text('Invites', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...mockInvites.map(
              (invite) => Card(
                child: ListTile(
                  title: Text(invite.leagueName),
                  subtitle: Text('Invited by ${invite.inviterName}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
          Text('Your Leagues', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...mockLeagues.map((league) => LeagueCard(league: league)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Create League'),
                onPressed: () {},
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.group),
                label: const Text('Join League'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
