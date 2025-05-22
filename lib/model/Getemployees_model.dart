class ErpEmployee {
  final String name;
  final String oldCode;
  final String designation;
  final String branch;

  ErpEmployee({
    required this.name,
    required this.oldCode,
    required this.designation,
    required this.branch,
  });

  factory ErpEmployee.fromJson(Map<String, dynamic> json) {
    return ErpEmployee(
      name: json['name'] ?? '',
      oldCode: json['oldCode'] ?? '',
      designation: json['designation'] ?? '',
      branch: json['branch'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'oldCode': oldCode,
      'designation': designation,
      'branch': branch,
    };
  }
}
