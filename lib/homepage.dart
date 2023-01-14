import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fhe_template/module/controller/add_student.dart';
import 'package:fhe_template/module/controller/update_student.dart';
import 'package:flutter/material.dart';

import 'module/view/student.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  // List<Student> students = [
  //   Student(id: 'id', rollno: 1, name: 'Name 1', marks: 32),
  //   Student(id: 'id', rollno: 1, name: 'Name 2', marks: 36),
  //   Student(id: 'id', rollno: 1, name: 'Name 3', marks: 82)
  // ];

  @override
  Widget build(BuildContext context) {
    final CollectionReference reference =
        FirebaseFirestore.instance.collection('students');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase CRUD"),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: reference.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('something when wrong'),
            );
          }
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            List<Student> students = documents
                .map((e) => Student(
                    id: e['id'],
                    rollno: e['rollno'],
                    name: e['name'],
                    marks: e['marks']))
                .toList();
            return _getBody(students);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        //child: _getBody()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddStudent(),
              ));
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget _getBody(students) {
  final CollectionReference reference =
      FirebaseFirestore.instance.collection('students');
  return students.isEmpty
      ? const Center(
          child: Text(
            "No Data Found, Please Create",
            textAlign: TextAlign.center,
          ),
        )
      : ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) => Card(
            color: students[index].marks < 33
                ? Colors.greenAccent
                : students[index].marks < 65
                    ? Colors.blueAccent
                    : Colors.cyanAccent,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue,
                    child: Text('${students[index].marks}'),
                  ),
                  title: Text(students[index].name),
                  subtitle: Text('Rollno: ${students[index].rollno}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdateStudent(student: students[index])),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 24.0,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          reference.doc(students[index].id).delete();
                          // refresh if remove
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => homepage()),
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 24.0,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
}
