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
                onPressed: () {},
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
