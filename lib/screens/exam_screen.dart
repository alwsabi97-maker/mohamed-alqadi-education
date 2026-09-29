import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/app_data.dart';
import '../models.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key, required this.subject, required this.questions});

  final String subject;
  final List<QuestionItem> questions;

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final Map<int, int> _selectedAnswers = {};

  void _finishExam() {
    int correct = 0;
    for (var i = 0; i < widget.questions.length; i++) {
      final selected = _selectedAnswers[i];
      if (selected != null && selected == widget.questions[i].correctIndex) {
        correct++;
      }
    }

    final total = widget.questions.length;
    final result = '$correct/$total';

    _saveResult(result);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultsScreen(resultText: result, subject: widget.subject),
      ),
    );
  }

  Future<void> _saveResult(String resultText) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList('results') ?? <String>[];
    final entry = '${DateTime.now().toIso8601String()}|${widget.subject}|$resultText';
    existing.add(entry);
    await prefs.setStringList('results', existing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.subject)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: widget.questions.length + 1,
            itemBuilder: (context, index) {
              if (index == widget.questions.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 28),
                  child: ElevatedButton(
                    onPressed: _finishExam,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B7A4A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    child: const Text('إنهاء الاختبار', style: TextStyle(fontSize: 18)),
                  ),
                );
              }

              final q = widget.questions[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'السؤال ${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        q.text,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 14),
                      ...q.options.asMap().entries.map((entry) {
                        final optionIndex = entry.key;
                        final optionText = entry.value;
                        final isSelected = _selectedAnswers[index] == optionIndex;
                        return RadioListTile<int>(
                          title: Text(optionText, textAlign: TextAlign.right),
                          value: optionIndex,
                          groupValue: _selectedAnswers[index],
                          onChanged: (value) {
                            setState(() {
                              _selectedAnswers[index] = value ?? 0;
                            });
                          },
                          activeColor: const Color(0xFF1B7A4A),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
