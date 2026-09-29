import 'package:flutter/material.dart';

import '../models.dart';

class AppData {
  static const List<SubjectItem> subjects = [
    SubjectItem(
      name: 'الكيمياء',
      subtitle: 'ملاحظات، اختبارات، ومفاهيم علمية',
      icon: Icons.science,
      color: Color(0xFF1B7A4A),
    ),
    SubjectItem(
      name: 'الفيزياء',
      subtitle: 'نظرية، مسائل، وحلول',
      icon: Icons.bolt,
      color: Color(0xFF0E6D8F),
    ),
    SubjectItem(
      name: 'الأحياء',
      subtitle: 'مفاهيم، بكتيريا، خلية، وتطبيقات',
      icon: Icons.biotech,
      color: Color(0xFF8E5E26),
    ),
  ];

  static const List<QuestionItem> questions = [
    QuestionItem(
      id: '1',
      subject: 'الكيمياء',
      grade: 'الثالث الثانوي',
      text: 'ما هو العنصر الذي يرمز إليه بالحرف H؟',
      options: ['النيتروجين', 'الهيدروجين', 'الأكسجين', 'الكربون'],
      correctIndex: 1,
    ),
    QuestionItem(
      id: '2',
      subject: 'الكيمياء',
      grade: 'الثالث الثانوي',
      text: 'أي من التالية يعدّ قاعدة؟',
      options: ['HCl', 'NaOH', 'H2O', 'CO2'],
      correctIndex: 1,
    ),
    QuestionItem(
      id: '3',
      subject: 'الفيزياء',
      grade: 'الثاني الثانوي',
      text: 'ما وحدة قياس القوة؟',
      options: ['جول', 'نيوتن', 'متر', 'امبير'],
      correctIndex: 1,
    ),
    QuestionItem(
      id: '4',
      subject: 'الأحياء',
      grade: 'الأول الثانوي',
      text: 'ما الخلية المسؤولة عن نقل الأكسجين؟',
      options: ['خلايا الدم البيضاء', 'خلايا الدم الحمراء', 'الخلايا العصبية', 'خلايا الجلد'],
      correctIndex: 1,
    ),
    QuestionItem(
      id: '5',
      subject: 'الفيزياء',
      grade: 'الثالث الثانوي',
      text: 'ما العلاقة بين السرعة والجهد في الدائرة الكهربائية؟',
      options: ['العكس', 'الإضافة', 'التساوي', 'لا يوجد'],
      correctIndex: 0,
    ),
  ];
}
