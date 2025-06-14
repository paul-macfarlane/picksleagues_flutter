import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateLeaguePage extends StatefulWidget {
  const CreateLeaguePage({super.key});

  @override
  State<CreateLeaguePage> createState() => _CreateLeaguePageState();
}

class _CreateLeaguePageState extends State<CreateLeaguePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _logoUrlController = TextEditingController();
  String _sportsLeague = 'NFL';
  String _season = '2024';
  String _startWeek = 'Week 1';
  String _endWeek = 'Week 18';
  String _pickType = 'Against the Spread';
  int _picksPerWeek = 1;
  String _visibility = 'Private';
  int _leagueSize = 10;

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

  @override
  void dispose() {
    _nameController.dispose();
    _logoUrlController.dispose();
    super.dispose();
  }

  void _createLeague() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('League created (mock)!')));
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final logoUrl = _logoUrlController.text.trim();
    return Scaffold(
      appBar: AppBar(title: const Text('Create League')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
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
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'League Name',
                  border: OutlineInputBorder(),
                  helperText: 'Max 32 characters',
                ),
                maxLength: 32,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Enter a league name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _logoUrlController,
                decoration: const InputDecoration(
                  labelText: 'Logo URL',
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _sportsLeague,
                decoration: const InputDecoration(
                  labelText: 'Sports League',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'NFL', child: Text('NFL')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _sportsLeague = val);
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _season,
                decoration: const InputDecoration(
                  labelText: 'Season',
                  border: OutlineInputBorder(),
                ),
                items: _seasons
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _season = val);
                },
              ),
              const SizedBox(height: 16),
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
                          .map(
                            (w) => DropdownMenuItem(value: w, child: Text(w)),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _startWeek = val);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _endWeek,
                      decoration: const InputDecoration(
                        labelText: 'End Week',
                        border: OutlineInputBorder(),
                      ),
                      items: _weeks
                          .map(
                            (w) => DropdownMenuItem(value: w, child: Text(w)),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _endWeek = val);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _pickType,
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
                onChanged: (val) {
                  if (val != null) setState(() => _pickType = val);
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _picksPerWeek.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Picks per Week',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        final n = int.tryParse(val);
                        if (n != null && n >= 1 && n <= 16) {
                          setState(() => _picksPerWeek = n);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      initialValue: _leagueSize.toString(),
                      decoration: const InputDecoration(
                        labelText: 'League Size',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        final n = int.tryParse(val);
                        if (n != null && n >= 1 && n <= 20) {
                          setState(() => _leagueSize = n);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _visibility,
                decoration: const InputDecoration(
                  labelText: 'League Visibility',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Private', child: Text('Private')),
                  DropdownMenuItem(value: 'Public', child: Text('Public')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _visibility = val);
                },
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.go('/home'),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _createLeague,
                      child: const Text('Create'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
