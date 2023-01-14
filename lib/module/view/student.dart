// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Student welcomeFromJson(String str) => Student.fromJson(json.decode(str));

String welcomeToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    required this.id,
    required this.rollno,
    required this.name,
    required this.marks,
  });

  final String id;
  final int rollno;
  final String name;
  final int marks;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        rollno: json["rollno"],
        name: json["name"],
        marks: json["marks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rollno": rollno,
        "name": name,
        "marks": marks,
      };
}
