import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    void openAdminPanel() {
      final password = passwordController.text.trim();
      if (password == 'admin123') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم الدخول إلى لوحة المعلم')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('كلمة المرور غير صحيحة')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('لوحة المعلم')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.admin_panel_settings_rounded, size: 68, color: Color(0xFF1B7A4A)),
            const SizedBox(height: 18),
            const Text(
              'تسجيل الدخول للمعلم',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: passwordController,
              obscureText: true,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: openAdminPanel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B7A4A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('دخول', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'ملاحظة: كلمة المرور الحالية هي مثال تجريبي وسيتم استبدالها بكلمة سر آمنة لاحقاً.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
