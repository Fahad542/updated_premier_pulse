import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/view/Executive_sale/Team_analysis/progress.dart';
import 'package:mvvm/view/Login_screen/login_view.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../model/branch_model.dart';
import '../../../model/dsf_measure_model.dart';
import '../../../model/heirarchy_model.dart';
import '../../../model/team_company.dart';
import '../../../respository/dsf_meansure_repository.dart';
import '../../../respository/measure_repository.dart';
import '../../../respository/sales_repository.dart';
import '../../../utils/Drawer.dart';
import '../../../utils/customs_widgets/Custom_app_bar.dart';
import '../../../utils/customs_widgets/Master_widgets.dart';
import '../../../utils/customs_widgets/No_data.dart';
import '../../../utils/customs_widgets/Popup_menu.dart';
import '../../../utils/customs_widgets/Shimmer_effect.dart';
import '../../../utils/customs_widgets/list_filters.dart';
import '../../../utils/utils.dart';
import 'Dsf_route.dart';
import 'Non_productive_cust.dart';
import 'Sales_viewmodel.dart';
import 'package:pie_chart/pie_chart.dart';
//
// class Team_analysis extends StatefulWidget {
//   @override
//   State<Team_analysis> createState() => _Team_analysisState();
// }
//
// class _Team_analysisState extends State<Team_analysis> {
//   @override
//
//   final salesViewModel = SalesHeirarchyViewModel();
//   List<UserDetails> userDetailsList = [];
//   bool showDateContainers=false;
//   bool sortwithzero=false;
//   List<UserDetails> rootlist = [];
//   List<dynamic> apiResponseList =[];
//   List<int> companynumbers=[];
//   String sale='';
//   List<Team_compnay> team = [];
//   List<Branch_compnay> branch = [];
//   String salesid='';
//   DateTime? startDate=  DateTime( DateTime.now().year, DateTime.now().month, 1 );
//   DateTime? endDate= DateTime.now();
//   String? startDateFormatted;
//   String? endDateFormatted;
//   List<String> concatenatedList = [];
//   List<String> concatenatedListbranch = [];
//   List<String> concatenatedcode = [];
//   List<String> selectedValue=[];
//   bool padding=false;
//   List<bool> checkcompany = [];
//   List<bool> checkbranch = [];
//   List<bool> checkcbranch = [];
//   String formattedStartDate='';
//   String formattedEndDate='';
//   List<int> branchnumbers=[];
//   List<String> comapnycodelist=[];
//   List<String> branchcodelist=[];
//   var filteredSalesData;
//   bool showsales=false;
//   List<String> selectedmeasures=[];
//   List<bool> checkboxlist=[];
//   String totalsale='';
//   int totals=0;
//   final formatter = NumberFormat('#,###');
//   bool heirarchyloader=false;
//   bool isloading = false;
//   bool node=false;
//
//   var lastSelectedEmpCode;
//
//   late Future<List<UserDetails>> employeeList;
//   @override
//
//   void initState() {
//     DateTime currentDate = DateTime.now();
//     DateTime previousDate = currentDate.subtract(Duration(days: 1));
//     DateTime firstDayOfCurrentMonth = DateTime(currentDate.year, currentDate.month, 1);
//     if(startDate == firstDayOfCurrentMonth)
//       {
//         setState(() {
//           startDate = previousDate;
//         });
//       }
//     print(previousDate);
//
//     load(empcode.auth,'1');
//     totalsale="0";
//     setState(() {
//       startDateFormatted = DateFormat('yyyy,MM,dd').format(startDate!);
//       endDateFormatted = DateFormat('yyyy,MM,dd').format(endDate!);
//       formattedStartDate = startDateFormatted!;  // Assign to formatted variable
//       formattedEndDate = endDateFormatted!;      // Assign to formatted variable
//       print("date ${startDateFormatted}");
//     });
//     final repository = measure_repository();
//     repository.getAllMeasures();
//     super.initState();
//
//
//
//     teamcompany();
//     branchcompany();
//
//   }
//
//
//
//   Widget buildUserTile(UserDetails user) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 0),
//           child: Container(
//
//             child: InkWell(
//               onTap: () async {
//                 if (user.designation == "SUP") {
//                   if (!rootlist.any((item) => item.empCode == user.empCode)) {
//                     rootlist.add(
//                       UserDetails(
//                         empCode: user.empCode,
//                         empName: user.empName,
//                         reportingTo: user.reportingTo,
//                         designation: user.designation,
//                         isCheck: user.isCheck,
//                       ),
//                     );
//                   }
//                   showsales = true;
//                   getsales(user.empCode);
//                   user.reports = salesViewModel.select(user.empCode, '0');
//                 }
//                 else {
//                   setState(() {
//                     lastSelectedEmpCode = user.empCode;
//                     bool alreadyExists = rootlist.any((item) => item.empCode == user.empCode);
//
//                     if (!alreadyExists) {
//                       // If the user does not exist in the list, add them to rootlist
//                       rootlist.add(
//                         UserDetails(
//                           empCode: user.empCode,
//                           empName: user.empName,
//                           reportingTo: user.reportingTo,
//                           designation: user.designation,
//                           isCheck: user.isCheck,
//                         ),
//                       );
//                     }
//
//
//                     rootlist = rootlist.toSet().toList();
//
//
//                     user.reports = salesViewModel.select(user.empCode, '0');
//                     user.isCheck = !user.isCheck;
//                     if(!user.isCheck)
//                     {
//                       int index = rootlist.indexWhere((item) => item.empCode == user.empCode);
//                       if(user.empCode == "99938")
//                         {
//                           rootlist.clear();
//                         }
//
//                       else {
//                         if (index != -1) {
//
//                           rootlist.removeRange(index, rootlist.length);
//                           print("Removed items from index ${index + 1} onwards");
//                         }
//
//                         // If you want to remove the user at the index itself
//                         // rootlist.removeAt(index);
//                         // print("User removed: ${user.empCode}");
//                       }
//                       // rootlist.removeWhere((item) => item.empCode == user.empCode);
//                       // print("User removed: ${user.empCode}");
//
//                       //rootlist.remove(value);
//                       print("object");
//                       lastSelectedEmpCode = index == rootlist.length - 1;
//                     }
//                   });
//
//                 }
//               },
//               child: Row(
//                 children: [
//                   if (user.designation != "SUP")
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16),
//                         color: user.isCheck ? AppColors.greencolor : AppColors.primary,
//                       ),
//                       child: Icon(
//                         user.isCheck ? Icons.remove: Icons.add,
//                         size: 13,
//                         color: Colors.white,
//                       ),
//                     ),
//                   SizedBox(width: 8,),
//                   if (user.designation == "SUP") SizedBox(width: 28),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${user.empName} (${user.empCode})",
//                           style:TextStyle(
//                             color: (user.isCheck)
//                                 ? AppColors.greencolor
//                                  : AppColors.primary,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                           ),
//
//                           maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                         ),
//                       Text(user.designation),
//                       ],
//                     ),
//                   ),
//                   if(user.isCheck == false)
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         bool alreadyExists = rootlist.any((item) => item.empCode == user.empCode);
//
//                         if (!alreadyExists) {
//
//                           rootlist.add(
//                             UserDetails(
//                               empCode: user.empCode,
//                               empName: user.empName,
//                               reportingTo: user.reportingTo,
//                               designation: user.designation,
//                               isCheck: user.isCheck,
//                             ),
//                           );
//                         }
//
//
//                         rootlist = rootlist.toSet().toList();
//                         showsales = true;
//                         getsales(user.empCode);
//                         user.reports = salesViewModel.select(user.empCode, '0');
//                       });
//                     },
//                     child: Image.asset("assets/growth.png", height: 20, width: 20, color: AppColors.primary),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//        // Container(
//        //   width: 500,
//        //   height: 1,
//        //   decoration: BoxDecoration(color: Colors.black),
//        // ),
//        Divider(),
//         FutureBuilder<List<UserDetails>>(
//           future: user.reports,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Container();
//             }
//
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             }
//
//             if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(
//                 child: Text(
//                   '',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey,
//                   ),
//                 ),
//               );
//             }
//
//             return Padding(
//               padding: const EdgeInsets.only(left: 0),
//               child: Column(
//                 children: user.isCheck
//                     ? snapshot.data!.map((report) => Padding(
//                   padding: const EdgeInsets.only(left: 17),
//                   child: buildUserTile(report),
//                 )).toList()
//                     : [],
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   void showfitler() async {
//
//     await salesViewModel.initializeDatabase();
//     await salesViewModel.fetchdata();
//     await salesViewModel.fetchbranchdata();
//     setState(() {
//       try {
//
//         salesViewModel.showDropdownCheckboxs(
//           context,
//           concatenatedListbranch,
//           concatenatedList,
//           selectedValue,
//           "Select Companies",
//           checkcompany,
//           checkbranch,
//               (selectedValue) {
//             comapnycodelist = selectedValue;
//             print('Selected Values: $checkbranch');
//           },
//               (selectedValue) {
//             branchcodelist = selectedValue;
//
//             print('Selected Values: $branchcodelist');
//           },
//
//               () async {
//             try {
//               branchnumbers = branchcodelist.map((part) => int.parse(part.replaceAll('"', ''))).toList();
//               companynumbers = comapnycodelist.map((code) => int.parse(code)).toList();
//              await getsales(salesid);
//
//             } catch (error) {
//               print('API Error: $error');
//               Utils.snackBarred("Error to load data", context);
//               Navigator.of(context).pop(); // Close loading dialog
//             }
//           },
//
//         );
//       } catch (error) {
//         // Handle UI/dialogue box error
//         print('UI Error: $error');
//       }
//     });
//
//   }
//
//   Future<void> load(String code, String check) async {
// setState(() {
//   heirarchyloader=true;
// });
//     await salesViewModel.initializeDatabase();
//
//     employeeList = salesViewModel.select(code, check);
// setState(() {
//   heirarchyloader=false;
// });
//     print("Datass: ${employeeList}");
//
//   }
//   Future<void> branchcompany() async {
//     await salesViewModel.initializeDatabase();
//     final data = await salesViewModel.fetchbranchdata();
//
//
//     setState( (){
//       branch=data;
//       for (final item in branch) {
//         String concatenatedString = "${item.BranchName} - ${item.BranchID}";
//         concatenatedListbranch.add(concatenatedString);
//         checkbranch.add(item.ischecked);
//       }} );
//   }
//   Future<void> teamcompany() async {
//
//     await salesViewModel.initializeDatabase();
//     final data = await salesViewModel.fetchdata();
//
//     setState(() {
//       team=data;
//       for (final item in team) {
//         String concatenatedString = "${item.companyID} - ${item.companyName}";
//         concatenatedList.add(concatenatedString);
//         concatenatedcode.add(item.companyName);
//         checkcompany.add(item.ischecked);
//       }});
//   }
//   Future<void> _loadUserDetails(String reporting, String repto) async {
//
//     await salesViewModel.initializeDatabase();
//     final data = await salesViewModel.select(reporting, repto);
//     setState(() {
//
//         userDetailsList =data;
//
//
//     });
//     print("Data: ${data}");
//     // Convert the fetched data to a hierarchical tree structure
//     //_buildTree();
//   }
//
//   Future<void> getsales(String empcode) async {
//     setState(() {
//       startDateFormatted = DateFormat('yyyy,MM,dd').format(startDate!);
//       endDateFormatted = DateFormat('yyyy,MM,dd').format(endDate!);
//       formattedStartDate = startDateFormatted!; // Assign to formatted variable
//       formattedEndDate = endDateFormatted!;
//       isloading = true;
//     });
//     try {
//       apiResponseList = await SalesRepository().fetchData(
//           empcode,
//           formattedStartDate,
//           formattedEndDate,
//           companynumbers,
//           branchnumbers,
//           selectedmeasures);
//
//       setState(() {
//         totals = 0;
//         for (int i = 0; i < apiResponseList.length; i++) {
//           double salesValue = apiResponseList[i]['Sales_Inc_ST'] ?? 0;
//           totals += salesValue.round();
//         }
//         totalsale = formatter.format(totals);
//       });
//       setState(() {
//         isloading = false;
//       });
//     }
//     catch (e, stackstarce) {
//       Utils.toastMessage(e.toString());
//       setState(() {
//
//         apiResponseList = [];
//         isloading = false;
//       });
//       print(stackstarce);
//       print(e.toString());
//     }
//   }
//
//
//   Widget _buildDataRow(String heading, String value) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       margin: EdgeInsets.symmetric(vertical: 5),
//       decoration: BoxDecoration(
//        // color: AppColors.primary.withOpacity(0.02),
//         borderRadius: BorderRadius.circular(8)
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               flex: 5,
//               child: Text(
//                 '$heading:',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 14,
//                 ),
//
//               ),
//             ),
//
//             Expanded(
//               flex: 5,
//               child: Text(
//                 value,
//                 style: TextStyle(
//                   color: AppColors.primary,
//                   fontSize: 14,
//
//
//                 ),
//               ),
//             ),
//           ],
//         ),
//
//     );
//   }
//   final dsfMeasureRepository = dsf_measure_Repository();
//   List<DsfMeasureModel>  data= [];
//   bool dsfLoading = false;
//   Future<List<DsfMeasureModel>> fetchData(String dsfCode) async {
//
//     try {
//       data = await dsfMeasureRepository.fetchData(
//         formattedStartDate,
//         formattedEndDate,
//         int.parse(dsfCode),
//       );
//
//       return data;
//     } catch (e, stack) {
//       print('stack: $stack');
//       print('Error fetching data: $e');
//       throw e;
//     }
//   }
//   String formatNumber(String? number) {
//     if (number == null || number.isEmpty) {
//       return 'N/A';
//     }
//
//     double? parsedNumber = double.tryParse(number);
//
//     if (parsedNumber == null) {
//       return 'Invalid number';
//     }
//
//
//     parsedNumber = double.parse(parsedNumber.toStringAsFixed(0));
//
//     final numberFormat = NumberFormat('#,##');
//     return numberFormat.format(parsedNumber);
//   }
//
//
//
//
//   void bottomsheet(BuildContext context, String code, String name) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//       ),
//       builder: (context) {
//          DateTime currentDate = DateTime.now();
//          int currentDayNumber = currentDate.day -1;
//         DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
//         int daysDifference = currentDate.difference(firstDayOfMonth).inDays + 1;
//        double timeline_percent= (currentDayNumber/daysDifference)*100;
//
//         return
//             SizedBox(
//             height: MediaQuery.of(context).size.height * 0.85, // 90% of screen height
//         child:
//         SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//             child:
//             FutureBuilder<List<DsfMeasureModel>>(
//             future: fetchData(code),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return  Column(
//
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Center(child: Padding(
//                         padding: EdgeInsets.only(top: 320),
//                         child: CircularProgressIndicator(color: AppColors.greencolor,)),),
//                   ],
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text(
//                     'Error: ${snapshot.error}',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 );
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Center(
//                   child: Text(
//                     'No data available.',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 16,
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//                 );
//               } else {
//                 List<DsfMeasureModel> data = snapshot.data!;
//                 var dsfachieve= data[0].DSFTarget_Value - data[0].DSFTarget_Remaining;
//                 var productiveachieve= (data[0].productiveCustomer! * 100) / data[0].safCustomer;
//                 double targetValue = double.parse(data[0].DSFTarget.replaceAll('%', ''));
//                 return
//                   Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       // Close button
//
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(), // Left side empty space
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               gradient: LinearGradient(
//                                 colors: [AppColors.primary, AppColors.greencolor],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                             ),
//                             child: Text(
//                               name,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               alignment: Alignment.topRight, // Close button right pe
//                               child: IconButton(
//                                 icon: Container(
//
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//                                         color: AppColors.white),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(0.0),
//                                       child: Icon(Icons.close, color: AppColors.primary),
//                                     )),
//                                 onPressed: () {
//                                   Navigator.pop(context); // Close the bottom sheet
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20,),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Center(
//                             child: Container(
//                                 height:50,
//                                 child: MyProgressBar(animation: timeline_percent ,)),
//                           ),
//
//                         ],
//                       ),
//                       SizedBox(height: 40,),
//                       Row(
//
//                        // mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//
//
//                               Text("                  Dsf Target",style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue[900]),   textAlign: TextAlign.center,),
//                           SizedBox(width: 20,),
//                           Text("                    Productive Customer",style: TextStyle(fontWeight: FontWeight.w500, color: Colors.green[900]) , textAlign: TextAlign.center),
//                        ] ),
//                       Container(
//                         height: 150,
//                         child: Row(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           // crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//
//                             Flexible(
//                               flex: 5,
//                               child:
//                               speedcaart(achievement: dsfachieve, color: AppColors.primary, dsf_target: true, targetValue: targetValue,target: data[0].DSFTarget_Value,)
//
//                             ),
//
//                   Flexible(
//                     flex: 5,
//                     child:
//                     speedcaart2(achievement: productiveachieve.toString() !="NaN" ? productiveachieve : 0, color: Colors.green[700]!, dsf_target: false,)
//                   ),
//
//                           ],
//                         ),
//                       ),
//
//                      if (data[0].productiveCustomer ==0 && data[0].Non_Productive_Customers == 0)
//                        Container(),
//                       if (data[0].productiveCustomer !=0 || data[0].Non_Productive_Customers != 0)
//                       Column(
//                         children: [
//                           Text("Productive vs Non Productive", style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.greencolor),),
//                           SizedBox(height: 20),
//                           PieChart(
//                             dataMap: {
//                               "Productive" :data[0].productiveCustomer!.toDouble(),
//                                   "Non Productive" : data[0].Non_Productive_Customers!.toDouble()
//                             },
//                             animationDuration: Duration(milliseconds: 3500),
//                             chartLegendSpacing: 30,
//                             chartRadius: MediaQuery.of(context).size.width / 3.5,
//                             initialAngleInDegree: 0,
//                             chartType: ChartType.ring,
//                             ringStrokeWidth: 30,
//                             colorList: [
//                               ColorTween(begin: AppColors.primary, end: AppColors.primary).lerp(0.5)!,
//                               ColorTween(begin: Color(0xfff51604), end: Color(0xfff51604)).lerp(0.5)!,
//                             ],
//                             legendOptions: LegendOptions(
//                               showLegendsInRow: false,
//                               legendPosition: LegendPosition.right,
//                               showLegends: true,
//                               legendTextStyle: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 12,
//                                 color: AppColors.primary,
//                               ),
//                             ),
//                             chartValuesOptions: ChartValuesOptions(
//                               showChartValueBackground: true,
//                               showChartValues: true,
//                               showChartValuesInPercentage: false,
//                               showChartValuesOutside: false,
//                               decimalPlaces: 1,
//                               chartValueStyle: TextStyle(
//                                 fontSize: 12,
//                                 color: AppColors.greencolor,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//
//                       // Expanded(
//                       //   child:
//                         ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: data.length,
//                           itemBuilder: (context, index) {
//                             var item = data[index];
//                             return Padding(
//                               padding: const EdgeInsets.all(1.0),
//                               child:
//                               Column(
//                                 children: [
//                                   _buildDataRow('DSF SAF BusinessLine', item.dsfSafBusinessLine),
//                                   _buildDataRow('SAF Customer', item.safCustomer.toString()),
//                                   _buildDataRow('Productive Customer', item.productiveCustomer.toString()), _buildDataRow('Non Productive Customer', item.Non_Productive_Customers.toString()),
//                                   _buildDataRow('Eco Percentage', item.ecoPercentage),
//                                   _buildDataRow('First Order', item.firstOrder != null ? DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(item.firstOrder!)) : 'N/A',),
//                                   _buildDataRow('Last Order', item.lastOrder != null ? DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(item.lastOrder!)) : 'N/A'),
//                                   _buildDataRow('Duration', "${item.duration.toString()} Hours"),
//                                   _buildDataRow('Order Quantity', formatNumber(item.Order_Quantity.toString())),
//                                   _buildDataRow('Order Value', formatNumber(item.Order_Value.toString())),
//                                   _buildDataRow('Avg Sku Per Bill', item.avgSkuPerBill?.toStringAsFixed(2) ?? '0.00'),
//                                   _buildDataRow('DSF Target Value', formatNumber(item.DSFTarget_Value.toString())),
//                                   _buildDataRow('DSFTarget %', item.DSFTarget.toString()),
//                                   _buildDataRow('DSF Target Remaining', formatNumber(item.DSFTarget_Remaining.toString())),
//                                   _buildDataRow('DSF Target Expected Landing', formatNumber(item.DSFTarget_Expected_Landing.toString())),
//                                   _buildDataRow('DSF Target Per Day Required', formatNumber(item.DSFTarget_Per_Day_Required.toString())),
//                                   _buildDataRow('DSF Target Days Remaining', item.DSFTargetDaysDSFRemaining.toString()),
//
//                                  ],
//                               ),
//                             );
//                           },
//                         ),
//                       //),
//                     ],
//                   ),
//                 );
//
//               }
//             },
//             )
//           )
//             );
//       },
//     );
//   }
//
//   // late GoogleMapController _controller;
//   // Set<Marker> _markers = Set();
//   // final LatLng _initialPosition = LatLng(37.7749, -122.4194);  // San Francisco Coordinates
//   //
//   // void _onMapCreated(GoogleMapController controller) {
//   //   _controller = controller;
//   // }
//
//
//
//
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       WillPopScope(
//         onWillPop: () async {
//           return await Exit.showExitDialog(context);
//         },
//         child:
//         heirarchyloader ?
//             Container()
//         :
//
//         Scaffold(
//             appBar:
//             CustomAppBar(
//               title: 'Team Analysis',
//
//               actions: [
//                 Icon(Icons.abc, color: AppColors.greencolor,),
//                 if(showsales == true)
//                   MyPopupMenu(
//                     menuItems: [
//                       MenuItem(
//                         text: 'Share',
//                         icon: Icons.share,
//                         value: 'share',
//                         onTap: () {
//                           print('Share selected');
//                           // Add your custom action here
//                         },
//                       ),
//                       MenuItem(
//                           text: 'Measures',
//                           icon: Icons.filter_list,
//                           value: 'measures',
//                           onTap: () {
//
//                           }
//                       ),
//                       MenuItem(
//                         text: 'Filters',
//                         icon: Icons.filter_list,
//                         value: 'filters',
//                         onTap: () {
//                           print('Filters selected');
//                           // Add your custom action here
//                         },
//                       ),
//                       MenuItem(
//                         text: sortwithzero == false ? 'With 0s' : 'Without 0s',
//                         // Correct use of ternary operator
//                         icon: Icons.list,
//                         value: 'zero',
//                         onTap: () {
//                           print(sortwithzero ? 'With 0s' : 'Without 0s');
//                           // Add your custom action here
//                         },
//                       )
//                     ],
//                     onSelected: (value) {
//                       if (value == "measures") {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return filters(
//                               onSelectionDone: (selectedValues) async {
//                                 setState(() {
//                                   selectedmeasures = selectedValues.toList();
//                                 });
//
//                                 DateFormat dateFormat = DateFormat(
//                                     'yyyy,MM,dd');
//                                 formattedStartDate =
//                                     dateFormat.format(startDate!);
//                                 formattedEndDate = dateFormat.format(endDate!);
//                                 await getsales(salesid);
//                                 setState(() {
//                                   apiResponseList = apiResponseList;
//                                 });
//                               },
//                               selectedvalues: selectedmeasures,
//                             );
//                           },
//                         );
//                       }
//
//                       if (value == 'share') {
//                         String combinedMessage = "Start Date: $formattedStartDate\nEnd Date: $formattedEndDate\n\n";
//
//                         for (int i = 0; i < apiResponseList.length; i++) {
//                           if (apiResponseList[i]['EmpCode'].isNotEmpty) {
//                             String name = apiResponseList[i]['EmpName'];
//                             String id = apiResponseList[i]['EmpCode']
//                                 .toString();
//                             String sale = NumberFormat('#,###').format(
//                                 double.parse(apiResponseList[i]['Sales_Inc_ST']
//                                     ?.toString()
//                                     ?.replaceAll(',', '') ?? '0'));
//                             sale = sale.isEmpty ? '0' : sale;
//
//                             String measure = ''; // Reset measure for each iteration
//                             measure +=
//                                 List.generate(selectedmeasures.length, (index) {
//                                   final measure = selectedmeasures[index];
//                                   final teamValue = apiResponseList[i][measure
//                                       .toString().replaceAll(' ', '_')];
//                                   final formattedValue = teamValue != null
//                                       ? (measure.endsWith('%') ? teamValue
//                                       .toString() : formatter.format(teamValue)
//                                       .toString())
//                                       : '0';
//                                   return "$measure: $formattedValue";
//                                 },
//                                 ).join('\n');
//
//
//                             combinedMessage +=
//                             "Name: $name\nID: $id\nSale: $sale\n$measure\n\n";
//                           }
//                         }
//
//                         Share.share(
//                             combinedMessage, subject: 'Sales Information');
//                       }
//
//                       if (value == "filters") {
//                         showfitler();
//                       }
//
//                       if (value == "zero") {
//                         setState(() {
//                           sortwithzero = !sortwithzero;
//                         });
//                       }
//                     },
//
//                   ),
//
//               ],
//             ),
//             drawer: CustomDrawer(),
//             body:
//
//
//             isloading
//                 ? shimmer_effect(
//               isLoading: isloading, selectedmeasures: selectedmeasures,)
//
//                 :
//
//
//             Stack(
//                 children: [
//                   SizedBox(height: 20,),
//                   Column(
//                       children: [
//                         TotalSalesCard(totalSale: totalsale.toString(),
//                           title: 'Total Sales',),
//                         if(showsales == true)
//                           SizedBox(height: 30,),
//                         Expanded(child:
//                         Container(
//                             padding: EdgeInsets.symmetric(horizontal: 14.0),
//
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: 25,),
//
// //if(showsales==true)
//                                   Container(
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(width: 1, color: AppColors.primary),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         InkWell(
//                                           onTap: () {
//                                             setState(() {
//                                               showsales = false;
//                                               totalsale = '0';
//                                               load(empcode.auth, '1');
//                                               // _loadUserDetails(empcode.auth, '1');
//                                               rootlist.clear();
//                                             });
//                                           },
//                                           child: Container(
//                                             height: 40,
//                                             width: 50,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                             alignment: Alignment.center,
//                                             child: Text(
//                                               'Root',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: SingleChildScrollView(
//                                             physics: BouncingScrollPhysics(),
//                                             scrollDirection: Axis.horizontal,
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(0.0),
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                                 children: rootlist.toSet().toList().asMap().map((index, stackItem) {
//
//                                                   if (index == rootlist.length - 1) {
//                                                     salesid = stackItem.empCode;
//                                                   }
//                                                   final stackItemTitle = UserDetails(
//                                                       empName: stackItem.empName,
//                                                       empCode: stackItem.empCode,
//                                                       reportingTo: stackItem.reportingTo,
//                                                       designation: stackItem.designation,
//                                                       isCheck: false
//                                                   ).empName;
//                                                   final stackItemdes = UserDetails(
//                                                       empName: stackItem.empName,
//                                                       empCode: stackItem.empCode,
//                                                       reportingTo: stackItem.reportingTo,
//                                                       designation: stackItem.designation,
//                                                       isCheck: false
//                                                   ).designation;
//
//                                                   return MapEntry(
//                                                     index,
//                                                     Padding(
//                                                       padding: const EdgeInsets.symmetric(horizontal: 0),
//                                                       child: Row(
//                                                         children: [
//                                                           Container(
//                                                             width: 80,
//                                                             decoration: BoxDecoration(
//                                                               color: index == rootlist.length - 1
//                                                                   ? AppColors.primary
//                                                                   : Colors.white,
//                                                               borderRadius: BorderRadius.circular(6),
//                                                             ),
//                                                             child: GestureDetector(
//                                                               onTap: () async {
//                                                                 // _loadUserDetails(stackItem.empCode, stackItem.reportingTo);
//                                                                 employeeList = salesViewModel.search(stackItem.empCode);
//                                                                 // load(stackItem.empCode, stackItem.reportingTo);
//                                                                 setState(() {
//                                                                   showsales = false;
//                                                                   totalsale = '0';
//                                                                   rootlist.removeRange(index + 1, rootlist.length);
//                                                                   showsales = false;
//                                                                 });
//                                                               },
//                                                               child: Padding(
//                                                                 padding: const EdgeInsets.all(2.0),
//                                                                 child: Column(
//                                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                                   children: [
//                                                                     Text(
//                                                                       stackItemTitle,
//                                                                       style: TextStyle(
//                                                                         fontSize: 10,
//                                                                         fontWeight: index == rootlist.length - 1
//                                                                             ? FontWeight.w600
//                                                                             : FontWeight.normal,
//                                                                         color: index == rootlist.length - 1
//                                                                             ? Colors.white
//                                                                             : Colors.black,
//                                                                       ),
//                                                                       textAlign: TextAlign.center,
//                                                                       overflow: TextOverflow.ellipsis,
//                                                                     ),
//                                                                     SizedBox(height: 3),
//                                                                     Text(
//                                                                       '$stackItemdes',
//                                                                       style: TextStyle(
//                                                                         fontSize: 11,
//                                                                         color: index == rootlist.length - 1
//                                                                             ? Colors.white
//                                                                             : Colors.black,
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   );
//                                                 }).values.toList().reversed.toList(),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//
//                                   SizedBox(height: 26.0),
//                                   if (showsales == false)
//
//                                     (employeeList != null)
//                                         ?
//
//                                     Expanded(
//                                       child:
//                                       FutureBuilder<List<UserDetails>>(
//                                         future: employeeList,
//                                         builder: (context, snapshot) {
//                                           if (snapshot.connectionState ==
//                                               ConnectionState.waiting) {
//                                             return Center(
//                                                 child: CircularProgressIndicator());
//                                           }
//
//                                           if (snapshot.hasError) {
//                                             return Center(child: Text(
//                                                 'Error: ${snapshot.error}'));
//                                           }
//
//                                           if (!snapshot.hasData ||
//                                               snapshot.data!.isEmpty) {
//                                             return Center(
//                                                 child: Text('No data found.'));
//                                           }
//
//                                           return ListView(
//                                             physics: BouncingScrollPhysics(),
//                                             children: snapshot.data!.map<
//                                                 Widget>((employee) {
//                                               return buildUserTile(employee);
//                                             }).toList(),
//                                           );
//                                         },
//                                       ),
//
//                                       // ListView.builder(
//                                       //   physics: BouncingScrollPhysics(),
//                                       //   itemCount: userDetailsList.length,
//                                       //   itemBuilder: (BuildContext context, index) {
//                                       //     var data = userDetailsList[index];
//                                       //
//                                       //
//                                       //     return
//                                       //
//                                       //       buildUserTile(data);
//                                       //     //   Padding(
//                                       //     //   padding:  EdgeInsets.symmetric(horizontal: 0),
//                                       //     //   child:
//                                       //     //   Container(
//                                       //     //     padding: EdgeInsets.all(8),
//                                       //     //     decoration: BoxDecoration(
//                                       //     //         color: AppColors.primary.withOpacity(0.1),
//                                       //     //         borderRadius: BorderRadius.circular(8)),
//                                       //     //     child: Column(
//                                       //     //       children: [
//                                       //     //         Row(
//                                       //     //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       //     //           children: [
//                                       //     //           Text(data.empName),
//                                       //     //           InkWell(
//                                       //     //               onTap: ()
//                                       //     //               {
//                                       //     //                 setState(() {
//                                       //     //                   node = !node;
//                                       //     //                   _loadUserDetails(data.empCode, "0");
//                                       //     //                 });
//                                       //     //
//                                       //     //               },
//                                       //     //               child: Icon(node == false ? Icons.add : Icons.remove))
//                                       //     //
//                                       //     //
//                                       //     //           ],),
//                                       //     //
//                                       //     //   // HeirarchyCard(
//                                       //     //   //   personwise: true,
//                                       //     //   //   title: data.empName,
//                                       //     //   //   date: data.empCode,
//                                       //     //   //   amount: sale,
//                                       //     //   //   color: Colors.green,
//                                       //     //   //   designation: data.designation,
//                                       //     //   //   onTap: () {
//                                       //     //   //     setState(() {
//                                       //     //   //       if (showsales == true) {
//                                       //     //   //         getsales(data.empCode);
//                                       //     //   //       }
//                                       //     //   //       rootlist.add(
//                                       //     //   //           UserDetails(
//                                       //     //   //           empCode: data.empCode,
//                                       //     //   //           empName: data.empName,
//                                       //     //   //           reportingTo: data.reportingTo,
//                                       //     //   //           designation: data.designation,
//                                       //     //   //           isCheck: data.isCheck));
//                                       //     //   //       _loadUserDetails(data.empCode, '0');
//                                       //     //   //     });
//                                       //     //   //   },
//                                       //     //   //   saleonTap: () {
//                                       //     //   //     setState(()
//                                       //     //   //     {
//                                       //     //   //       rootlist.add(UserDetails(
//                                       //     //   //           empCode: data.empCode,
//                                       //     //   //           empName: data.empName,
//                                       //     //   //           reportingTo: data.reportingTo,
//                                       //     //   //           designation: data.designation,
//                                       //     //   //           isCheck: data.isCheck));
//                                       //     //   //       showsales = true;
//                                       //     //   //       getsales(data.empCode);
//                                       //     //   //     });
//                                       //     //   //   },
//                                       //     //   //   showsale: showsales,
//                                       //     //   //   selectedmeasures: selectedmeasures, item: { },
//                                       //     //   //
//                                       //     //   // ),
//                                       //     // ])));
//                                       //   },
//                                       // ),
//                                     )
//                                         : Container(
//                                       height: 400,
//                                       child: Nodata(),
//                                     ),
//                                   if ( showsales == true )
//
//                                     SalesListView(
//                                       sortdata: sortwithzero == false
//                                           ? 'With Zero'
//                                           : 'Without Zero',
//                                       apiResponseList: apiResponseList,
//
//                                       customCardWidget: (data) {
//                                         return
//                                           HeirarchyCard(
//                                               personwise: true,
//                                               title: data['EmpName'].toString(),
//                                               date: data['EmpCode'].toString(),
//                                               amount: data['Sales_Inc_ST']
//                                                   .toString(),
//                                               color: AppColors.greencolor,
//                                               designation: data['EmpDesignation']
//                                                   .toString(),
//                                               kpionTap: () {
//                                                 bottomsheet(
//                                                     context, data['EmpCode'],
//                                                     data['EmpName']);
//                                               },
//                                               route: () {
//                                                 Navigator.push(context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             MapScreen(
//                                                               dsfcode: data['EmpCode']
//                                                                   .toString(),
//                                                               date: endDateFormatted
//                                                                   .toString(),
//                                                               name: data['EmpName']
//                                                                   .toString(),
//                                                               code: data['EmpCode']
//                                                                   .toString(),)));
//                                                 //dsf_route(context);
//                                               },
//                                               onTap: () async
//                                               {
//                                                 if (data['EmpDesignation'] ==
//                                                     "DSF") {
//                                                   salesViewModel
//                                                       .showCustomerWiseDialog(
//                                                       context,
//                                                       data['EmpCode'],
//                                                       formattedStartDate,
//                                                       formattedEndDate,
//                                                       data['EmpName'],
//                                                       companynumbers,
//                                                       branchnumbers,
//                                                       selectedmeasures);
//                                                 }
//                                                 if (data['EmpDesignation'] !=
//                                                     "DSF") {
//                                                   await getsales(
//                                                       data['EmpCode']);
//                                                   setState(() {
//                                                     rootlist.add(
//                                                       UserDetails(
//                                                           empCode: data['EmpCode'],
//                                                           empName: data['EmpName'],
//                                                           reportingTo: data['ReportTo'],
//                                                           designation: data['EmpDesignation'],
//                                                           isCheck: false),
//                                                     );
//                                                   });
//                                                 }
//                                               },
//
//                                               showsale: showsales,
//                                               selectedmeasures: selectedmeasures,
//                                               item: data,
//                                               saleonTap: () {}
//
//                                           );
//                                       },
//                                     ),
//
//
//                                 ])))
//                       ]),
//
//                   if(showsales == true)
//
//
//                     Positioned(
//                         top: 130,
//                         right: 0,
//                         left: 0,
//
//                         child:
//                         DateRangeSelector(
//                           startDate: startDate,
//                           endDate: endDate,
//                           showDateContainers: true,
//                           onStartDateSelected: (date) {
//                             setState(() {
//                               startDate = date;
//                               // Print the selected start date
//                               print("Start Date selected: $startDate");
//
//                               // Check if the start date is valid
//                               if (startDate!.isAfter(endDate!)) {
//                                 // Show an error message to the user using a Snackbar
//                                 Utils.toastMessage(
//                                     "Start date cannot be after the end date");
//                               } else {
//                                 // Only call API if startDate is before or equal to endDate
//                                 getsales(salesid);
//                               }
//                             });
//                           },
//                           onEndDateSelected: (date) {
//                             setState(() {
//                               endDate = date;
//                               // Print the selected end date
//                               print("End Date selected: $endDate");
//
//                               // Check if the end date is valid
//                               if (endDate!.isBefore(startDate!)) {
//                                 // Show an error message to the user using a Snackbar
//                                 Utils.toastMessage(
//                                     "End date cannot be before the start date");
//                               } else {
//                                 // Only call API if endDate is after or equal to startDate
//                                 getsales(salesid);
//                               }
//                             });
//                           },
//                         )
//
//                     ),
//                 ]
//             )
//         ),
//       );
//   }}





//
// class Team_analysis extends StatefulWidget {
//   @override
//   State<Team_analysis> createState() => _Team_analysisState();
// }
//
// class _Team_analysisState extends State<Team_analysis> {
//   @override
//
//   final salesViewModel = SalesHeirarchyViewModel();
//   List<UserDetails> userDetailsList = [];
//   bool showDateContainers=false;
//   bool sortwithzero=false;
//   List<UserDetails> rootlist = [];
//   List<dynamic> apiResponseList =[];
//   List<int> companynumbers=[];
//   String sale='';
//   List<Team_compnay> team = [];
//   List<Branch_compnay> branch = [];
//   String salesid='';
//   DateTime? startDate=  DateTime( DateTime.now().year, DateTime.now().month, 1 );
//   DateTime? endDate= DateTime.now();
//   String? startDateFormatted;
//   String? endDateFormatted;
//   List<String> concatenatedList = [];
//   List<String> concatenatedListbranch = [];
//   List<String> concatenatedcode = [];
//   List<String> selectedValue=[];
//   bool padding=false;
//   List<bool> checkcompany = [];
//   List<bool> checkbranch = [];
//   List<bool> checkcbranch = [];
//   String formattedStartDate='';
//   String formattedEndDate='';
//   List<int> branchnumbers=[];
//   List<String> comapnycodelist=[];
//   List<String> branchcodelist=[];
//   var filteredSalesData;
//   bool showsales=false;
//   List<String> selectedmeasures=[];
//   List<bool> checkboxlist=[];
//   String totalsale='';
//   int totals=0;
//   final formatter = NumberFormat('#,###');
//   bool heirarchyloader=false;
//   bool isloading = false;
//   bool node=false;
//
//   var lastSelectedEmpCode;
//
//   List<UserDetails>  employeeList=[];
//   List<UserDetails>  depthList=[];
//   @override
//
//   void initState() {
//
//     DateTime currentDate = DateTime.now();
//     DateTime previousDate = currentDate.subtract(Duration(days: 1));
//     DateTime firstDayOfCurrentMonth = DateTime(currentDate.year, currentDate.month, 1);
//     if(startDate == firstDayOfCurrentMonth)
//     {
//       setState(() {
//         startDate = previousDate;
//       });
//     }
//     print(previousDate);
//
//     load(empcode.auth);
//     totalsale="0";
//     setState(() {
//       startDateFormatted = DateFormat('yyyy,MM,dd').format(startDate!);
//       endDateFormatted = DateFormat('yyyy,MM,dd').format(endDate!);
//       formattedStartDate = startDateFormatted!;  // Assign to formatted variable
//       formattedEndDate = endDateFormatted!;      // Assign to formatted variable
//       print("date ${startDateFormatted}");
//     });
//     final repository = measure_repository();
//     repository.getAllMeasures();
//     super.initState();
//     teamcompany();
//     branchcompany();
//   }
//
//
//
//   Widget buildUserTile(UserDetails user) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical:4),
//           child: Container(
//
//             child: InkWell(
//               onTap: () async {
//                 if (user.designation == "SUP") {
//                   if (!rootlist.any((item) => item.empCode == user.empCode)) {
//                     rootlist.add(
//                       UserDetails(
//                         empCode: user.empCode,
//                         empName: user.empName,
//                         reportingTo: user.reportingTo,
//                         designation: user.designation,
//                         isCheck: user.isCheck,
//                       ),
//                     );
//                   }
//                   showsales = true;
//                   getsales(user.empCode);
//
//                 }
//                 else {
//                   setState(() {
//                     lastSelectedEmpCode = user.empCode;
//                     bool alreadyExists = rootlist.any((item) => item.empCode == user.empCode);
//
//                     if (!alreadyExists) {
//                       rootlist.add(
//                         UserDetails(
//                           empCode: user.empCode,
//                           empName: user.empName,
//                           reportingTo: user.reportingTo,
//                           designation: user.designation,
//                           isCheck: user.isCheck,
//                         ),
//                       );
//                     }
//
//
//                     rootlist = rootlist.toSet().toList();
//
//
//                    user.reports = salesViewModel.select(user.empCode, '0');
//                     user.isCheck = !user.isCheck;
//                     if(!user.isCheck)
//                     {
//                       int index = rootlist.indexWhere((item) => item.empCode == user.empCode);
//                       if(user.empCode == "99938")
//                       {
//                         rootlist.clear();
//                       }
//
//                       else {
//                         if (index != -1) {
//
//                           rootlist.removeRange(index, rootlist.length);
//                           print("Removed items from index ${index + 1} onwards");
//                         }
//                       }
//                       rootlist.removeWhere((item) => item.empCode == user.empCode);
//                       print("User removed: ${user.empCode}");
//
//                       //rootlist.remove(value);
//                       print("object");
//                       lastSelectedEmpCode = index == rootlist.length - 1;
//                     }
//                   });
//
//                 }
//               },
//               child: Row(
//                 children: [
//                   if (user.designation != "SUP")
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         color: user.isCheck ? AppColors.greencolor : AppColors.primary,
//                       ),
//                       child: Icon(
//                         user.isCheck ? Icons.remove: Icons.add,
//                         size: 13,
//                         color: Colors.white,
//                       ),
//                     ),
//                   SizedBox(width: 8,),
//                   if (user.designation == "SUP") SizedBox(width: 28),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${user.empName} (${user.empCode})",
//                           style:TextStyle(
//                             color: (user.isCheck)
//                                 ? AppColors.greencolor
//                                 : AppColors.primary,
//                             //fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                           ),
//
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Text(user.designation),
//                       ],
//                     ),
//                   ),
//                   if(user.isCheck == false)
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           bool alreadyExists = rootlist.any((item) => item.empCode == user.empCode);
//
//                           if (!alreadyExists) {
//
//                             rootlist.add(
//                               UserDetails(
//                                 empCode: user.empCode,
//                                 empName: user.empName,
//                                 reportingTo: user.reportingTo,
//                                 designation: user.designation,
//                                 isCheck: user.isCheck,
//                               ),
//                             );
//                           }
//
//
//                           rootlist = rootlist.toSet().toList();
//                           showsales = true;
//                           getsales(user.empCode);
//                           user.reports = salesViewModel.select(user.empCode, '0');
//                         });
//                       },
//                       child: Image.asset("assets/growth.png", height: 20, width: 20, color: AppColors.primary),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         // Container(
//         //   width: 500,
//         //   height: 1,
//         //   decoration: BoxDecoration(color: Colors.black),
//         // ),
//        // Divider(),
//         FutureBuilder<List<UserDetails>>(
//           future: user.reports,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Container();
//             }
//
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             }
//
//             if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(
//                 child: Text(
//                   '',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey,
//                   ),
//                 ),
//               );
//             }
//
//             return Padding(
//               padding: const EdgeInsets.only(left: 0),
//               child: Column(
//                 children: user.isCheck
//                     ? snapshot.data!.map((report) => Padding(
//                   padding: const EdgeInsets.only(left: 17),
//                   child: buildUserTile(report),
//                 )).toList()
//                     : [],
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   void showfitler() async {
//
//     await salesViewModel.initializeDatabase();
//     await salesViewModel.fetchdata();
//     await salesViewModel.fetchbranchdata();
//     setState(() {
//       try {
//
//         salesViewModel.showDropdownCheckboxs(
//           context,
//           concatenatedListbranch,
//           concatenatedList,
//           selectedValue,
//           "Select Companies",
//           checkcompany,
//           checkbranch,
//               (selectedValue) {
//             comapnycodelist = selectedValue;
//             print('Selected Values: $checkbranch');
//           },
//               (selectedValue) {
//             branchcodelist = selectedValue;
//
//             print('Selected Values: $branchcodelist');
//           },
//
//               () async {
//             try {
//               branchnumbers = branchcodelist.map((part) => int.parse(part.replaceAll('"', ''))).toList();
//               companynumbers = comapnycodelist.map((code) => int.parse(code)).toList();
//               await getsales(salesid);
//
//             } catch (error) {
//               print('API Error: $error');
//               Utils.snackBarred("Error to load data", context);
//               Navigator.of(context).pop(); // Close loading dialog
//             }
//           },
//
//         );
//       } catch (error) {
//         // Handle UI/dialogue box error
//         print('UI Error: $error');
//       }
//     });
//
//   }
//
//   Future<void> load(String code) async {
//     // setState(() {
//     //   heirarchyloader=true;
//     // });
//     await salesViewModel.initializeDatabase();
//
//     employeeList = await salesViewModel.designations();
//     // setState(() {
//     //   heirarchyloader=false;
//     // });
//     print("Datass: ${employeeList}");
//
//   }
//   Future<void> branchcompany() async {
//     await salesViewModel.initializeDatabase();
//     final data = await salesViewModel.fetchbranchdata();
//
//
//     setState( (){
//       branch=data;
//       for (final item in branch) {
//         String concatenatedString = "${item.BranchName} - ${item.BranchID}";
//         concatenatedListbranch.add(concatenatedString);
//         checkbranch.add(item.ischecked);
//       }} );
//   }
//   Future<void> teamcompany() async {
//
//     await salesViewModel.initializeDatabase();
//     final data = await salesViewModel.fetchdata();
//
//     setState(() {
//       team=data;
//       for (final item in team) {
//         String concatenatedString = "${item.companyID} - ${item.companyName}";
//         concatenatedList.add(concatenatedString);
//         concatenatedcode.add(item.companyName);
//         checkcompany.add(item.ischecked);
//       }});
//   }
//   Future<void> _loadUserDetails(String reporting, String repto) async {
//
//     await salesViewModel.initializeDatabase();
//     final data = await salesViewModel.select(reporting, repto);
//     setState(() {
//
//       userDetailsList =data;
//
//
//     });
//     print("Data: ${data}");
//     // Convert the fetched data to a hierarchical tree structure
//     //_buildTree();
//   }
//
//   Future<void> getsales(String empcode) async {
//     setState(() {
//       startDateFormatted = DateFormat('yyyy,MM,dd').format(startDate!);
//       endDateFormatted = DateFormat('yyyy,MM,dd').format(endDate!);
//       formattedStartDate = startDateFormatted!; // Assign to formatted variable
//       formattedEndDate = endDateFormatted!;
//       isloading = true;
//     });
//     try {
//       apiResponseList = await SalesRepository().fetchData(
//           empcode,
//           formattedStartDate,
//           formattedEndDate,
//           companynumbers,
//           branchnumbers,
//           selectedmeasures);
//
//       setState(() {
//         totals = 0;
//         for (int i = 0; i < apiResponseList.length; i++) {
//           double salesValue = apiResponseList[i]['Sales_Inc_ST'] ?? 0;
//           totals += salesValue.round();
//         }
//         totalsale = formatter.format(totals);
//       });
//       setState(() {
//         isloading = false;
//       });
//     }
//     catch (e, stackstarce) {
//       Utils.toastMessage(e.toString());
//       setState(() {
//
//         apiResponseList = [];
//         isloading = false;
//       });
//       print(stackstarce);
//       print(e.toString());
//     }
//   }
//
//
//   Widget _buildDataRow(String heading, String value) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       margin: EdgeInsets.symmetric(vertical: 5),
//       decoration: BoxDecoration(
//         // color: AppColors.primary.withOpacity(0.02),
//           borderRadius: BorderRadius.circular(8)
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 5,
//             child: Text(
//               '$heading:',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 14,
//               ),
//
//             ),
//           ),
//
//           Expanded(
//             flex: 5,
//             child: Text(
//               value,
//               style: TextStyle(
//                 color: AppColors.primary,
//                 fontSize: 14,
//
//
//               ),
//             ),
//           ),
//         ],
//       ),
//
//     );
//   }
//   final dsfMeasureRepository = dsf_measure_Repository();
//   List<DsfMeasureModel>  data= [];
//   bool dsfLoading = false;
//   Future<List<DsfMeasureModel>> fetchData(String dsfCode) async {
//
//     try {
//       data = await dsfMeasureRepository.fetchData(
//         formattedStartDate,
//         formattedEndDate,
//         int.parse(dsfCode),
//       );
//
//       return data;
//     } catch (e, stack) {
//       print('stack: $stack');
//       print('Error fetching data: $e');
//       throw e;
//     }
//   }
//   String formatNumber(String? number) {
//     if (number == null || number.isEmpty) {
//       return 'N/A';
//     }
//
//     double? parsedNumber = double.tryParse(number);
//
//     if (parsedNumber == null) {
//       return 'Invalid number';
//     }
//
//
//     parsedNumber = double.parse(parsedNumber.toStringAsFixed(0));
//
//     final numberFormat = NumberFormat('#,##');
//     return numberFormat.format(parsedNumber);
//   }
//
//
//
//
//   void bottomsheet(BuildContext context, String code, String name) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//       ),
//       builder: (context) {
//         DateTime currentDate = DateTime.now();
//         int currentDayNumber = currentDate.day -1;
//         DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
//         int daysDifference = currentDate.difference(firstDayOfMonth).inDays + 1;
//         double timeline_percent= (currentDayNumber/daysDifference)*100;
//
//         return
//           SizedBox(
//               height: MediaQuery.of(context).size.height * 0.85, // 90% of screen height
//               child:
//               SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   child:
//                   FutureBuilder<List<DsfMeasureModel>>(
//                     future: fetchData(code),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return  Column(
//
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Center(child: Padding(
//                                 padding: EdgeInsets.only(top: 320),
//                                 child: CircularProgressIndicator(color: AppColors.greencolor,)),),
//                           ],
//                         );
//                       } else if (snapshot.hasError) {
//                         return Center(
//                           child: Text(
//                             'Error: ${snapshot.error}',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         );
//                       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                         return Center(
//                           child: Text(
//                             'No data available.',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 16,
//                               fontStyle: FontStyle.italic,
//                             ),
//                           ),
//                         );
//                       } else {
//                         List<DsfMeasureModel> data = snapshot.data!;
//                         var dsfachieve= data[0].DSFTarget_Value - data[0].DSFTarget_Remaining;
//                         var productiveachieve= (data[0].productiveCustomer! * 100) / data[0].safCustomer;
//                         double targetValue = double.parse(data[0].DSFTarget.replaceAll('%', ''));
//                         return
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 // Close button
//
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Container(), // Left side empty space
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.all(8),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(15),
//                                         gradient: LinearGradient(
//                                           colors: [AppColors.primary, AppColors.greencolor],
//                                           begin: Alignment.topLeft,
//                                           end: Alignment.bottomRight,
//                                         ),
//                                       ),
//                                       child: Text(
//                                         name,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         alignment: Alignment.topRight, // Close button right pe
//                                         child: IconButton(
//                                           icon: Container(
//
//                                               decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(20),
//                                                   color: AppColors.white),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(0.0),
//                                                 child: Icon(Icons.close, color: AppColors.primary),
//                                               )),
//                                           onPressed: () {
//                                             Navigator.pop(context); // Close the bottom sheet
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 20,),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Center(
//                                       child: Container(
//                                           height:50,
//                                           child: MyProgressBar(animation: timeline_percent ,)),
//                                     ),
//
//                                   ],
//                                 ),
//                                 SizedBox(height: 40,),
//                                 Row(
//
//                                   // mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//
//
//                                       Text("                  Dsf Target",style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue[900]),   textAlign: TextAlign.center,),
//                                       SizedBox(width: 20,),
//                                       Text("                    Productive Customer",style: TextStyle(fontWeight: FontWeight.w500, color: Colors.green[900]) , textAlign: TextAlign.center),
//                                     ] ),
//                                 Container(
//                                   height: 150,
//                                   child: Row(
//                                     // mainAxisAlignment: MainAxisAlignment.start,
//                                     // crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//
//                                       Flexible(
//                                           flex: 5,
//                                           child:
//                                           speedcaart(achievement: dsfachieve, color: AppColors.primary, dsf_target: true, targetValue: targetValue,target: data[0].DSFTarget_Value,)
//
//                                       ),
//
//                                       Flexible(
//                                           flex: 5,
//                                           child:
//                                           speedcaart2(achievement: productiveachieve.toString() !="NaN" ? productiveachieve : 0, color: Colors.green[700]!, dsf_target: false,)
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//
//                                 if (data[0].productiveCustomer ==0 && data[0].Non_Productive_Customers == 0)
//                                   Container(),
//                                 if (data[0].productiveCustomer !=0 || data[0].Non_Productive_Customers != 0)
//                                   Column(
//                                     children: [
//                                       Text("Productive vs Non Productive", style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.greencolor),),
//                                       SizedBox(height: 20),
//                                       PieChart(
//                                         dataMap: {
//                                           "Productive" :data[0].productiveCustomer!.toDouble(),
//                                           "Non Productive" : data[0].Non_Productive_Customers!.toDouble()
//                                         },
//                                         animationDuration: Duration(milliseconds: 3500),
//                                         chartLegendSpacing: 30,
//                                         chartRadius: MediaQuery.of(context).size.width / 3.5,
//                                         initialAngleInDegree: 0,
//                                         chartType: ChartType.ring,
//                                         ringStrokeWidth: 30,
//                                         colorList: [
//                                           ColorTween(begin: AppColors.primary, end: AppColors.primary).lerp(0.5)!,
//                                           ColorTween(begin: Color(0xfff51604), end: Color(0xfff51604)).lerp(0.5)!,
//                                         ],
//                                         legendOptions: LegendOptions(
//                                           showLegendsInRow: false,
//                                           legendPosition: LegendPosition.right,
//                                           showLegends: true,
//                                           legendTextStyle: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 12,
//                                             color: AppColors.primary,
//                                           ),
//                                         ),
//                                         chartValuesOptions: ChartValuesOptions(
//                                           showChartValueBackground: true,
//                                           showChartValues: true,
//                                           showChartValuesInPercentage: false,
//                                           showChartValuesOutside: false,
//                                           decimalPlaces: 1,
//                                           chartValueStyle: TextStyle(
//                                             fontSize: 12,
//                                             color: AppColors.greencolor,
//                                             fontWeight: FontWeight.normal,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 SizedBox(height: 20),
//
//                                 // Expanded(
//                                 //   child:
//                                 ListView.builder(
//                                   physics: NeverScrollableScrollPhysics(),
//                                   shrinkWrap: true,
//                                   itemCount: data.length,
//                                   itemBuilder: (context, index) {
//                                     var item = data[index];
//                                     return Padding(
//                                       padding: const EdgeInsets.all(1.0),
//                                       child:
//                                       Column(
//                                         children: [
//                                           _buildDataRow('DSF SAF BusinessLine', item.dsfSafBusinessLine),
//                                           _buildDataRow('SAF Customer', item.safCustomer.toString()),
//                                           _buildDataRow('Productive Customer', item.productiveCustomer.toString()), _buildDataRow('Non Productive Customer', item.Non_Productive_Customers.toString()),
//                                           _buildDataRow('Eco Percentage', item.ecoPercentage),
//                                           _buildDataRow('First Order', item.firstOrder != null ? DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(item.firstOrder!)) : 'N/A',),
//                                           _buildDataRow('Last Order', item.lastOrder != null ? DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(item.lastOrder!)) : 'N/A'),
//                                           _buildDataRow('Duration', "${item.duration.toString()} Hours"),
//                                           _buildDataRow('Order Quantity', formatNumber(item.Order_Quantity.toString())),
//                                           _buildDataRow('Order Value', formatNumber(item.Order_Value.toString())),
//                                           _buildDataRow('Avg Sku Per Bill', item.avgSkuPerBill?.toStringAsFixed(2) ?? '0.00'),
//                                           _buildDataRow('DSF Target Value', formatNumber(item.DSFTarget_Value.toString())),
//                                           _buildDataRow('DSFTarget %', item.DSFTarget.toString()),
//                                           _buildDataRow('DSF Target Remaining', formatNumber(item.DSFTarget_Remaining.toString())),
//                                           _buildDataRow('DSF Target Expected Landing', formatNumber(item.DSFTarget_Expected_Landing.toString())),
//                                           _buildDataRow('DSF Target Per Day Required', formatNumber(item.DSFTarget_Per_Day_Required.toString())),
//                                           _buildDataRow('DSF Target Days Remaining', item.DSFTargetDaysDSFRemaining.toString()),
//
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 //),
//                               ],
//                             ),
//                           );
//
//                       }
//                     },
//                   )
//               )
//           );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       WillPopScope(
//         onWillPop: () async {
//           return await Exit.showExitDialog(context);
//         },
//         child:
//         heirarchyloader ?
//         Container()
//             :
//
//         Scaffold(
//             appBar:
//             CustomAppBar(
//               title: 'Team Analysis',
//
//               actions: [
//                 Icon(Icons.abc, color: AppColors.greencolor,),
//                 if(showsales == true)
//                   MyPopupMenu(
//                     menuItems: [
//                       MenuItem(
//                         text: 'Share',
//                         icon: Icons.share,
//                         value: 'share',
//                         onTap: () {
//                           print('Share selected');
//                           // Add your custom action here
//                         },
//                       ),
//                       MenuItem(
//                           text: 'Measures',
//                           icon: Icons.filter_list,
//                           value: 'measures',
//                           onTap: () {
//
//                           }
//                       ),
//                       MenuItem(
//                         text: 'Filters',
//                         icon: Icons.filter_list,
//                         value: 'filters',
//                         onTap: () {
//                           print('Filters selected');
//                           // Add your custom action here
//                         },
//                       ),
//                       MenuItem(
//                         text: sortwithzero == false ? 'With 0s' : 'Without 0s',
//                         // Correct use of ternary operator
//                         icon: Icons.list,
//                         value: 'zero',
//                         onTap: () {
//                           print(sortwithzero ? 'With 0s' : 'Without 0s');
//                           // Add your custom action here
//                         },
//                       )
//                     ],
//                     onSelected: (value) {
//                       if (value == "measures") {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return filters(
//                               onSelectionDone: (selectedValues) async {
//                                 setState(() {
//                                   selectedmeasures = selectedValues.toList();
//                                 });
//
//                                 DateFormat dateFormat = DateFormat(
//                                     'yyyy,MM,dd');
//                                 formattedStartDate =
//                                     dateFormat.format(startDate!);
//                                 formattedEndDate = dateFormat.format(endDate!);
//                                 await getsales(salesid);
//                                 setState(() {
//                                   apiResponseList = apiResponseList;
//                                 });
//                               },
//                               selectedvalues: selectedmeasures,
//                             );
//                           },
//                         );
//                       }
//
//                       if (value == 'share') {
//                         String combinedMessage = "Start Date: $formattedStartDate\nEnd Date: $formattedEndDate\n\n";
//
//                         for (int i = 0; i < apiResponseList.length; i++) {
//                           if (apiResponseList[i]['EmpCode'].isNotEmpty) {
//                             String name = apiResponseList[i]['EmpName'];
//                             String id = apiResponseList[i]['EmpCode']
//                                 .toString();
//                             String sale = NumberFormat('#,###').format(
//                                 double.parse(apiResponseList[i]['Sales_Inc_ST']
//                                     ?.toString()
//                                     ?.replaceAll(',', '') ?? '0'));
//                             sale = sale.isEmpty ? '0' : sale;
//
//                             String measure = ''; // Reset measure for each iteration
//                             measure +=
//                                 List.generate(selectedmeasures.length, (index) {
//                                   final measure = selectedmeasures[index];
//                                   final teamValue = apiResponseList[i][measure
//                                       .toString().replaceAll(' ', '_')];
//                                   final formattedValue = teamValue != null
//                                       ? (measure.endsWith('%') ? teamValue
//                                       .toString() : formatter.format(teamValue)
//                                       .toString())
//                                       : '0';
//                                   return "$measure: $formattedValue";
//                                 },
//                                 ).join('\n');
//
//
//                             combinedMessage +=
//                             "Name: $name\nID: $id\nSale: $sale\n$measure\n\n";
//                           }
//                         }
//
//                         Share.share(
//                             combinedMessage, subject: 'Sales Information');
//                       }
//
//                       if (value == "filters") {
//                         showfitler();
//                       }
//
//                       if (value == "zero") {
//                         setState(() {
//                           sortwithzero = !sortwithzero;
//                         });
//                       }
//                     },
//
//                   ),
//
//               ],
//             ),
//             drawer: CustomDrawer(),
//             body:
//
//
//             isloading
//                 ? shimmer_effect(
//               isLoading: isloading, selectedmeasures: selectedmeasures,)
//
//                 :
//
//
//             Stack(
//                 children: [
//                   SizedBox(height: 20,),
//                   Column(
//                       children: [
//                         TotalSalesCard(totalSale: totalsale.toString(),
//                           title: 'Total Sales',),
//                         if(showsales == true)
//                           SizedBox(height: 30,),
//
//                         Expanded(child:
//                         Container(
//                             padding: EdgeInsets.symmetric(horizontal: 14.0),
//
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: 25,),
//
//
//                                   Container(
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(width: 1, color: AppColors.primary),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         InkWell(
//                                           onTap: () {
//                                             setState(() {
//                                               showsales = false;
//                                               totalsale = '0';
//
//                                               rootlist.clear();
//                                               load(empcode.auth);
//                                             });
//                                           },
//                                           child: Container(
//                                             height: 40,
//                                             width: 50,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                             alignment: Alignment.center,
//                                             child: Text(
//                                               'Root',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: SingleChildScrollView(
//                                             physics: BouncingScrollPhysics(),
//                                             scrollDirection: Axis.horizontal,
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(0.0),
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                                 children: rootlist.toSet().toList().asMap().map((index, stackItem) {
//
//                                                   if (index == rootlist.length - 1) {
//                                                     salesid = stackItem.empCode;
//                                                   }
//                                                   final stackItemTitle = UserDetails(
//                                                       empName: stackItem.empName,
//                                                       empCode: stackItem.empCode,
//                                                       reportingTo: stackItem.reportingTo,
//                                                       designation: stackItem.designation,
//                                                       isCheck: false
//                                                   ).empName;
//                                                   final stackItemdes = UserDetails(
//                                                       empName: stackItem.empName,
//                                                       empCode: stackItem.empCode,
//                                                       reportingTo: stackItem.reportingTo,
//                                                       designation: stackItem.designation,
//                                                       isCheck: false
//                                                   ).designation;
//
//                                                   return MapEntry(
//                                                     index,
//                                                     Padding(
//                                                       padding: const EdgeInsets.symmetric(horizontal: 0),
//                                                       child: Row(
//                                                         children: [
//                                                           Container(
//                                                             width: 80,
//                                                             decoration: BoxDecoration(
//                                                               color: index == rootlist.length - 1
//                                                                   ? AppColors.primary
//                                                                   : Colors.white,
//                                                               borderRadius: BorderRadius.circular(6),
//                                                             ),
//                                                             child: GestureDetector(
//                                                               onTap: () async {
//                                                                 // _loadUserDetails(stackItem.empCode, stackItem.reportingTo);
//                                                                 //employeeList = salesViewModel.search(stackItem.empCode);
//                                                                 // load(stackItem.empCode, stackItem.reportingTo);
//                                                                 setState(() {
//                                                                   showsales = false;
//                                                                   totalsale = '0';
//                                                                   rootlist.removeRange(index + 1, rootlist.length);
//                                                                   showsales = false;
//                                                                 });
//                                                               },
//                                                               child: Padding(
//                                                                 padding: const EdgeInsets.all(2.0),
//                                                                 child: Column(
//                                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                                   children: [
//                                                                     Text(
//                                                                       stackItemTitle,
//                                                                       style: TextStyle(
//                                                                         fontSize: 10,
//                                                                         fontWeight: index == rootlist.length - 1
//                                                                             ? FontWeight.w600
//                                                                             : FontWeight.normal,
//                                                                         color: index == rootlist.length - 1
//                                                                             ? Colors.white
//                                                                             : Colors.black,
//                                                                       ),
//                                                                       textAlign: TextAlign.center,
//                                                                       overflow: TextOverflow.ellipsis,
//                                                                     ),
//                                                                     SizedBox(height: 3),
//                                                                     Text(
//                                                                       '$stackItemdes',
//                                                                       style: TextStyle(
//                                                                         fontSize: 11,
//                                                                         color: index == rootlist.length - 1
//                                                                             ? Colors.white
//                                                                             : Colors.black,
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   );
//                                                 }).values.toList().reversed.toList(),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//
//                                   if (showsales == true)
//                                     SizedBox(height: 16),
//                                   if(showsales == true)
//
//
//                                           Container(
//                                             color: AppColors.primary.withOpacity(0.2),
//                                             height: 120,
//                                             child: Row(
//                                               children: [
//                                                 Flexible(
//
//                                                     child:
//                                                     speedcaart(achievement: 34, color: AppColors.primary, dsf_target: true, targetValue: 76,target: 32,)
//
//                                                 ),
//
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(left: 10),
//                                                   child: PieChart(
//                                                       dataMap: {
//                                                         "Productive" :45,
//                                                         "Non Productive" : 67
//                                                       },
//                                                       animationDuration: Duration(milliseconds: 3500),
//                                                       chartLegendSpacing: 15,
//                                                       chartRadius: MediaQuery.of(context).size.width / 4.3,
//                                                       initialAngleInDegree: 0,
//                                                       chartType: ChartType.ring,
//                                                       ringStrokeWidth: 11,
//                                                       colorList: [ ColorTween(begin: AppColors.primary, end: AppColors.primary).lerp(0.5)!, ColorTween(begin: Color(0xfff51604), end: Color(0xfff51604)).lerp(0.5)! ],
//                                                       legendOptions: LegendOptions(
//                                                         showLegendsInRow: false,
//                                                         legendPosition: LegendPosition.right,
//                                                         showLegends: true,
//                                                         legendTextStyle: TextStyle(
//                                                           fontWeight: FontWeight.w500,
//                                                           fontSize: 12,
//                                                           color: AppColors.primary,
//                                                         ),
//                                                       ),
//                                                       chartValuesOptions: ChartValuesOptions(
//                                                         showChartValueBackground: true,
//                                                         showChartValues: true,
//                                                         showChartValuesInPercentage: false,
//                                                         showChartValuesOutside: false,
//                                                         decimalPlaces: 1,
//                                                         chartValueStyle: TextStyle(
//                                                           fontSize: 11,
//                                                           color: AppColors.greencolor,
//                                                           fontWeight: FontWeight.normal,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                 ),
//
//
//                                               ],
//                                             ),
//                                           ),
//
//
//
//
//
//
//
//                                   //SizedBox(height: 26.0),
//                                   if (showsales == false)
//
//                                     (employeeList != null)
//                                         ?
//
//                                     Expanded(
//                                       child:
//                                         ListView.builder(
//                                             itemCount: employeeList.length,
//                                             itemBuilder: (BuildContext context, index)
//
//
//                                         {
//                                           int? selectedIndex;
//                                           var datalist=employeeList[index];
//
//                                           return Container(
//                                             padding: EdgeInsets.all(8),
//                                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//                                             child:  InkWell(
//                                               onTap: () async {
//                                                 // setState(() {
//                                                 // });
//
//                                                 datalist.isCheck =! datalist.isCheck;
//                                                 if(datalist.isCheck ==true)
//                                                   {
//                                                     selectedIndex =index;
//                                                     await salesViewModel.initializeDatabase();
//                                                     datalist.reports =  salesViewModel.select_through_depth(datalist.Depth.toString());
//                                                   }
//                                                 else {
//                                                   //depthList.clear();
//                                                 }
//                                                   setState(() {
//                                                 });
//                                               },
//                                               child:
//                                               Column(
//                                                 children: [
//                                                  // if(employeeList[0])
//                                                   Row(children: [
//
//                                                     Container(
//                                                       padding: EdgeInsets.all(6),
//                                                       decoration: BoxDecoration(
//                                                         borderRadius: BorderRadius.circular(16),
//                                                         color: datalist.isCheck ? AppColors.greencolor : AppColors.primary,
//                                                       ),
//                                                       child: Icon(
//                                                         datalist.isCheck ? Icons.remove: Icons.add,
//                                                         size: 13,
//                                                         color: Colors.white,
//                                                       ),
//                                                     ),
//                                                     SizedBox(width: 5,),
//
//                                                     // Text(empcode.name),
//                                                     // SizedBox(width: 5,),
//                                                     Text(datalist.designation,style: TextStyle(fontWeight: datalist.isCheck ? FontWeight.bold : null, color: AppColors.greencolor),),
//                                                     SizedBox(width: 5,),
//
//                                                   ],),
//                                               SizedBox(height: 10,),
//                                               if(datalist.isCheck)
//
//                                                 FutureBuilder<List<UserDetails>>(
//                                                   future: datalist.reports,
//                                                   builder: (context, snapshot) {
//                                                     if (snapshot.connectionState == ConnectionState.waiting) {
//                                                       return Container();
//                                                     }
//
//                                                     if (snapshot.hasError) {
//                                                       return Center(child: Text('Error: ${snapshot.error}'));
//                                                     }
//
//                                                     if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                                                       return Center(
//                                                         child: Text(
//                                                           '',
//                                                           style: TextStyle(
//                                                             fontSize: 16,
//                                                             fontWeight: FontWeight.bold,
//                                                             color: Colors.grey,
//                                                           ),
//                                                         ),
//                                                       );
//                                                     }
//
//                                                     return InkWell(
//                                                       onTap: (){
//                                                         buildUserTile(datalist);
//                                                       },
//                                                       child: Padding(
//                                                         padding: const EdgeInsets.only(left: 0),
//                                                         child: Column(
//                                                           children: datalist.isCheck
//                                                               ? snapshot.data!.map((report) => Padding(
//                                                             padding: const EdgeInsets.only(left: 17),
//                                                             child: buildUserTile(report),
//                                                           )).toList()
//                                                               : [],
//                                                         ),
//                                                       ),
//                                                     );
//                                                   },
//                                                 ),
//                                                 ],
//                                               ),
//
//                                               ),
//
//
//                                           );
//
//                                         }
//                                         )
//
//                                     )
//                                         : Container(
//                                       height: 400,
//                                       child: Nodata(),
//                                     ),
//                                   if ( showsales == true )
//
//                                     SalesListView(
//                                       sortdata: sortwithzero == false
//                                           ? 'With Zero'
//                                           : 'Without Zero',
//                                       apiResponseList: apiResponseList,
//
//                                       customCardWidget: (data) {
//                                         return
//                                           HeirarchyCard(
//                                               personwise: true,
//                                               title: data['EmpName'].toString(),
//                                               date: data['EmpCode'].toString(),
//                                               amount: data['Sales_Inc_ST']
//                                                   .toString(),
//                                               color: AppColors.greencolor,
//                                               designation: data['EmpDesignation']
//                                                   .toString(),
//                                               kpionTap: () {
//                                                 bottomsheet(
//                                                     context, data['EmpCode'],
//                                                     data['EmpName']);
//                                               },
//                                               route: () {
//                                                 Navigator.push(context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             MapScreen(
//                                                               dsfcode: data['EmpCode']
//                                                                   .toString(),
//                                                               date: endDateFormatted
//                                                                   .toString(),
//                                                               name: data['EmpName']
//                                                                   .toString(),
//                                                               code: data['EmpCode']
//                                                                   .toString(),)));
//                                                 //dsf_route(context);
//                                               },
//                                               onTap: () async
//                                               {
//                                                 if (data['EmpDesignation'] ==
//                                                     "DSF") {
//                                                   salesViewModel
//                                                       .showCustomerWiseDialog(
//                                                       context,
//                                                       data['EmpCode'],
//                                                       formattedStartDate,
//                                                       formattedEndDate,
//                                                       data['EmpName'],
//                                                       companynumbers,
//                                                       branchnumbers,
//                                                       selectedmeasures);
//                                                 }
//                                                 if (data['EmpDesignation'] !=
//                                                     "DSF") {
//                                                   await getsales(
//                                                       data['EmpCode']);
//                                                   setState(() {
//                                                     rootlist.add(
//                                                       UserDetails(
//                                                           empCode: data['EmpCode'],
//                                                           empName: data['EmpName'],
//                                                           reportingTo: data['ReportTo'],
//                                                           designation: data['EmpDesignation'],
//                                                           isCheck: false),
//                                                     );
//                                                   });
//                                                 }
//                                               },
//
//                                               showsale: showsales,
//                                               selectedmeasures: selectedmeasures,
//                                               item: data,
//                                               saleonTap: () {}
//
//                                           );
//                                       },
//                                     ),
//
//
//                                 ])))
//                       ]),
//
//
//                   if(showsales == true)
//                     Positioned(
//                         top: 130,
//                         right: 0,
//                         left: 0,
//
//                         child:
//                         DateRangeSelector(
//                           startDate: startDate,
//                           endDate: endDate,
//                           showDateContainers: true,
//                           onStartDateSelected: (date) {
//                             setState(() {
//                               startDate = date;
//                               // Print the selected start date
//                               print("Start Date selected: $startDate");
//
//                               // Check if the start date is valid
//                               if (startDate!.isAfter(endDate!)) {
//                                 // Show an error message to the user using a Snackbar
//                                 Utils.toastMessage(
//                                     "Start date cannot be after the end date");
//                               } else {
//                                 // Only call API if startDate is before or equal to endDate
//                                 getsales(salesid);
//                               }
//                             });
//                           },
//                           onEndDateSelected: (date) {
//                             setState(() {
//                               endDate = date;
//                               // Print the selected end date
//                               print("End Date selected: $endDate");
//
//                               // Check if the end date is valid
//                               if (endDate!.isBefore(startDate!)) {
//                                 // Show an error message to the user using a Snackbar
//                                 Utils.toastMessage(
//                                     "End date cannot be before the start date");
//                               } else {
//                                 // Only call API if endDate is after or equal to startDate
//                                 getsales(salesid);
//                               }
//                             });
//                           },
//                         )
//
//                     ),
//                 ]
//             )
//         ),
//       );
//   }}



class Team_analysis extends StatefulWidget {
  @override
  State<Team_analysis> createState() => _Team_analysisState();
}


  class _Team_analysisState extends State<Team_analysis> {
  @override

  final salesViewModel = SalesHeirarchyViewModel();
  bool isDropdownOpen = false;
  List<UserDetails> userDetailsList = [];
  bool showDateContainers=false;
  bool sortwithzero=false;
  List<UserDetails> rootlist = [];
  List<dynamic> apiResponseList =[];
  String dsftarget ='';
  String loadvalue ='';
  List<int> companynumbers=[];
  String sale='';
  List<Team_compnay> team = [];
  List<Branch_compnay> branch = [];
  String salesid=empcode.auth;
  String designation=empcode.designation;
  DateTime? startDate=  DateTime( DateTime.now().year, DateTime.now().month, 1 );
  DateTime? endDate= DateTime.now();
  String? startDateFormatted;
  String? endDateFormatted;
  List<String> concatenatedList = [];
  List<String> concatenatedListbranch = [];
  List<String> concatenatedcode = [];
  List<String> selectedValue=[];
  bool padding=false;
  List<bool> checkcompany = [];
  List<bool> checkbranch = [];
  List<bool> checkcbranch = [];
  String formattedStartDate='';
  String formattedEndDate='';
  List<int> branchnumbers=[];
  List<String> comapnycodelist=[];
  List<String> branchcodelist=[];
  List<DsfMeasureModel> dsftargetlist=[];
  var filteredSalesData;
  var dsfachieve;
  bool showsales=false;
  List<String> selectedmeasures=[];
  double achievementpercentage=0;
  String totalsale='';
  int totals=0;
  final formatter = NumberFormat('#,###');
  bool heirarchyloader=false;
  bool isloading = false;
  bool node=false;
  List<Map<String,dynamic>> achieve=[];
  String? selectedregion;
  var correspondingAchieve;
  List<String> options = ["All",'Centeral', 'North', 'South', 'Karachi'];
  var lastSelectedEmpCode;
  List<UserDetails>  employeeList=[];
  List<UserDetails>  depthList=[];
  bool eco=false;
  @override

  void initState(){
    load(empcode.auth);
    getsales(empcode.auth,empcode.designation);
    totalsale="0";
    setState(() {
      startDateFormatted = DateFormat('yyyy,MM,dd').format(startDate!);
      endDateFormatted = DateFormat('yyyy,MM,dd').format(endDate!);
      formattedStartDate = startDateFormatted!;  // Assign to formatted variable
      formattedEndDate = endDateFormatted!;      // Assign to formatted variable
      print("date ${startDateFormatted}");
    });
    final repository = measure_repository();
    repository.getAllMeasures();
    super.initState();
    teamcompany();
    branchcompany();
  }



  Widget buildUserTile(UserDetails user) {
    return
      Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical:0),
          child: Container(
            padding: EdgeInsets.all(8),


         //borderRadius: BorderRadius.circular(8),
         //color: user.isCheck ? AppColors.greencolor.withOpacity(0.2) : AppColors.primary.withOpacity(0.2),),
            child: InkWell(
              onTap: () async {
                if (user.designation == "SUP") {
                  if (!rootlist.any((item) => item.empCode == user.empCode)) {
                    rootlist.add(
                      UserDetails(
                        empCode: user.empCode,
                        empName: user.empName,
                        reportingTo: user.reportingTo,
                        designation: user.designation,
                        isCheck: user.isCheck,
                      ),
                    );
                  }
                  showsales = true;
                  getsales(user.empCode,user.designation);
                 // getdsftarget(user.empCode, formattedStartDate,formattedEndDate);


                }
                else {
                  setState(() {
                    lastSelectedEmpCode = user.empCode;
                    bool alreadyExists = rootlist.any((item) => item.empCode == user.empCode);

                    if (!alreadyExists) {
                      rootlist.add(
                        UserDetails(
                          empCode: user.empCode,
                          empName: user.empName,
                          reportingTo: user.reportingTo,
                          designation: user.designation,
                          isCheck: user.isCheck,
                        ),
                      );
                    }


                    rootlist = rootlist.toSet().toList();


                    user.reports = salesViewModel.select(user.empCode, '0');
                    user.isCheck = !user.isCheck;
                    if(!user.isCheck)
                    {
                      int index = rootlist.indexWhere((item) => item.empCode == user.empCode);
                      if(user.empCode == "99938")
                      {
                        rootlist.clear();
                      }

                      else {
                        if (index != -1) {

                          rootlist.removeRange(index, rootlist.length);
                          print("Removed items from index ${index + 1} onwards");
                        }
                      }
                      rootlist.removeWhere((item) => item.empCode == user.empCode);
                      print("User removed: ${user.empCode}");

                      //rootlist.remove(value);
                      print("object");
                      lastSelectedEmpCode = index == rootlist.length - 1;
                    }
                  });

                }
              },
              child: Row(
                children: [
                  if (user.designation != "SUP")
                    Container(

                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(16),
                        color: user.isCheck ? AppColors.greencolor : AppColors.primary,
                      ),
                      child: Icon(
                        user.isCheck ? Icons.remove: Icons.add,
                        size: 13,
                        color: Colors.white,
                      ),
                    ),
                  SizedBox(  width: 8  ),
                  if ( user.designation == "SUP" ) SizedBox( width: 28 ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user.empName.split("||")[0]} (${user.empCode})",
                          style:TextStyle(
                            color: (user.isCheck)
                                ? AppColors.greencolor
                                : AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),

                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),


                     if(user.empName !="Untagged")
                        Row(
                          children: [
                            Text(user.empName.split("||")[1]),
                            Text(", "),
                            Text(user.empName.split("||")[2]),
                          ],
                        ),
                        Text(user.designation)
                      ],
                    ),
                  ),
                  if(user.isCheck == false)
                    InkWell(
                      onTap: () {
                        setState(() {
                          bool alreadyExists = rootlist.any((item) => item.empCode == user.empCode);

                          if (!alreadyExists) {

                            rootlist.add(
                              UserDetails(
                                empCode: user.empCode,
                                empName: user.empName,
                                reportingTo: user.reportingTo,
                                designation: user.designation,
                                isCheck: user.isCheck,
                              ),
                            );
                          }


                          rootlist = rootlist.toSet().toList();
                          showsales = true;
                           getsales(user.empCode, user.designation);
                          Future.delayed(Duration(seconds: 2), () {
                            getdsftarget(salesid, formattedStartDate, formattedEndDate);
                          });

                          user.reports = salesViewModel.select(user.empCode, '0');
                        });
                      },
                      child: Image.asset("assets/growth.png", height: 20, width: 20, color: AppColors.primary),
                    ),
                ],
              ),
            ),
          ),
        ),
        // Container(
        //   width: 500,
        //   height: 1,
        //   decoration: BoxDecoration(color: Colors.black),
        // ),
        // Divider(),
        FutureBuilder<List<UserDetails>>(
          future: user.reports,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Column(
                children: user.isCheck
                    ? snapshot.data!.map( (report) => Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: buildUserTile(report),
                ) ).toList( )
                    : [ ],
              ),
            );
          },
        ),
      ],
    );
  }
  void showfitler() async {

    await salesViewModel.initializeDatabase();
    await salesViewModel.fetchdata();
    await salesViewModel.fetchbranchdata();
    setState(() {
      try {
        salesViewModel.showDropdownCheckboxs(
          context,
          concatenatedListbranch,
          concatenatedList,
          selectedValue,
          "Select Companies",
          checkcompany,
          checkbranch,
              (selectedValue) {
            comapnycodelist = selectedValue;
            print('Selected Values: $checkbranch');
          },
              (selectedValue) {
            branchcodelist = selectedValue;

            print('Selected Values: $branchcodelist');
          },

              () async {
            try {
              branchnumbers = branchcodelist.map((part) => int.parse(part.replaceAll('"', ''))).toList();
              companynumbers = comapnycodelist.map((code) => int.parse(code)).toList();
              await getsales(salesid, designation);

            } catch (error) {
              print('API Error: $error');
              Utils.snackBarred("Error to load data", context);
              Navigator.of(context).pop(); // Close loading dialog
            }
          },

        );
      } catch (error) {

        print('UI Error: $error');
      }
    });
  }
  Future<void> load( String code ) async {

    await salesViewModel.initializeDatabase();

    employeeList = await salesViewModel.designations();

    print("Datass: ${employeeList}");

  }
  Future<void> branchcompany() async {
    await salesViewModel.initializeDatabase();
    final data = await salesViewModel.fetchbranchdata();


    setState(()
        {
      branch=data;
      for (final item in branch) {
        String concatenatedString = "${item.BranchName} - ${item.BranchID}";
        concatenatedListbranch.add(concatenatedString);
        checkbranch.add(item.ischecked);
      }
       });
  }
  Future<void> teamcompany() async {

    await salesViewModel.initializeDatabase();
    final data = await salesViewModel.fetchdata();

    setState(() {
      team=data;
      for (final item in team) {
        String concatenatedString = "${item.companyID} - ${item.companyName}";
        concatenatedList.add(concatenatedString);
        concatenatedcode.add(item.companyName);
        checkcompany.add(item.ischecked);
      }});
  }
  Future<void> loadUserDetails(String reporting, String repto) async {

    await salesViewModel.initializeDatabase();
    final data = await salesViewModel.select(reporting, repto);
    setState(() {

      userDetailsList =data;


    });
    print("Data: ${data}");

  }

  Future<void> getsales(String empcode, String designstion) async {
    setState(() {
      totalsale='0';
      startDateFormatted = DateFormat('yyyy,MM,dd').format(startDate!);
      endDateFormatted = DateFormat('yyyy,MM,dd').format(endDate!);
      formattedStartDate = startDateFormatted!;
      formattedEndDate = endDateFormatted!;
      isloading = true;
    });

    try {
      // Fetch initial data from the API
      apiResponseList = await SalesRepository().fetchData(
        empcode,
        formattedStartDate,
        formattedEndDate,
        companynumbers,
        branchnumbers,
        selectedmeasures,
        designstion,
      );
      achieve = [];
      try {
        if (designstion == "SUP") {

          List<Future> futureRequests = [];

          for (int i = 0; i < apiResponseList.length; i++) {

            futureRequests.add(
              dsfMeasureRepository.dsftargetvalue(
                formattedStartDate,
                formattedEndDate,
                apiResponseList[i]['EmpCode'],
              ).then((data) {
                dsftargetlist = data;

                for (int j = 0; j < dsftargetlist.length; j++) {
                  double targetValueString = dsftargetlist[j].DSFTarget_Value;

                  if (targetValueString != 0) {
                    achieve.add({
                      "achieve": ((apiResponseList[i]['Sales_Inc_ST'] * 100) / targetValueString).toString(),
                      "code": apiResponseList[i]['EmpCode'],
                    });
                    print("Achieve for EmpCode ${apiResponseList[i]['EmpCode']} at index $j: ${achieve.last}");
                  } else {
                    achieve.add({
                      "achieve": "0",
                      "code": apiResponseList[i]['EmpCode'],
                    });
                    print("Invalid target value at EmpCode ${apiResponseList[i]['EmpCode']} index $j: $targetValueString");
                  }
                }
              }).catchError((e) {
                // Handle errors during API call for each target value
                print("Error for EmpCode ${apiResponseList[i]['EmpCode']} at index $i: ${e.toString()}");
              }),
            );
          }

          // Wait for all future requests to complete
          await Future.wait(futureRequests);

          print("Achieve list after all requests: $achieve");


        }
      } catch (e, stack) {
        print("Error in getdsftarget: ${e.toString()}");
      }

      // Calculate total sales value
      setState(() {
        dsftarget = '';
        achievementpercentage = 0;
      });

      setState(() {
        totals = 0;
        for (int i = 0; i < apiResponseList.length; i++) {
          double salesValue = apiResponseList[i]['Sales_Inc_ST'] ?? 0;
          totals += salesValue.round();
        }
        totalsale = formatter.format(totals);
      });


      try {
        await getdsftarget(empcode, formattedStartDate, formattedEndDate);
      } catch (e) {
        print("Error in getdsftarget: ${e.toString()}");
      }

      setState(() {
        isloading = false;
      });
      print("apiresposnelist: ${apiResponseList.length}");
      print("dsftarget: ${achieve.length}");
    } catch (e, stacktrace) {
      Utils.toastMessage(e.toString());
      setState(() {
        apiResponseList = [];
        isloading = false;
      });
      print(stacktrace);
      print(e.toString());
    }
  }



  Future<void> getdsftarget(String code, String startdate, String enddate) async {
    try {
      Map<String,dynamic> data = await SalesRepository().getdsftarget(code, startdate, enddate);

      if (data.isNotEmpty) {
        double dsfTargetValue = data['DSF_Target'] ?? 0.0;
        double load = data['order_values'] ?? 0.0;
        dsftarget = formatter.format(dsfTargetValue);
        loadvalue=formatter.format(load);
        print("DSFTARGET: ${dsftarget}");
        print("sale: ${totals}");
        String totalsString = totals.toString();

        double totalSaleValue = double.parse(totalsString);

        setState(() {
          print("meri wali:${totalSaleValue}");
          achievementpercentage = (totalSaleValue * 100) / dsfTargetValue;
          print("total sale: ${totalSaleValue}");
          print("dsf target: ${dsfTargetValue}");
          print("achievementpercentage: ${achievementpercentage}");
        }
        );
      }
    }
    catch(e)
    {
      print(e.toString());
    }
}

  Widget _buildDataRow(String heading, String value, {bool nonpro=false}) {
    return
      Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        // color: AppColors.primary.withOpacity(0.02),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              '$heading:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),

            ),
          ),
if(nonpro==false)
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,


              ),
            ),
          ),
          if(nonpro==true)
          Expanded(
              flex: 5,
            child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,


                  ),),
                InkWell(
                  onTap: (){
                    },
                  child: Container(
                      padding:EdgeInsets.all(5),
                      decoration:
                      BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8)),
                      child:Text("View List", style: TextStyle(color: Colors.white),)
                  ),
                )
              ],
            ),
          )
        ],
      ),

    );
  }

  final dsfMeasureRepository = dsf_measure_Repository();
  List<DsfMeasureModel>  data= [];
  bool dsfLoading = false;
  Future<List<DsfMeasureModel>> fetchData(String dsfCode) async {
    try {
      data = await dsfMeasureRepository.fetchData(
        formattedStartDate,
        formattedEndDate,
        int.parse(dsfCode),
      );

      return data;
    }
    catch (e, stack)
    {
      print('stack: $stack');
      print('Error fetching data: $e');
      throw e;
    }
  }
  String formatNumber(String? number) {
    if (number == null || number.isEmpty)
    {
      return 'N/A';
    }

    double? parsedNumber = double.tryParse(number);

    if (parsedNumber == null) {
      return 'Invalid number';
    }


    parsedNumber = double.parse(parsedNumber.toStringAsFixed(0));

    final numberFormat = NumberFormat('#,###');
    return numberFormat.format(parsedNumber);
  }
  void bottomsheet(BuildContext context, String code, String name, String sale) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        DateTime currentDate = DateTime.now();
        int currentDayNumber = currentDate.day -1;
        DateTime firstDayOfNextMonth = DateTime(currentDate.year, currentDate.month + 1, 1);

        DateTime lastDayOfMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
        double timeline_percent = (currentDayNumber/lastDayOfMonth.day)*100;

        return
          StatefulBuilder(
            builder: (BuildContext context, setState) {
              return

          SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child:
              SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child:
                  FutureBuilder<List<DsfMeasureModel>>(
                    future: fetchData(code),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return  Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(child: Padding(
                                padding: EdgeInsets.only(top: 320),
                                child: CircularProgressIndicator(color: AppColors.greencolor,)),),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return
                          Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return
                          Center(
                          child: Text(
                            'No data available.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        );
                      } else {
                        List<DsfMeasureModel> data = snapshot.data!;
                        double sales = double.parse(sale.toString().replaceAll(',', ''));
                        var dsfachieve = (sales * 100) / data[0].DSFTarget_Value;
                        var productiveachieve= (data[0].productiveCustomer! * 100) / data[0].safCustomer;
                        double targetValue = double.parse(data[0].DSFTarget.replaceAll('%', ''));
                        return

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // Close button

                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(), // Left side empty space
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            gradient: LinearGradient(
                                              colors: [AppColors.primary, AppColors.greencolor],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Text(
                                            name.split("||")[0],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text( "${name.split("||")[1] }, ${name.split("||")[2]}", style: TextStyle(color: AppColors.greencolor, fontSize: 12, fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topRight, // Close button right pe
                                        child: IconButton(
                                          icon: Container(

                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: AppColors.white),
                                              child: Padding(
                                                padding: const EdgeInsets.all(0.0),
                                                child: Icon(Icons.close, color: AppColors.primary),
                                              )),
                                          onPressed: () {
                                            Navigator.pop(context); // Close the bottom sheet
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                          height:50,
                                          child: MyProgressBar(animation: timeline_percent ,)),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 40,),
                                Row(
                                    children:
                                    [
                                      Text("                  Dsf Target" ,style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue[900]),   textAlign: TextAlign.center,),
                                      SizedBox(width: 20,),
                                      Text( "                    Productive Customer" ,style: TextStyle(fontWeight: FontWeight.w500, color: Colors.green[900]) , textAlign: TextAlign.center),
                                    ]
                                  ),
                                Container(
                                  height: 150,
                                  child: Row(

                                    children: [

                                      Flexible(
                                          flex: 5,
                                          child:
                                          speedcaart(achievement: sales, color: AppColors.primary, dsf_target: true, targetValue: dsfachieve,target: data[0].DSFTarget_Value,)

                                      ),
                                      Flexible(
                                          flex: 5,
                                          child:
                                          speedcaart2(achievement: productiveachieve.toString() !="NaN" ? productiveachieve : 0, color: Colors.green[700]!, dsf_target: false,)
                                      ),

                                    ],
                                  ),
                                ),

                                if (data[0].productiveCustomer ==0 && data[0].Non_Productive_Customers == 0)
                                  Container( ),
                                if (data[0].productiveCustomer !=0 || data[0].Non_Productive_Customers != 0)
                                  Column(
                                    children: [
                                      Text("Productive vs Non Productive", style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.greencolor),),
                                      SizedBox(height: 20),
                                      PieChart(
                                        dataMap:
                                            {
                                          "Productive" :data[0].productiveCustomer!.toDouble(),
                                              "Non Productive" : data[0].Non_Productive_Customers!.toDouble()
                                            },
                                        animationDuration: Duration(milliseconds: 3500),
                                        chartLegendSpacing: 30,
                                        chartRadius: MediaQuery.of(context).size.width / 3.5,
                                        initialAngleInDegree: 0,
                                        chartType: ChartType.ring,
                                        ringStrokeWidth: 30,
                                        colorList: [
                                          ColorTween(begin: AppColors.primary, end: AppColors.primary).lerp(0.5)!,
                                          ColorTween(begin: Color(0xfff51604), end: Color(0xfff51604)).lerp(0.5)!,
                                                   ],
                                        legendOptions:
                                        LegendOptions
                                          (
                                          showLegendsInRow: false,
                                          legendPosition: LegendPosition.right,
                                          showLegends: true,
                                          legendTextStyle:
                                          TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.primary,
                                                   )
                                           ),
                                        chartValuesOptions: ChartValuesOptions(
                                          showChartValueBackground: true,
                                          showChartValues: true,
                                          showChartValuesInPercentage: false,
                                          showChartValuesOutside: false,
                                          decimalPlaces: 1,
                                          chartValueStyle: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.greencolor,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                               ),
                                    ]
                                  ),
                                SizedBox(height: 20),


                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    var item = data[index];
                                    return
                                      Padding(
                                      padding:  EdgeInsets.all(1.0),
                                      child:
                                      Column(
                                        children: [
                                          _buildDataRow( 'DSF SAF BusinessLine', item.dsfSafBusinessLine),
                                          _buildDataRow('SAF Customer', item.safCustomer.toString()),
                                          _buildDataRow('Productive Customer', item.productiveCustomer.toString()),
                                           Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          margin: EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  'Non Productive Customers:',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),

                                                ),
                                              ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(item.Non_Productive_Customers.toString(),
                                                        style: TextStyle(
                                                          color: AppColors.primary,
                                                          fontSize: 14,


                                                        ),),
                                                      InkWell(
                                                        onTap: ()
                                                        {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => NonproductiveCustomer(code: code,startdate: formattedStartDate,enddtae: formattedEndDate,), ));
                                                        },
                                                        child: Container(
                                                            padding:EdgeInsets.all(5),
                                                            decoration:
                                                            BoxDecoration(
                                                                color: AppColors.primary,
                                                                borderRadius: BorderRadius.circular(8)),
                                                            child:Text("View List", style: TextStyle(color: Colors.white),)
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                            ],
                                          ),

                                        ),
                                           Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                            margin: EdgeInsets.symmetric(vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    'Eco Percentage:',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        item.ecoPercentage,
                                                        style: TextStyle(
                                                          color: AppColors.primary,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return Dialog(
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(15.0),
                                                                ),
                                                                child: Container(
                                                                  width: 250,
                                                                  height: 100,
                                                                  padding: EdgeInsets.all(8),
                                                                  decoration: BoxDecoration(
                                                                    color: AppColors.greencolor,
                                                                    borderRadius: BorderRadius.circular(15.0),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        'Eco Formula',
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.bold,
                                                                        ),
                                                                        textAlign: TextAlign.center,
                                                                      ),
                                                                      SizedBox(height: 10),
                                                                      Text(
                                                                        'Eco = (Productive customers * 100) / SAF customers',
                                                                        style: TextStyle(
                                                                          color: Colors.white70,
                                                                          fontSize: 14,
                                                                        ),
                                                                        textAlign: TextAlign.center,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                           );
                                                          },
                                                        child: Column(
                                                          children: [Icon(Icons.info ),],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          _buildDataRow('First Order', item.firstOrder != null ? DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(item.firstOrder!)) : 'N/A',),
                                          _buildDataRow('Last Order', item.lastOrder != null ? DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(item.lastOrder!)) : 'N/A'),
                                          _buildDataRow('Duration', "${item.duration.toString()} Hours"),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                            margin: EdgeInsets.symmetric(vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    'Avg time duration per day:',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${item.avg_time.toStringAsFixed(1)} Hours",
                                                        style: TextStyle(
                                                          color: AppColors.primary,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {

                                                        },
                                                        child: Column(
                                                          children: [ Icon(Icons.access_time ) ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          _buildDataRow('Order Quantity', formatNumber(item.Order_Quantity.toString())),
                                          _buildDataRow('Order Value', formatNumber(item.Order_Value.toString())),
                                          _buildDataRow('Lines per order (LPO)', item.avgSkuPerBill.toStringAsFixed(2) ?? '0.00'),
                                          _buildDataRow('Avg Value Per Bill', formatNumber(item.avgValuePerBill.toStringAsFixed(2) ?? '0.00')),
                                          _buildDataRow('DSF Target Value', formatNumber(item.DSFTarget_Value.toString())),
                                          _buildDataRow('DSFTarget %', item.DSFTarget.toString()),
                                          _buildDataRow('DSF Target Remaining', formatNumber(item.DSFTarget_Remaining.toString())),
                                          _buildDataRow('DSF Target Expected Landing', formatNumber(item.DSFTarget_Expected_Landing.toString())),
                                          _buildDataRow('DSF Target Per Day Required', formatNumber(item.DSFTarget_Per_Day_Required.toString())),
                                          _buildDataRow('DSF Target Days Remaining', item.DSFTargetDaysDSFRemaining.toString()),


                                        ],
                                        ),
                                    );

                                  },
                                ),
                              ],
                            ),
                          );

                      }
                    },
                  )
              )
          );
      },
    );
  }
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () async {
          return await Exit.showExitDialog(context);
        },
        child:
        heirarchyloader ?
        Container() :
        Scaffold(
            appBar:
            CustomAppBar(
              title: 'Team Analysis',

              actions: [
                Icon(Icons.abc, color: AppColors.greencolor,),
                if(showsales == true)
                  MyPopupMenu(
                    menuItems: [
                      MenuItem(
                        text: 'Share',
                        icon: Icons.share,
                        value: 'share',
                        onTap: () {
                          print('Share selected');
                          // Add your custom action here
                        },
                      ),
                      MenuItem(
                          text: 'Measures',
                          icon: Icons.filter_list,
                          value: 'measures',
                          onTap: () {

                          }
                      ),
                      MenuItem(
                        text: 'Filters',
                        icon: Icons.filter_list,
                        value: 'filters',
                        onTap: () {
                          print('Filters selected');

                        },
                      ),
                      MenuItem(
                        text: sortwithzero == false ? 'With 0s' : 'Without 0s',

                        icon: Icons.list,
                        value: 'zero',
                        onTap: () {
                          print(sortwithzero ? 'With 0s' : 'Without 0s');

                        },
                      )
                    ],
                    onSelected: (value) {
                      if (value == "measures") {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return filters(
                              onSelectionDone: (selectedValues) async {
                                setState(() {
                                  selectedmeasures = selectedValues.toList();
                                });

                                DateFormat dateFormat = DateFormat(
                                    'yyyy,MM,dd');
                                formattedStartDate = dateFormat.format(startDate!);
                                formattedEndDate = dateFormat.format(endDate!);
                                await getsales(salesid, designation);
                                setState(() {
                                  apiResponseList = apiResponseList;
                                });
                              },
                              selectedvalues: selectedmeasures,
                            );
                          },
                        );
                      }

                      if (value == 'share') {
                        String combinedMessage = "Start Date: $formattedStartDate\nEnd Date: $formattedEndDate\n\n";

                        for (int i = 0; i < apiResponseList.length; i++) {
                          if (apiResponseList[i]['EmpCode'].isNotEmpty) {
                            String name = apiResponseList[i]['EmpName'];
                            String id = apiResponseList[i]['EmpCode'].toString();
                            String sale = NumberFormat('#,###').format(double.parse(apiResponseList[i]['Sales_Inc_ST']?.toString()?.replaceAll(',', '') ?? '0'));
                            sale = sale.isEmpty ? '0' : sale;
                            String measure = '';
                            measure += List.generate(selectedmeasures.length, (index) {
                                  final measure = selectedmeasures[index];
                                  final teamValue = apiResponseList[i][measure
                                      .toString().replaceAll(' ', '_')];
                                  final formattedValue = teamValue != null
                                      ? (measure.endsWith('%') ? teamValue
                                      .toString() : formatter.format(teamValue)
                                      .toString())
                                      : '0';
                                  return "$measure: $formattedValue";
                                },).join('\n');


                            combinedMessage += "Name: $name\nID: $id\nSale: $sale\n$measure\n\n";
                          }
                        }

                        Share.share(combinedMessage, subject: 'Sales Information');
                      }

                      if (value == "filters") {
                        showfitler();
                      }

                      if (value == "zero") {
                        setState(() {
                          sortwithzero = !sortwithzero;
                        });
                      }
                    },

                  ),

              ],
            ),
            drawer: CustomDrawer(),
            body:


            isloading
                ? shimmer_effect(
              isLoading: isloading, selectedmeasures: selectedmeasures
            )

                :
            Stack(
                children: [
                  Column(
                      children: [

                    Container(
                    height: 285,
                    decoration: BoxDecoration(
                      color: AppColors.greencolor,
                    ),
                    child: Column(
                      children: [



                          Container(
                            height: 260,
                            child: SfRadialGauge(
                              enableLoadingAnimation: true,
                              axes: <RadialAxis>[
                                RadialAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  startAngle: 180,
                                  endAngle: 0,
                                  showLabels: false,
                                  showTicks: false,
                                  radiusFactor: 0.9,
                                  axisLineStyle: AxisLineStyle(
                                    thickness: 0.2,
                                    color: Colors.grey.withOpacity(0.4),
                                    thicknessUnit: GaugeSizeUnit.factor,
                                  ),
                                  pointers: <GaugePointer>[
                                    RangePointer(
                                      value: achievementpercentage,
                                      width: 0.2,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      color: Colors.blue[200],
                                      cornerStyle: CornerStyle.bothCurve,
                                    ),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    // Achievement annotation
                                    GaugeAnnotation(
                                      widget: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Achievement \n",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "${totalsale} RS",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue[100],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      positionFactor: 0.02, // Reduced positionFactor for better centering
                                      angle: 90,
                                    ),
                                    // Target annotation
                                    GaugeAnnotation(
                                      widget: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Target \n",
                                              style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "${dsftarget} RS",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      positionFactor: 0.65, // Reduced positionFactor for better placement
                                      angle: 30,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),



                        SizedBox(height: 20,),


                         SizedBox(height: 30,),

                        Expanded(
                            child:
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 14.0),

                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [



                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: AppColors.primary),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              showsales = false;
                                              totalsale = '0';
                                              rootlist.clear();
                                              load(empcode.auth);
                                            });
                                            getsales(empcode.auth,empcode.designation);
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Root',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child:
                                          SingleChildScrollView(
                                            physics: BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Padding(
                                              padding:  EdgeInsets.all(0.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: rootlist.toSet().toList().asMap().map((index, stackItem) {

                                                  if (index == rootlist.length - 1) {
                                                    salesid = stackItem.empCode;
                                                    designation = stackItem.designation;
                                                  }
                                                  final stackItemTitle = UserDetails(
                                                      empName: stackItem.empName,
                                                      empCode: stackItem.empCode,
                                                      reportingTo: stackItem.reportingTo,
                                                      designation: stackItem.designation,
                                                      isCheck: false
                                                  ).empName;
                                                  final stackItemdes = UserDetails(
                                                      empName: stackItem.empName,
                                                      empCode: stackItem.empCode,
                                                      reportingTo: stackItem.reportingTo,
                                                      designation: stackItem.designation,
                                                      isCheck: false
                                                  ).designation;

                                                  return MapEntry(
                                                    index,
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 80,
                                                            decoration: BoxDecoration(
                                                              color: index == rootlist.length - 1
                                                                  ? AppColors.primary
                                                                  : Colors.white,
                                                              borderRadius: BorderRadius.circular(6),
                                                            ),
                                                            child: GestureDetector(
                                                              onTap: () async {
                                                                // _loadUserDetails(stackItem.empCode, stackItem.reportingTo);
                                                                //employeeList = salesViewModel.search(stackItem.empCode);
                                                                // load(stackItem.empCode, stackItem.reportingTo);
                                                                setState(() {
                                                                  showsales = false;
                                                                  totalsale = '0';
                                                                  dsftarget='0';
                                                                  achievementpercentage=0;
                                                                  rootlist.removeRange(index + 1, rootlist.length);
                                                                  showsales = false;
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(2.0),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      stackItemTitle.toString().split("||")[0],
                                                                      style: TextStyle(
                                                                        fontSize: 10,
                                                                        fontWeight: index == rootlist.length - 1
                                                                            ? FontWeight.w600
                                                                            : FontWeight.normal,
                                                                        color: index == rootlist.length - 1
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                      overflow: TextOverflow.ellipsis,
                                                                    ),
                                                                    SizedBox(height: 3),
                                                                    Text(
                                                                      '$stackItemdes',
                                                                      style: TextStyle(
                                                                        fontSize: 11,
                                                                        color: index == rootlist.length - 1
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).values.toList().reversed.toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 16),






                                  if (showsales == false)

                                    (employeeList != null)
                                        ?

                                    Expanded(
                                        child:
                                        ListView.builder(
                                            itemCount: employeeList.length,
                                            itemBuilder: (BuildContext context, index)


                                            {
                                              int? selectedIndex;
                                              var datalist=employeeList[index];

                                              return
                                                Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                child:  InkWell(
                                                  onTap: () async {


                                                    datalist.isCheck =! datalist.isCheck;
                                                    if(datalist.isCheck ==true)
                                                    {
                                                      selectedIndex =index;
                                                      await salesViewModel.initializeDatabase();
                                                      datalist.reports =  salesViewModel.select_through_depth(datalist.Depth.toString());
                                                    }
                                                    else {
                                                      //depthList.clear();
                                                    }
                                                    setState(
                                                            () {
                                                          }   );
                                                  },
                                                  child:
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                        Container(
                                                          padding: EdgeInsets.all(6),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(16),
                                                            color: datalist.isCheck ? AppColors.greencolor : AppColors.primary,
                                                          ),
                                                          child: Icon(
                                                            datalist.isCheck ? Icons.remove: Icons.add,
                                                            size: 13,
                                                            color: Colors.white,
                                                          ),
                                                        ),

                                                        SizedBox(width: 5,),

                                                        Text(datalist.designation,style: TextStyle(fontWeight: datalist.isCheck ? FontWeight.bold : null, color: AppColors.greencolor),),

                                                        SizedBox(width: 5,),

                                                      ],),
                                                      SizedBox(height: 10,),
                                                      if(datalist.isCheck)
                                                      FutureBuilder<List<UserDetails>>(
                                                          future: datalist.reports,
                                                          builder: (context, snapshot) {
                                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                                              return Container();
                                                            }

                                                            if (snapshot.hasError) {
                                                              return Center(child: Text('Error: ${snapshot.error}'));
                                                            }

                                                            if ( !snapshot.hasData || snapshot.data!.isEmpty ) {
                                                              return Center(
                                                                child: Text(
                                                                  '',
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.grey,
                                                                  ),
                                                                ),
                                                              );
                                                            }

                                                            return
                                                              InkWell(
                                                              onTap: (){
                                                                buildUserTile(datalist);
                                                              },
                                                              child: Padding(
                                                                padding:  EdgeInsets.only(left: 0),
                                                                child: Column(
                                                                  children: datalist.isCheck
                                                                      ? snapshot.data!.map((report) => Padding(
                                                                    padding: const EdgeInsets.only(left: 17),
                                                                    child: buildUserTile(report),
                                                                  )).toList()
                                                                      : [],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                    ],
                                                  ),

                                                ),


                                              );

                                            }
                                        )

                                    )
                                        :
                                    Container(
                                      height: 400,
                                      child: Nodata(),
                                    ),
                                  if ( showsales == true )

                                    SalesListView2(
                                      dsftargetlist: achieve,
                                      sortdata: sortwithzero == false
                                          ? 'With Zero'
                                          : 'Without Zero',
                                      apiResponseList: apiResponseList,

                                      customCardWidget: (Map<String,dynamic> datas, Map<String,dynamic> dsf) {

                                        double salesInc = double.parse(datas['Sales_Inc_ST'].replaceAll(",", ""));
                                        double achieve = (salesInc * 100) / datas['DSFTarget_Value'];
                                        //var data =dsftargetlist[datas].DSFTarget_Value;


                                        return
                                          HeirarchyCard(
                                              personwise: true,
                                              title: datas['EmpName'].toString(),
                                              date: datas['EmpCode'].toString(),
                                              amount: datas['Sales_Inc_ST'].toString(),
                                              color: AppColors.greencolor,
                                              designation: datas['EmpDesignation'].toString(),
                                              achievement: dsf['achieve'],
                                              kpionTap: () { bottomsheet(context, datas['EmpCode'], datas['EmpName'], datas['Sales_Inc_ST']);},
                                              route: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MapScreen(
                                                              dsfcode: datas['EmpCode']
                                                                  .toString(),
                                                              date: endDateFormatted
                                                                  .toString(),
                                                              name: datas['EmpName']
                                                                  .toString(),
                                                              code: datas['EmpCode']
                                                                  .toString(),)));

                                              },
                                              onTap: () async
                                              {
                                                if (datas['EmpDesignation'] == "DSF") {
                                                  salesViewModel
                                                      .showCustomerWiseDialog(
                                                      context,
                                                      datas['EmpCode'],
                                                      formattedStartDate,
                                                      formattedEndDate,
                                                      datas['EmpName'].toString().split("||")[0],
                                                      companynumbers,
                                                      branchnumbers,
                                                      selectedmeasures);
                                                }
                                                if (datas['EmpDesignation'] != "DSF") {
                                                  await getsales(datas['EmpCode'],datas['EmpDesignation']);
                                                  setState(() {
                                                    rootlist.add(
                                                      UserDetails(

                                                          empCode: datas['EmpCode'],
                                                          empName: datas['EmpName'],
                                                          reportingTo: datas['ReportTo'],
                                                          designation: datas['EmpDesignation'],
                                                          isCheck: false
                                                      ),
                                                    );
                                                  });
                                                }
                                              },

                                              showsale: showsales,
                                              selectedmeasures: selectedmeasures,
                                              item: datas,
                                              saleonTap: ( ) { }

                                          );
                                      },
                                    ),


                                ])))
                      ]),

                  Positioned(

                      top: 195,
                      right: 0,
                      left: 0,
                      child:
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [

                           Container(
                           width:170,
                             padding: EdgeInsets.all(8),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Colors.blue[100]
                             ),
                             child: Center(child:
                             Column(children:
                             [

                               Text("Last day load value",
                                 style: TextStyle(
                                   fontSize: 11,
                                   fontWeight: FontWeight.normal,
                                   color: AppColors.greencolor,
                                 ),),
                               SizedBox( height: 3 ),
                               Text("${loadvalue} RS", style: TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.bold,
                                 color: AppColors.greencolor,
                               )),

                             ]  )

                             ),
                           ),

                     ]
                     )
                  ),
                  Positioned (
                        top: 255,
                        right: 0,
                        left: 0,
                        child:

                        DateRangeSelector(
                          startDate: startDate,
                          endDate: endDate,
                          showDateContainers: true,
                          onStartDateSelected: (date)
                          {
                            setState(()
                            {
                              startDate = date;
                              print("Start Date selected: $startDate");
                              if (startDate!.isAfter(endDate!))
                              {
                                Utils.toastMessage("Start date cannot be after the end date");
                              }
                              else
                              {
                                getsales(salesid, designation);
                              }
                            });
                          },
                          onEndDateSelected: (date) {
                            setState(() {
                              endDate = date;

                              print("End Date selected: $endDate");

                              if (endDate!.isBefore(startDate!)) {
                                Utils.toastMessage("End date cannot be before the start date");
                              }
                              else
                              {
                                getsales(salesid,designation);
                              }
                            });
                          },
                        )
                    ),


                  
                ]
            )
        ),
      );
  }
}
