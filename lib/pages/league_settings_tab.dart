import 'package:flutter/material.dart';

class LeagueSettingsTab extends StatefulWidget {
  final String leagueId;
  const LeagueSettingsTab({super.key, required this.leagueId});

  @override
  State<LeagueSettingsTab> createState() => _LeagueSettingsTabState();
}

class _LeagueSettingsTabState extends State<LeagueSettingsTab> {
  // Mock: user is commissioner and in season
  final bool isCommissioner = true;
  final bool inSeason = true;
  final bool outOfSeason = false;

  // Mock league data
  String leagueName = 'Sunday Sharps';
  String logoUrl = '';
  final String sportLeague = 'NFL';
  final String season = '2024';
  String startWeek = 'Week 1';
  String endWeek = 'Week 18';
  String pickType = 'Against the Spread';
  int picksPerWeek = 4;
  String visibility = 'Private';
  int leagueSize = 10;

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

  @override
  Widget build(BuildContext context) {
    final canEditAll = isCommissioner && outOfSeason;
    final canEditNameLogo = isCommissioner && inSeason;
    final canEdit = canEditAll || canEditNameLogo;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.primary,
              backgroundImage: logoUrl.isNotEmpty
                  ? NetworkImage(logoUrl)
                  : null,
              child: logoUrl.isEmpty
                  ? const Icon(
                      Icons.sports_football,
                      color: Colors.white,
                      size: 32,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            initialValue: leagueName,
            enabled: canEdit,
            decoration: const InputDecoration(
              labelText: 'League Name',
              border: OutlineInputBorder(),
            ),
            onChanged: (val) => leagueName = val,
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: logoUrl,
            enabled: canEdit,
            decoration: const InputDecoration(
              labelText: 'Logo URL',
              border: OutlineInputBorder(),
            ),
            onChanged: (val) => setState(() => logoUrl = val),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: sportLeague,
            enabled: false,
            decoration: const InputDecoration(
              labelText: 'Sport League',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: season,
            enabled: false,
            decoration: const InputDecoration(
              labelText: 'Season',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: startWeek,
            decoration: const InputDecoration(
              labelText: 'Start Week',
              border: OutlineInputBorder(),
            ),
            items: _weeks
                .map((w) => DropdownMenuItem(value: w, child: Text(w)))
                .toList(),
            onChanged: canEditAll
                ? (val) => setState(() => startWeek = val!)
                : null,
            disabledHint: Text(startWeek),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: endWeek,
            decoration: const InputDecoration(
              labelText: 'End Week',
              border: OutlineInputBorder(),
            ),
            items: _weeks
                .map((w) => DropdownMenuItem(value: w, child: Text(w)))
                .toList(),
            onChanged: canEditAll
                ? (val) => setState(() => endWeek = val!)
                : null,
            disabledHint: Text(endWeek),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: pickType,
            decoration: const InputDecoration(
              labelText: 'Pick Type',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Against the Spread',
                child: Text('Against the Spread'),
              ),
              DropdownMenuItem(
                value: 'Straight Up',
                child: Text('Straight Up'),
              ),
            ],
            onChanged: canEditAll
                ? (val) => setState(() => pickType = val!)
                : null,
            disabledHint: Text(pickType),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: picksPerWeek.toString(),
            enabled: canEditAll,
            decoration: const InputDecoration(
              labelText: 'Picks per Week',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) =>
                picksPerWeek = int.tryParse(val) ?? picksPerWeek,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: visibility,
            decoration: const InputDecoration(
              labelText: 'League Visibility',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Private', child: Text('Private')),
              DropdownMenuItem(value: 'Public', child: Text('Public')),
            ],
            onChanged: canEditAll
                ? (val) => setState(() => visibility = val!)
                : null,
            disabledHint: Text(visibility),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: leagueSize.toString(),
            enabled: canEditAll,
            decoration: const InputDecoration(
              labelText: 'League Size',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) => leagueSize = int.tryParse(val) ?? leagueSize,
          ),
          if (canEdit)
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings saved (mock)!')),
                  );
                },
                child: const Text('Save'),
              ),
            ),
        ],
      ),
    );
  }
}
