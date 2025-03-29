class DsfMeasureModel {
  final int dsfDsfCode;
  final String dsfDsfName;
  final int? Non_Productive_Customers;
  final String dsfSafBusinessLine;
  final int safCustomer;
  final int? productiveCustomer; // Default value will be set
  final String ecoPercentage;
  final int? firstOrder;
  final int? lastOrder;
  final int duration; // Default value will be set
  final int orderQuantity; // Default value will be set
  final double orderValue; // Default value will be set
  final double avgValuePerBill; // Default value will be set
  final double avgSkuPerBill; // Default value will be set
  final int DSFTargetDaysDSFRemaining; // Default value will be set
  final int DSFTargetDaysDSFWorked; // Default value will be set
  final String DSFTarget;
  final double DSFTarget_Remaining; // Default value will be set
  final double DSFTarget_Per_Day_Required; // Default value will be set
  final double DSFTarget_Expected_Landing; // Default value will be set
  final double DSFTarget_Value;
  final double Order_Quantity;
  final double Order_Value;
  final double avg_time;


  DsfMeasureModel({
    required this.dsfDsfCode,
    required this.dsfDsfName,
    required this.dsfSafBusinessLine,
    required this.safCustomer,
   required this.productiveCustomer, // Default to 0
    required this.ecoPercentage,
    required this.Order_Value,
    this.firstOrder,
    this.lastOrder,
    this.duration = 0, // Default to 0
    this.orderQuantity = 0, // Default to 0
    this.orderValue = 0.0, // Default to 0.0
    this.avgValuePerBill = 0.0, // Default to 0.0
    this.avgSkuPerBill = 0.0, // Default to 0.0
    this.DSFTargetDaysDSFRemaining = 0, // Default to 0
    this.DSFTargetDaysDSFWorked = 0, // Default to 0
    required this.DSFTarget,
    this.DSFTarget_Remaining = 0.0, // Default to 0.0
    this.DSFTarget_Per_Day_Required = 0.0, // Default to 0.0
    this.DSFTarget_Expected_Landing = 0.0, // Default to 0.0
    this.DSFTarget_Value =0.0,
    required this.Order_Quantity,
    required this.Non_Productive_Customers,
    required this.avg_time
  });

  factory DsfMeasureModel.fromJson(Map<String, dynamic> json) {
    return DsfMeasureModel(
      dsfDsfCode: json['DSF_DSF_Code'] ?? 0,
      dsfDsfName: json['DSF_DSF_Name'] ?? 'N/A',
      dsfSafBusinessLine: json['DSF_SAF_Business_Line'] ?? 'N/A',
      safCustomer: json['SAF_Customer'] ?? 0,
      productiveCustomer: json['Productive_Customer'] ?? 0,
      ecoPercentage: json['ECO%_S'] ?? '0%',
      firstOrder: json['First_Order'],
      lastOrder: json['Last_Order'],
      duration: json['Duration'] ?? 0,
      orderQuantity: json['Order_Quantity'] ?? 0,
      orderValue: (json['Order_Value'] as num?)?.toDouble() ?? 0.0,
      avgValuePerBill: (json['Avg_Value_Per_Bill'] as num?)?.toDouble() ?? 0.0,
      avgSkuPerBill: (json['Avg_SKU_Per_Bill'] as num?)?.toDouble() ?? 0.0,
      DSFTargetDaysDSFRemaining: json['DSFTarget_Days_DSF_Remaining'] ?? 0,
      DSFTargetDaysDSFWorked: json['DSFTarget_Days_DSF_Worked'] ?? 0,
      DSFTarget: json['DSFTarget_%'] ?? '0%',
      Non_Productive_Customers: json['Non_Productive_Customers*'] ?? 0,
      DSFTarget_Remaining: (json['DSFTarget_Remaining'] as num?)?.toDouble() ?? 0.0,
      DSFTarget_Per_Day_Required: (json['DSFTarget_Per_Day_Required'] as num?)?.toDouble() ?? 0.0,
      DSFTarget_Expected_Landing: (json['DSFTarget_Expected_Landing'] as num?)?.toDouble() ?? 0.0,
      DSFTarget_Value: (json['DSFTarget_Value'] as num?)?.toDouble() ?? 0.0,
      Order_Value: (json['Order_Value'] as num?)?.toDouble() ?? 0.0,
      Order_Quantity: (json['Order_Quantity'] as num?)?.toDouble() ?? 0.0,
      avg_time: (json['Avg_Perday_Duration'] as num?)?.toDouble() ?? 0.0,

    );
  }
}
