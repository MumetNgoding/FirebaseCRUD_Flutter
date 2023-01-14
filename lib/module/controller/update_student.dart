import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fhe_template/homepage.dart';
import 'package:fhe_template/module/view/student.dart';
import 'package:flutter/material.dart';

class UpdateStudent extends StatelessWidget {
  UpdateStudent({super.key, required this.student});

  final TextEditingController rollController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController marksController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final Student student;

  //get hintText => "Input Roll number";

  @override
  Widget build(BuildContext context) {
    rollController.text = '${student.rollno}';
    nameController.text = student.name;
    marksController.text = '${student.marks}';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          getMyField(
              focusNode: focusNode,
              hintText: "Rollno",
              textInputType: TextInputType.number,
              controller: rollController),
          getMyField(hintText: "Name", controller: nameController),
          getMyField(
              hintText: "Marks",
              textInputType: TextInputType.number,
              controller: marksController),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                // update student on pressed back to homepage
                onPressed: () {
                  Student updateStudent = Student(
                      id: student.id,
                      rollno: int.parse(rollController.text),
                      name: nameController.text,
                      marks: double.parse(marksController.text));
                  final CollectionReference =
                      FirebaseFirestore.instance.collection('students');
                  CollectionReference.doc(updateStudent.id)
                      .update(updateStudent.toJson())
                      .whenComplete(() {
                    log('Student Update');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => homepage()),
                    );
                  });
                },
                child: const Text("Update"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () {
                  rollController.text = '';
                  nameController.text = '';
                  marksController.text = '';
                  focusNode.requestFocus();
                },
                child: const Text("Clear"),
              ),
            ],
          )
        ],
      )),
    );
  }

  //String hintText = "Enter your name";
  Widget getMyField(
      {required String hintText,
      TextInputType textInputType = TextInputType.name,
      required TextEditingController controller,
      FocusNode? focusNode}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
            hintText: "Enter $hintText",
            labelText: hintText,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
      ),
    );
  }
}
