import 'package:flutter/material.dart';

class LeagueStandingsTab extends StatefulWidget {
  final String leagueId;
  const LeagueStandingsTab({super.key, required this.leagueId});

  @override
  State<LeagueStandingsTab> createState() => _LeagueStandingsTabState();
}

class _LeagueStandingsTabState extends State<LeagueStandingsTab> {
  int? _sortColumnIndex;
  bool _sortAscending = true;

  List<Map<String, dynamic>> standings = [
    {
      'rank': 1,
      'name': 'Sam Smith',
      'username': 'nflfan',
      'wins': 12,
      'losses': 4,
      'pushes': 2,
      'points': 13.0,
    },
    {
      'rank': 2,
      'name': 'Alex Johnson',
      'username': 'alexj',
      'wins': 10,
      'losses': 6,
      'pushes': 2,
      'points': 11.0,
    },
    {
      'rank': 3,
      'name': 'Taylor Lee',
      'username': 'tlee',
      'wins': 8,
      'losses': 8,
      'pushes': 2,
      'points': 9.0,
    },
  ];

  void _sort<T>(
    Comparable<T> Function(Map<String, dynamic> m) getField,
    int columnIndex,
  ) {
    setState(() {
      if (_sortColumnIndex == columnIndex) {
        _sortAscending = !_sortAscending;
      } else {
        _sortColumnIndex = columnIndex;
        _sortAscending = true;
      }
      standings.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return _sortAscending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      scrollDirection: Axis.horizontal,
      child: DataTable(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        columns: [
          DataColumn(
            label: _SortableHeader(
              'Name',
              sorted: _sortColumnIndex == 0,
              ascending: _sortAscending,
            ),
            onSort: (_, __) => _sort<String>((m) => m['name'], 0),
          ),
          DataColumn(
            label: _SortableHeader(
              'Rank',
              sorted: _sortColumnIndex == 1,
              ascending: _sortAscending,
            ),
            numeric: true,
            onSort: (_, __) => _sort<num>((m) => m['rank'], 1),
          ),
          DataColumn(
            label: _SortableHeader(
              'Points',
              sorted: _sortColumnIndex == 2,
              ascending: _sortAscending,
            ),
            numeric: true,
            onSort: (_, __) => _sort<num>((m) => m['points'], 2),
          ),
          DataColumn(
            label: _SortableHeader(
              'Wins',
              sorted: _sortColumnIndex == 3,
              ascending: _sortAscending,
            ),
            numeric: true,
            onSort: (_, __) => _sort<num>((m) => m['wins'], 3),
          ),
          DataColumn(
            label: _SortableHeader(
              'Losses',
              sorted: _sortColumnIndex == 4,
              ascending: _sortAscending,
            ),
            numeric: true,
            onSort: (_, __) => _sort<num>((m) => m['losses'], 4),
          ),
          DataColumn(
            label: _SortableHeader(
              'Pushes',
              sorted: _sortColumnIndex == 5,
              ascending: _sortAscending,
            ),
            numeric: true,
            onSort: (_, __) => _sort<num>((m) => m['pushes'], 5),
          ),
        ],
        rows: standings
            .map(
              (m) => DataRow(
                cells: [
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          m['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '@${m['username']}',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text(m['rank'].toString())),
                  DataCell(Text(m['points'].toString())),
                  DataCell(Text(m['wins'].toString())),
                  DataCell(Text(m['losses'].toString())),
                  DataCell(Text(m['pushes'].toString())),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SortableHeader extends StatelessWidget {
  final String label;
  final bool sorted;
  final bool ascending;
  const _SortableHeader(
    this.label, {
    this.sorted = false,
    this.ascending = true,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (!sorted) {
      icon = Icons.unfold_more;
    } else {
      icon = ascending ? Icons.arrow_upward : Icons.arrow_downward;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 4),
        Icon(icon, size: 16, color: Colors.grey),
      ],
    );
  }
}
