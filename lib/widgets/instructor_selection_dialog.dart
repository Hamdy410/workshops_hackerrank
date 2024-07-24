import 'package:flutter/material.dart';

class InstructorSelectionDialog extends StatefulWidget {
  final List<String> allInstructors;
  final List<String> selectedInstructors;
  final Function(List<String>) onSelectionChanged;

  const InstructorSelectionDialog({
    required this.allInstructors,
    required this.selectedInstructors,
    required this.onSelectionChanged,
    Key? key,
  }) : super(key: key);

  @override
  _InstructorSelectionDialogState createState() => _InstructorSelectionDialogState();
}

class _InstructorSelectionDialogState extends State<InstructorSelectionDialog> {
  List<String> _filteredInstructors = [];
  final List<String> _tempSelectedInstructors = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredInstructors = widget.allInstructors;
    _tempSelectedInstructors.addAll(widget.selectedInstructors);
  }

  void _filterInstructors(String query) {
    setState(() {
      _filteredInstructors = widget.allInstructors
          .where((instructor) => instructor.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Instructors'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(labelText: 'Search Instructors'),
              onChanged: _filterInstructors,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  shrinkWrap: true, // Add this line
                  itemCount: _filteredInstructors.length,
                  itemBuilder: (context, index) {
                    final instructor = _filteredInstructors[index];
                    final isSelected = _tempSelectedInstructors.contains(instructor);
                    return CheckboxListTile(
                      title: Text(instructor),
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _tempSelectedInstructors.add(instructor);
                          } else {
                            _tempSelectedInstructors.remove(instructor);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onSelectionChanged(_tempSelectedInstructors);
            Navigator.of(context).pop();
          },
          child: const Text('Done'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
