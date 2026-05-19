import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // مكتبة الفايربيز
import 'package:flutter_crud/tambahdata.dart';
import 'package:flutter_crud/editdata.dart'; // استدعاء صفحة التعديل المحدثة

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // دالة حذف البيانات من الفايربيز باستخدام الـ ID الخاص بالمستند
  Future<bool> _deletedata(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('students').doc(docId).delete();
      return true;
    } catch (e) {
      print("Error deleting document: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      // استخدام StreamBuilder لجلب البيانات وتحديث الشاشة تلقائياً
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("حدث خطأ ما في جلب البيانات"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // تحويل البيانات القادمة من الفايربيز إلى قائمة
          final data = snapshot.data!.docs;

          if (data.isEmpty) {
            return const Center(child: Text("لا توجد بيانات حالياً"));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              // جلب المستند الحالي والبيانات التي بداخله
              DocumentSnapshot doc = data[index];
              Map<String, dynamic> student = doc.data() as Map<String, dynamic>;

              return Card(
                child: ListTile(
                  onTap: () {
                    // عند الضغط على الكرت ننتقل لصفحة التعديل ونرسل البيانات مع الـ ID الصحيح
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditDataPage(
                          documentId: doc.id,
                          currentData: student,
                        ),
                      ),
                    );
                  },
                  title: Text(student['nama'] ?? ''),
                  subtitle: Text(student['alamat'] ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // إظهار صندوق تأكيد الحذف
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Hapus Data"),
                          content: const Text("Apakah anda yakin menghapus data ini?"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                _deletedata(doc.id).then((success) {
                                  Navigator.of(context).pop(); // إغلاق الصندوق
                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Data Berhasil Di hapus")),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Gagal hapus data")),
                                    );
                                  }
                                });
                              },
                              child: const Text("Ya"),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Tidak"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahData()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}