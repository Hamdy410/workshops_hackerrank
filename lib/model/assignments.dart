class Assignment {
  final String title;
  final String content;
  final DateTime dueDate;
  final bool submitted;
  final List<String> paths;
  String notes;
  List<String> files;

  int get daysLeft => calculateDaysLeft(dueDate);

  Assignment({required this.content, required this.dueDate, this.files = const [], this.notes = '', required this.paths, required this.submitted, required this.title});

  int calculateDaysLeft(DateTime dueDate) {
    final currentDate = DateTime.now();
    final difference = dueDate.difference(currentDate).inDays;
    return difference;
  }

  static List<Assignment> getMockAssignment() {
    return [
      Assignment(
          title: "Assignment 1",
          content: "This is the content of Assignment 1",
          dueDate: DateTime.now().add(const Duration(days: 12)),
          submitted: false,
          paths: [],
          ),
      Assignment(
        title: 'Assignment 2',
        content: 'This is the content of assignment 2.',
        dueDate: DateTime.now().add(const Duration(days: 1)),
        submitted: true,
        paths: []
      ),
      Assignment(
        title: 'Assignment 3',
        content: 'This is the content of assignment 3. It is also longer than 50 characters and should be truncated with an ellipsis.',
        dueDate: DateTime.now().add(const Duration(days: 5)),
        submitted: false,
        paths: []
      ),
      Assignment(
        title: 'Assignment 4',
        content: 'This is the content of assignment 4. It is also longer than 50 characters and should be truncated with an ellipsis.',
        dueDate: DateTime.now().add(const Duration(days: 60)),
        submitted: false,
        paths: []
      ),
      Assignment(
        title: 'Assignment 5',
        content: 'This is the content of assignment 5.',
        dueDate: DateTime.now().add(const Duration(days: 12)),
        submitted: false,
        paths: []
      ),
      Assignment(
        title: "Final Project",
        content: "Teams: \n1- Daiana , Hana => IT committee module\n2- maram , jana , gehad  => media Committee\n3- marwan , hamdy => HR Committee\n4- yahia , abdulah => Oc Committee\n5- yasmine , lobna , mariam => Scientific Committee module\n\nDetails:\n - every team will create a repository on github and make there module and avoiding merge conflict.\n - at the end we will make a folder for every team in the main repository to push work on it \n - backend will be done and we will only work with APIs \n - State Managment with Provider.\n - Colors will be same in Logo (black,green,white).\n\nApplication Structure:\nLogin, signUp ,forgetPassword\nUnregistered User side (for non-members to make them able to see application without login but they will not take any action) =>\n - home screen contains an overview for hackerrank , committees screen to view committees available and how to apply.\n - and material screen for all subjects (to replace the bot we made on telegram)\n - register to committees form \nUser Side:\nIT Committee Module => members List , tasks submmesions , download and view session materials , raodmaps for many fields (mainly flutter)\nScientific Committee => members List , tasks submessions ,download and view session materials\nmedia Committee => members List , tasks submmesions , download and view materials , control an feedback screen and social media posts\nPR committee => members List , tasks submmesions , download and view materials , screen for done deals and voting for upcoming deals \nOc Committe =>  members List , tasks submmesions , download and view materials , Calendar that contains all sessions dates and events , screen to make the oc members list there ideas for sessions as games planned or any creative thoughts\nHR committee =>  members List , tasks submmesions , download and view materials , having access on all members in any committee to assess and add member or remove (but first it needs the admin approval !!!) ,  reviews screen to make the hr member able to give the head of any committee all the notes about any session",
        dueDate: DateTime.now().add(const Duration(days: 11)),
        submitted: false,
        paths: []
      )
    ];
  }
}