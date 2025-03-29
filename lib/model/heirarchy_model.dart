class UserDetails {
  final String empCode;
  final String empName;
  final String reportingTo;
  final int? Depth; // Changed to lowercase to follow Dart conventions
  final String designation;
  bool isCheck; // Represents if the user is checked
  Future<List<UserDetails>>? reports; // Optional, to hold sub-reports

  UserDetails({
    required this.empCode,
    required this.empName,
    required this.reportingTo,
    required this.designation,
    this.Depth,
    this.reports,
    this.isCheck = false, // Default value
  });

  Map<String, dynamic> toMap() {
    return {
      'EmpCode': empCode,
      'Depth': Depth,
      'EmpName': empName,
      'ReportTo': reportingTo,
      'EmpDesignation': designation,
      'is_check': isCheck, // Map the isChecked field
    };
  }

  // Factory method to create UserDetails from a Map
  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      empCode: map['EmpCode'],
      empName: map['EmpName'],
      reportingTo: map['ReportTo'],
      designation: map['EmpDesignation'],
      Depth: map['Depth'],
      isCheck: map['is_check'] == 1, // Assuming is_check is stored as an integer
    );
  }
}
