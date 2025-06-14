import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_data.dart';

class JoinLeaguePage extends StatefulWidget {
  const JoinLeaguePage({super.key});

  @override
  State<JoinLeaguePage> createState() => _JoinLeaguePageState();
}

class _JoinLeaguePageState extends State<JoinLeaguePage> {
  final _nameController = TextEditingController();
  String _sportLeague = 'NFL';
  String? _season;
  String? _startWeek;
  String? _endWeek;
  String? _pickType;
  // ignore: unused_field
  int? _picksPerWeek;
  // ignore: unused_field
  int? _leagueSize;

  final List<String> _seasons = ['2024', '2025'];
  final List<String> _weeks = [
    'Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
    'Week 5',
    'Week 6',
    'Week 7',
    'Week 8',
    'Week 9',
    'Week 10',
    'Week 11',
    'Week 12',
    'Week 13',
    'Week 14',
    'Week 15',
    'Week 16',
    'Week 17',
    'Week 18',
    'Wild Card',
    'Divisional',
    'Conference',
    'Super Bowl',
  ];
  final List<String> _pickTypes = ['Against the Spread', 'Straight Up'];

  List<MockLeague> get _filteredLeagues {
    return mockLeagues.where((league) {
      if (_nameController.text.isNotEmpty &&
          !league.name.toLowerCase().contains(
            _nameController.text.toLowerCase(),
          )) {
        return false;
      }
      if (_sportLeague.isNotEmpty && league.sportLeague != _sportLeague) {
        return false;
      }
      if (_pickType != null && league.pickType != _pickType) {
        return false;
      }
      // Add more filter logic as needed for other fields
      return true;
    }).toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _joinLeague(MockLeague league) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Joined ${league.name} (mock)!')));
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join League')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Filters
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'League Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _sportLeague,
              decoration: const InputDecoration(
                labelText: 'Sport League',
                border: OutlineInputBorder(),
              ),
              items: const [DropdownMenuItem(value: 'NFL', child: Text('NFL'))],
              onChanged: (val) {
                if (val != null) setState(() => _sportLeague = val);
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _season,
              decoration: const InputDecoration(
                labelText: 'Season',
                border: OutlineInputBorder(),
              ),
              items: _seasons
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (val) => setState(() => _season = val),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _startWeek,
                    decoration: const InputDecoration(
                      labelText: 'Start Week',
                      border: OutlineInputBorder(),
                    ),
                    items: _weeks
                        .map((w) => DropdownMenuItem(value: w, child: Text(w)))
                        .toList(),
                    onChanged: (val) => setState(() => _startWeek = val),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _endWeek,
                    decoration: const InputDecoration(
                      labelText: 'End Week',
                      border: OutlineInputBorder(),
                    ),
                    items: _weeks
                        .map((w) => DropdownMenuItem(value: w, child: Text(w)))
                        .toList(),
                    onChanged: (val) => setState(() => _endWeek = val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _pickType,
              decoration: const InputDecoration(
                labelText: 'Pick Type',
                border: OutlineInputBorder(),
              ),
              items: _pickTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (val) => setState(() => _pickType = val),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Picks per Week',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) =>
                        setState(() => _picksPerWeek = int.tryParse(val)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'League Size',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) =>
                        setState(() => _leagueSize = int.tryParse(val)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredLeagues.isEmpty
                  ? const Center(child: Text('No leagues found.'))
                  : ListView.builder(
                      itemCount: _filteredLeagues.length,
                      itemBuilder: (context, i) {
                        final league = _filteredLeagues[i];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: league.logoUrl != null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      league.logoUrl!,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    child: Text(
                                      league.name[0],
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                            title: Text(league.name),
                            subtitle: Text(
                              '${league.sportLeague} • ${league.pickType}',
                            ),
                            trailing: ElevatedButton(
                              onPressed: () => _joinLeague(league),
                              child: const Text('Join'),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.go('/home'),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
