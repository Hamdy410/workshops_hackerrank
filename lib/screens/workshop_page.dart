import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class WorkshopPage extends StatefulWidget {
  const WorkshopPage({super.key});

  @override
  State<WorkshopPage> createState() => _WorkshopPageState();
}

class _WorkshopPageState extends State<WorkshopPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _sessionLengthController = TextEditingController();
  final _maxStudentController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _selectedInstructors = [];
  final List<String> _allInstructors = [
    "Alice",
    "Bob",
    "Charlie",
  ];

  Future<void> _pickDateRange(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: today,
      lastDate: DateTime(2100),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );

    if (pickedDateRange != null) {
      setState(() {
        _startDate = pickedDateRange.start;
        _endDate = pickedDateRange.end;
      });
    }
  }

  void _submitWorkshop() {
    if (_formKey.currentState!.validate()) {
      if (_startDate != null) {
        // TODO: Submit the details using the API
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Workshop "${_titleController.text}" created successfully'),
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please check your inputs"),
          ),
        );
      }
    }
  }

  void _addInstructor(String instructorName) {
    if (instructorName.isNotEmpty &&
        !_allInstructors.contains(instructorName)) {
      setState(() {
        _allInstructors.add(instructorName);
      });
    }
  }

  void _showAddInstructorDialog() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Instructor'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Instructor Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addInstructor(nameController.text.trim());
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showManageInstructorsDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Manage Instructors'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MultiSelectDialogField(
              items: _allInstructors.map((instructor) => MultiSelectItem<String>(instructor, instructor)).toList(),
              initialValue: _selectedInstructors,
              title: const Text("Select Instructors"),
              searchable: true,
              onConfirm: (values) {
                setState(() {
                  _selectedInstructors.clear();
                  _selectedInstructors.addAll(values);
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a Workshop"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Workshop Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: "Workshop Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _startDate == null
                          ? "Select Start and End Dates"
                          : "Start Date: ${DateFormat('d MMM yyyy').format(_startDate!)} - End Date: ${_endDate != null ? DateFormat('d MMM yyyy').format(_endDate!) : 'N/A'}",
                    ),
                  ),
                  TextButton(
                    onPressed: () => _pickDateRange(context),
                    child: const Text("Pick Date Range"),
                  ),
                ],
              ),
              TextFormField(
                controller: _sessionLengthController,
                decoration: const InputDecoration(
                    labelText: "Session Length (in hours)"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the session length";
                  }
                  if (int.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _maxStudentController,
                decoration:
                    const InputDecoration(labelText: "Max Number of Students"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the maximum number of students";
                  }
                  if (int.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                "Instructors:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: _selectedInstructors
                    .map((instructor) => Chip(
                          label: Text(instructor),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  ElevatedButton(
                    onPressed: _showManageInstructorsDialog,
                    child: const Text("Manage Instructors"),
                  ),
                  ElevatedButton(
                    onPressed: _showAddInstructorDialog,
                    child: const Text("Add New Instructor"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitWorkshop,
                child: const Text("Create Workshop"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
