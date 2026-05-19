import 'package:firebase_auth/firebase_auth.dart';

// دالة تسجيل الدخول المحدثة لتتعامل مع الفايربيز مباشرة بدلاً من PHP
Future<String> loginUser(String email, String password) async {
  try {
    // محاولة تسجيل الدخول عبر الفايربيز باستخدام البريد وكلمة المرور
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    // إذا نجحت العملية ووجدنا مستخدم، نُرجع كلمة Success لتفتح الصفحة الرئيسية
    if (userCredential.user != null) {
      return 'Success';
    } else {
      return 'Error';
    }
  } on FirebaseAuthException catch (e) {
    // في حال حدوث خطأ من الفايربيز (مثل كلمة مرور خاطئة أو حساب غير موجود)
    print("Firebase Auth Error: ${e.message}");
    return 'Error';
  } catch (e) {
    // لأي أخطاء عامة أخرى
    print("General Error: $e");
    return 'Error';
  }
}