class MockUser {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String? avatarUrl;

  MockUser({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
  });
}

class MockLeague {
  final String id;
  final String name;
  final String? logoUrl;
  final String pickType;
  final String sportLeague;

  MockLeague({
    required this.id,
    required this.name,
    this.logoUrl,
    required this.pickType,
    required this.sportLeague,
  });
}

class MockInvite {
  final String id;
  final String leagueName;
  final String inviterName;

  MockInvite({
    required this.id,
    required this.leagueName,
    required this.inviterName,
  });
}

final mockUser = MockUser(
  id: '1',
  username: 'nflfan',
  firstName: 'Sam',
  lastName: 'Smith',
  avatarUrl: null,
);

final mockLeagues = [
  MockLeague(
    id: 'l1',
    name: 'Sunday Sharps',
    logoUrl: null,
    pickType: 'Against the Spread',
    sportLeague: 'NFL',
  ),
  MockLeague(
    id: 'l2',
    name: 'Monday Moneyline',
    logoUrl: null,
    pickType: 'Straight Up',
    sportLeague: 'NFL',
  ),
];

final mockInvites = [
  MockInvite(
    id: 'i1',
    leagueName: 'Thursday Throwdown',
    inviterName: 'Alex Johnson',
  ),
];
