import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key, this.resultText, this.subject});

  final String? resultText;
  final String? subject;

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<String> _history = <String>[];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('results') ?? <String>[];
    setState(() {
      _history = data.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultText = widget.resultText ?? 'لا توجد نتائج حتى الآن';
    final subjectText = widget.subject ?? 'النتائج';

    return Scaffold(
      appBar: AppBar(title: const Text('النتائج')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(Icons.check_circle, size: 64, color: Color(0xFF1B7A4A)),
                    const SizedBox(height: 12),
                    Text(
                      'النتيجة الحالية',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$subjectText: $resultText',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'سجل نتائجك',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (_history.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text('لا توجد نتائج مسجلة بعد.'),
                ),
              )
            else
              ..._history.map((entry) {
                final parts = entry.split('|');
                final date = parts.isNotEmpty ? parts[0] : '';
                final subject = parts.length > 1 ? parts[1] : 'مادة';
                final result = parts.length > 2 ? parts[2] : '0/0';
                return Card(
                  child: ListTile(
                    title: Text('المادة: $subject'),
                    subtitle: Text('النتيجة: $result'),
                    trailing: Text(date.substring(0, 10)),
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
