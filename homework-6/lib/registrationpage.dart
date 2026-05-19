import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> registerUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Success'),
          content: const Text('Your registration was successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // إغلاق الصندوق التنبيهي
                Navigator.pop(context); // الرجوع التلقائي لصفحة الـ Login بدون أخطاء
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Error'),
          content: Text(e.message ?? 'حدث خطأ ما'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                if (email.isNotEmpty && password.isNotEmpty) {
                  await registerUser(email, password);
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}