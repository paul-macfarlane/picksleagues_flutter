import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _avatarUrlController;
  String _timezone = 'America/New_York';

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: mockUser.username);
    _firstNameController = TextEditingController(text: mockUser.firstName);
    _lastNameController = TextEditingController(text: mockUser.lastName);
    _avatarUrlController = TextEditingController(
      text: mockUser.avatarUrl ?? '',
    );
    _timezone = 'America/New_York';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    // Mock save
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Profile saved (mock)!')));
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final avatarUrl = _avatarUrlController.text.trim();
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).colorScheme.primary,
                backgroundImage: avatarUrl.isNotEmpty
                    ? NetworkImage(avatarUrl)
                    : null,
                child: avatarUrl.isEmpty
                    ? Text(
                        _firstNameController.text.isNotEmpty
                            ? _firstNameController.text[0]
                            : '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                helperText: '8-20 characters',
              ),
              maxLength: 20,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _avatarUrlController,
              decoration: const InputDecoration(
                labelText: 'Profile Picture URL',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _timezone,
              decoration: const InputDecoration(
                labelText: 'Time Zone',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'America/New_York',
                  child: Text('America/New_York'),
                ),
                DropdownMenuItem(
                  value: 'America/Chicago',
                  child: Text('America/Chicago'),
                ),
                DropdownMenuItem(
                  value: 'America/Denver',
                  child: Text('America/Denver'),
                ),
                DropdownMenuItem(
                  value: 'America/Los_Angeles',
                  child: Text('America/Los_Angeles'),
                ),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _timezone = val);
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
                    onPressed: _saveProfile,
                    child: const Text('Save'),
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
