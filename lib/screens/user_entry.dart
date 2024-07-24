import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshops_hackerrank/constants/enums.dart';
import 'package:workshops_hackerrank/models/user.dart';
import 'package:workshops_hackerrank/screens/workshop_page.dart';

class UserEntry extends StatelessWidget {
  const UserEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<USER>(
      builder: (context, value, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: UserType.values
                .toList()
                .map(
                  (e) => ElevatedButton(
                    onPressed: () {
                      value.changeType(e);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const WorkshopPage(),
                        ),
                      );
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      e.toString().split(".").last,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
