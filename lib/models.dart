class SubjectItem {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;

  const SubjectItem({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class QuestionItem {
  final String id;
  final String subject;
  final String grade;
  final String text;
  final List<String> options;
  final int correctIndex;

  const QuestionItem({
    required this.id,
    required this.subject,
    required this.grade,
    required this.text,
    required this.options,
    required this.correctIndex,
  });
}

class StudentResult {
  final String studentName;
  final String subject;
  final String grade;
  final int score;
  final int total;
  final DateTime date;

  const StudentResult({
    required this.studentName,
    required this.subject,
    required this.grade,
    required this.score,
    required this.total,
    required this.date,
  });
}
