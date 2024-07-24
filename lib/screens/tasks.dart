import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:workshops_hackerrank/model/assignments.dart';
import 'package:workshops_hackerrank/widgets/assignment_cards.dart';
import 'package:workshops_hackerrank/widgets/search_bar.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final List<Assignment> _assignments = Assignment.getMockAssignment();
  List<Assignment> _filteredAssignments = [];
  String _searchQuery = '';
  bool? _showSubmitted;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _assignments.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    _filteredAssignments = _assignments;
  }

  void _filteredAssignmentsFunction() {
    List<Assignment> filteredList = _assignments;

    if(_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((assignment) => assignment.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    if(_showSubmitted != null) {
      filteredList = filteredList.where((assignment) => assignment.submitted == _showSubmitted).toList();
    }

    filteredList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    setState(() {
      _filteredAssignments = filteredList;
    });
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
      _filteredAssignmentsFunction();
    });
  }

  void _onFilterChange(bool? value) {
    setState(() {
      _showSubmitted = value;
      _filteredAssignmentsFunction();
    });
  }

  void _showAssignmentDetails(Assignment assignment) {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = assignment.notes;
    List<String> files = List.from(assignment.files);

    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assignment.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        assignment.content,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.75), fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          labelText: "Add a note",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00E861))
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                          )
                        ),
                        maxLines: null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          if (result != null) {
                            setState(() {
                              files.add(result.files.single.name);
                            });
                          }
                        },
                        child: const Text("Upload File"),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: files
                            .map((file) => ListTile(
                                  leading: const Icon(Icons.attachment),
                                  title: Text(
                                    file,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      setState(() {
        assignment.notes = textEditingController.text;
        assignment.files = files;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomSearchBar(onSearch: _onSearch),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Filter by Submission:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<bool?>(
                value: _showSubmitted,
                items: const [
                  DropdownMenuItem(value: null, child: Text("All"),),
                  DropdownMenuItem(value: true, child: Text("Submitted"),),
                  DropdownMenuItem(value: false, child: Text("Not Submitted"),),
                ],
                onChanged: _onFilterChange
                )
            ],
          ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: _filteredAssignments.length,
            itemBuilder: (context, index) {
              final assignment = _filteredAssignments[index];
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  AssignmentCards(
                    title: assignment.title,
                    content: assignment.content,
                    dueDate: assignment.dueDate,
                    submitted: assignment.submitted,
                    daysLeft: assignment.daysLeft,
                    onTapDetails: () => _showAssignmentDetails(assignment),
                    files: assignment.files,
                  ),
                ],
              );
            },
          )),
        ],
      ),
    );
  }
}
