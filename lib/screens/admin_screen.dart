import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/code_generator.dart';
import '../services/pdf_manager.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final PdfManager _pdfManager = PdfManager();
  List<String> _codes = [];

  @override
  void initState() {
    super.initState();
    _loadCodes();
  }

  Future<void> _loadCodes() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('student_codes') ?? <String>[];
    setState(() {
      _codes = list;
    });
  }

  Future<void> _saveCodes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('student_codes', _codes);
  }

  void _generateCode() {
    final code = CodeGenerator.randomCode();
    setState(() {
      _codes.add(code);
    });
    _saveCodes();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم إنشاء الكود: $code')));
  }

  Future<void> _importPdf() async {
    final path = await _pdfManager.pickAndStoreEncryptedPdf();
    if (path != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم حفظ الملف المشفر:
$path')));
    }
  }

  void _tryLogin() {
    final pwd = _passwordController.text.trim();
    if (pwd == 'admin123') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('مرحباً, تم الدخول كمعلم')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('كلمة مرور خاطئة')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة المعلم')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              obscureText: true,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(labelText: 'كلمة المرور'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _tryLogin,
                    child: const Text('دخول'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _generateCode,
                    child: const Text('إنشاء كود جديد'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: _importPdf,
              icon: const Icon(Icons.upload_file),
              label: const Text('استيراد ملزم PDF (تشفيــر)'),
            ),
            const SizedBox(height: 18),
            const Text('قائمة الأكواد المنشأة:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _codes.length,
                itemBuilder: (context, index) {
                  final code = _codes[index];
                  return Card(
                    child: ListTile(
                      title: Text(code),
                      trailing: IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () async {
                          // نسخ الكود للحافظة
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم نسخ $code')));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
