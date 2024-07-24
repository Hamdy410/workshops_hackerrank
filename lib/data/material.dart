class FilesMaterialItem {
  final String title;
  final List<String> assetPaths;

  FilesMaterialItem({required this.title, required this.assetPaths});

  static List<FilesMaterialItem> getmockMaterial() {
    return [
      FilesMaterialItem(title: "Session 1", assetPaths: ["assets/profile_image/madgwick_internal_report.pdf"]),
      FilesMaterialItem(title: "Session 2", assetPaths: ["assets/profile_image/madgwick_internal_report.pdf", "assets/profile_image/madgwick_internal_report.pdf"]),
      FilesMaterialItem(title: "Session 3", assetPaths: ["assets/profile_image/madgwick_internal_report.pdf", "assets/profile_image/madgwick_internal_report.pdf", "assets/profile_image/madgwick_internal_report.pdf"])
    ];
  }
}
