class NonproCustomer {
  int customerCustCode;
  String customerCustName;
  String customerCustPhone;
  int nonProductiveCust;
  double lat;
  double long;

  NonproCustomer({
    required this.customerCustCode,
    required this.customerCustName,
    required this.customerCustPhone,
    required this.nonProductiveCust,
    required this.lat,
    required this.long
  });


  factory NonproCustomer.fromJson(Map<String, dynamic> json) {
    return NonproCustomer(
      customerCustCode: json['Customer_Cust_Code'],
      customerCustName: json['Customer_Cust_Name'],
      customerCustPhone: json['Customer_Cust_Phone'],
      nonProductiveCust: json['Non_Productive_Cust'],
      lat: json['Customer_Cust_Latt'],
      long: json['Customer_Cust_Long']
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'Customer_Cust_Code': customerCustCode,
      'Customer_Cust_Name': customerCustName,
      'Customer_Cust_Phone': customerCustPhone,
      'Non_Productive_Cust': nonProductiveCust,
      'Customer_Cust_Latt':lat,
      "Customer_Cust_Long":long
    };
  }
}
