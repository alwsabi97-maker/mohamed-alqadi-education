import 'package:flutter/material.dart';

class AboutTeacherScreen extends StatelessWidget {
  const AboutTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عن الأستاذ')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 72,
              backgroundColor: Color(0xFF1B7A4A),
              child: Icon(Icons.person, size: 68, color: Colors.white),
            ),
            const SizedBox(height: 18),
            const Text(
              'الأستاذ محمد القاضي',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'أستاذ الكيمياء والفيزياء والأحياء بمدرسة النور الأساسية الثانوية بالروحاء - وصاب السافل',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 18),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('نبذة:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(
                      'أهتم بتبسيط العلوم، تنمية مهارات الطلاب، وتوظيف التقنية في التعليم لتسهيل الوصول إلى ��لمعرفة ورفع جودة التعلم.',
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 12),
                    Text('المؤهلات:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('بكالوريوس تربية تخصص كيمياء فيزيائية', textAlign: TextAlign.right),
                    SizedBox(height: 12),
                    Text('الهاتف: 774470090', textAlign: TextAlign.right),
                    SizedBox(height: 8),
                    Text('البريد الإلكتروني: alwsabi97@gmail.com', textAlign: TextAlign.right),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
