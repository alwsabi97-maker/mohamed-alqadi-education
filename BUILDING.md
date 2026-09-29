# تعليمات البناء والنشر

هذا الملف يشرح خطوات بناء الـAPK التجريبي من المشروع المحلي.

1) تثبيت Flutter وتهيئة بيئة Android (Android SDK وAndroid Studio)
2) افتح المشروع في محرر النصوص أو Android Studio
3) جلب الحزم:
   flutter pub get
4) بناء إصدار الـAPK التجريبي (غير موقّع بمفتاحك الخاص):
   flutter build apk --release

ملف الـAPK سيكون في:
build/app/outputs/flutter-apk/app-release.apk

ملاحظة أمان:
- الإصدار الحالي يستخدم توقيع تجريبي عند بناءه هنا؛ لترقيات مستقبلية من الأفضل أن تستخدم keystore خاص بك وتوقّعه بنفس المفتاح.
