import 'package:workshops_hackerrank/model/assignments.dart';
import 'package:workshops_hackerrank/models/material.dart';
import 'package:workshops_hackerrank/models/media_files.dart';

class Workshop {
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  List<String> days;
  Duration sessionLength;
  List<String> instructors;
  int numofStudents;
  List<Assignment> assignments;
  List<MaterialObj> materials;
  List<MediaFiles> mediaFiles;

  Workshop({
    required this.assignments,
    required this.days,
    required this.description,
    required this.endDate,
    required this.instructors,
    required this.materials,
    required this.mediaFiles,
    required this.numofStudents,
    required this.sessionLength,
    required this.startDate,
    required this.title
  });
}