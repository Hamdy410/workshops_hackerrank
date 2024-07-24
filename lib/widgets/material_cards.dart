import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workshops_hackerrank/constants/enums.dart';

class MaterialCards extends StatelessWidget {
  final String title;
  final List<String> materialItemsPaths;
  final VoidCallback onDelete;
  final UserType userType;

  const MaterialCards({
    super.key,
    required this.title,
    required this.materialItemsPaths,
    required this.onDelete,
    required this.userType,
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
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (userType == UserType.admin)
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                //TODO: Save and download
              },
              child: const Text("Download Items")),
          ...materialItemsPaths.map(
            (path) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Icon(
                      Icons.attach_file,
                      size: 20,
                      color: Color(0xFF00E861),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        path.split('/').last,
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
