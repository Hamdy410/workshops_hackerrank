import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshops_hackerrank/constants/enums.dart';
import 'package:workshops_hackerrank/data/material.dart';
import 'package:workshops_hackerrank/models/user.dart';
import 'package:workshops_hackerrank/widgets/dotted_FAB.dart';
import 'package:workshops_hackerrank/widgets/material_cards.dart';
import 'package:workshops_hackerrank/widgets/search_bar.dart';

class Materials extends StatefulWidget {
  const Materials({super.key});

  @override
  State<Materials> createState() => _MaterialsState();
}

class _MaterialsState extends State<Materials> {
  final List<FilesMaterialItem> _materialList =
      FilesMaterialItem.getmockMaterial();
  List<FilesMaterialItem> _filteredMaterial = [];
  String searchQuery = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _materialList.sort((a, b) => a.title.compareTo(b.title));
    _filteredMaterial = _materialList;
  }

  void _filteredMaterialFunction() {
    List<FilesMaterialItem> filteredList = _materialList;

    if (searchQuery.isNotEmpty) {
      filteredList = filteredList
          .where((material) =>
              material.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    filteredList.sort((a, b) => a.title.compareTo(b.title));
    setState(() {
      _filteredMaterial = filteredList;
    });
  }

  void _onSearch(String query) {
    setState(() {
      searchQuery = query;
      _filteredMaterialFunction();
    });
  }

  Future<void> _showTitleInputDialog() async {
    String? title = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController titleController = TextEditingController();
        return AlertDialog(
          title: const Text("Enter title for the files"),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(titleController.text);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );

    if (title != null && title.isNotEmpty) {
      _pickFiles(title);
    }
  }

  Future<void> _pickFiles(String title) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      List<String> paths = result.paths.map((path) => path!).toList();
      setState(() {
        _materialList.add(FilesMaterialItem(title: title, assetPaths: paths));
        _filteredMaterialFunction();
      });
    }
  }

  void _deleteMaterialItem(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text("Are you sure you want to delete this item?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _materialList.removeAt(index);
                    _filteredMaterialFunction();
                  });
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("Delete"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<USER>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomSearchBar(onSearch: _onSearch),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredMaterial.length,
              itemBuilder: (context, index) {
                final material = _filteredMaterial[index];
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialCards(
                      title: material.title,
                      materialItemsPaths: material.assetPaths,
                      onDelete: () => _deleteMaterialItem(context, index),
                      userType: user.type,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: user.type == UserType.admin
          ? DottedFAB(
              icon: const Icon(
                Icons.add,
                size: 28,
              ),
              onPressed: _showTitleInputDialog,
              text: "Add",
            )
          : Container(),
    );
  }
}
