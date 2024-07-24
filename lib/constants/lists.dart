import 'package:workshops_hackerrank/constants/enums.dart';

const Set<String> adminView = {
  "Tasks",
  "Material",
  "News",
};

const Set<String> memberView = {
  "Tasks",
  "Material"
  "News"
};

const Set<String> guestView = {
  "News"
};

Set<String> getView(UserType type)
{
  switch (type) {
    case UserType.admin:
      return adminView;
    case UserType.member:
      return memberView;
  }
}
