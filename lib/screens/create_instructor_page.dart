import 'package:flutter/material.dart';

class CreateInstructorPage extends StatelessWidget {
  final TextEditingController _newInstructorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Instructor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newInstructorController,
              decoration: const InputDecoration(labelText: "Instructor Name"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String newInstructor = _newInstructorController.text.trim();
                if (newInstructor.isNotEmpty) {
                  Navigator.of(context).pop(newInstructor);
                }
              },
              child: const Text("Create Instructor"),
            ),
          ],
        ),
      ),
    );
  }
}
