import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models.dart';
import 'about_teacher_screen.dart';
import 'admin_screen.dart';
import 'exam_screen.dart';
import 'results_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.studentName = 'الطالب', this.studentCode = '---'});

  final String studentName;
  final String studentCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutTeacherScreen()),
              );
            },
            icon: const Icon(Icons.account_circle_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFF1B7A4A),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            studentName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('الكود: $studentCode'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'المواد الدراسية',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: AppData.subjects.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final subject = AppData.subjects[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubjectScreen(subject: subject),
                        ),
                      );
                    },
                    child: Card(
                      color: subject.color.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(subject.icon, size: 42, color: subject.color),
                            const SizedBox(height: 12),
                            Text(
                              subject.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              subject.subtitle,
                              style: const TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ResultsScreen()),
                      );
                    },
                    icon: const Icon(Icons.bar_chart_rounded),
                    label: const Text('درجاتي'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AdminScreen()),
                      );
                    },
                    icon: const Icon(Icons.lock),
                    label: const Text('إدارة'),
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

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key, required this.subject});

  final SubjectItem subject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subject.name)),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(subject.icon, size: 34, color: subject.color),
                        const SizedBox(width: 12),
                        Text(
                          subject.name,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'سنقوم بإضافة الملزم وقائمة الكتب والاختبارات الخاصة بهذه المادة لاحقاً من لوحة المعلم.',
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  final questions = AppData.questions
                      .where((q) => q.subject == subject.name)
                      .toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ExamScreen(
                        subject: subject.name,
                        questions: questions,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.quiz_rounded),
                label: const Text('ابدأ الاختبار'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
