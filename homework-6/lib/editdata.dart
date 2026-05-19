import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter_crud/homepage.dart';

class EditDataPage extends StatefulWidget {
  final String documentId; // لاستقبال الـ ID من الـ HomePage المحدثة
  final Map<String, dynamic> currentData; // لاستقبال البيانات الحالية من الـ HomePage

  const EditDataPage({
    Key? key,
    required this.documentId,
    required this.currentData,
  }) : super(key: key);

  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nisn = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();

  @override
  void initState() {
    super.initState();
    // تعبئة النصوص بالبيانات الحالية مرة واحدة عند تشغيل الصفحة
    nisn.text = widget.currentData['nisn'] ?? '';
    nama.text = widget.currentData['nama'] ?? '';
    alamat.text = widget.currentData['alamat'] ?? '';
  }

  // دالة التحديث في الفايربيز
  Future<bool> _update() async {
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(widget.documentId)
          .update({
        "nisn": nisn.text,
        "nama": nama.text,
        "alamat": alamat.text,
      });
      return true;
    } catch (e) {
      print("Error updating data: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Data"),
      ),
      body: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: nisn,
                decoration: const InputDecoration(
                  labelText: "Nisn",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nisn tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: nama,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: alamat,
                decoration: const InputDecoration(
                  labelText: "Alamat",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Alamat tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    _update().then((value) {
                      if (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Data Berhasil Di update")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Gagal update data")),
                        );
                      }
                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: ((context) => const HomePage())),
                      (route) => false,
                    );
                  }
                },
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}