import 'package:flutter/material.dart';
import 'package:workshops_hackerrank/constants/enums.dart';

class USER extends ChangeNotifier {
  String id;
  String name;
  String email;
  UserType type;
  int role;

  USER(
    {
      this.id = "",
      this.name = "",
      this.email = "",
      this.type = UserType.member,
      this.role = 10
    }
  );

  void changeType(UserType newType)
  {
    type = newType;
    notifyListeners();
  }
}