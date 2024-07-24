import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignmentCards extends StatelessWidget {
  final String title;
  final String content;
  final DateTime dueDate;
  final bool submitted;
  final int daysLeft;
  final VoidCallback onTapDetails;
  final List<String> files;
  const AssignmentCards(
      {super.key,
      required this.title,
      required this.content,
      required this.dueDate,
      required this.submitted,
      required this.daysLeft, required this.onTapDetails, required this.files,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(content.length > 50
                        ? '${content.substring(0, 50)}...'
                        : content, style: TextStyle(color: Colors.black.withOpacity(0.75)),),
                    const SizedBox(height: 10,),
                    RichText(
                      text: submitted
                          ? const TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(1),
                                    child: Icon(
                                      Icons.check_circle,
                                      color: Colors.grey,
                                      size: 13,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Submitted',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                          : TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "$daysLeft days left",
                                      style: const TextStyle(
                                          color: Color(0xFF00E861),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8,),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  DateFormat('d MMM').format(dueDate),
                  style: const TextStyle(
                    color: Color(0xFF00E861),
                    fontSize: 23,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
          TextButton(onPressed: onTapDetails, child: const Text("Task Details")),
                    const SizedBox(height: 10,),
                    ...files.map((file) => ListTile(
                      leading: const Icon(Icons.attachment),
                      title: Text(file),
                    )),
        ],
      ),
    );
  }
}
