import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/Local_database/db.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/respository/Attendance_repository.dart';
import 'package:mvvm/view/Executive_sale/Company_wise/Company_wise.dart';
import 'package:mvvm/view/Executive_sale/Customer_wise/customer_wise.dart';
import '../../../model/Getemployees_model.dart';
import '../../../model/team_company.dart';
import '../../../respository/Erp_employees.dart';


class SalesHeirarchyViewModel with ChangeNotifier {
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6'

  ];

  List<bool> selectedItems = List.generate(6, (index) => false);
  List<bool> selectedItem = List.generate(6, (index) => false);
  List<String> selectedToAdd = [];
  List<String> selectedbranch = [];
  List<String> filteredItembranch = [];
  bool selectal = false;
  List<String> selectedToAd = [];
  List<String> filteredItem = [];
  List<String> filteredItems = [];
  List<ErpEmployee> erpemployee=[];
  TextEditingController erp_Employee_controller=TextEditingController();
  int selectedTabIndex = 0;
  final attendance = AttendanceRepo();
  final erp =GetErpEmployeesRepo();
  Map<String, dynamic> today_attendance={};
  bool selectall = false;
  TextEditingController _textEditing = TextEditingController();
  TextEditingController _textEditingbranch = TextEditingController();
  void refreshSelectedToAddcompany() {
    selectedToAd = [];
  }

  Future<void> userattendance(String code) async  {
    today_attendance = await attendance.fectdata(code);
    print("Attendance: ${today_attendance}");
    notifyListeners();
  }
  Future<void> dsfuserattendance(String code) async {
    try {
      today_attendance = await attendance.dsf_attendance(code); // This is expected to be a Map
      print("Attendance: $today_attendance");

      // Optional: Handle specific response cases
      if (today_attendance['status'] == '404') {
        print("No attendance found for code $code");
        // You can notify UI or set a state flag here if needed
      }

      notifyListeners();
    } catch (e, stackTrace) {
      print("Error in dsfuserattendance: $e");
      print("Stack trace: $stackTrace");

      // Optional: You can also log this or show a snackbar/dialog in the UI
    }
  }


  void attendancesheet(BuildContext context, String code) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return FutureBuilder(
          future: userattendance(code), // Call your method here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 130,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Container(
                height: 200,
                child: Center(child: Text('Error loading attendance')),
              );
            } else {
              // Assume `today_attendance` holds the time string like '09:00 AM'
              String attendanceTime = today_attendance['checkIn'] ?? 'N/A';

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                height: 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Attendance',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/attendance.png",
                            color: AppColors.primary,
                            height: 34,
                            width: 34,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today attendance time:',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.greencolor,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              attendanceTime,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.greencolor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }



  void dsfattendancesheet(BuildContext context, String code) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return FutureBuilder(
          future: dsfuserattendance(code), // Call your method here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 130,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Container(
                height: 200,
                child: Center(child: Text('Error loading attendance')),
              );
            } else {
              // Assume `today_attendance` holds the time string like '09:00 AM'
              String attendanceTime = today_attendance['attendance_time'] ?? 'N/A';
              String dayend = today_attendance['dayend_time'] ?? 'N/A';
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                height: 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Attendance',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/attendance.png",
                            color: AppColors.primary,
                            height: 34,
                            width: 34,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today attendance time:',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.greencolor,
                              ),
                            ),
                            SizedBox(height: 4),
                             Text(
                                "Attendance Time: ${attendanceTime}\nDayend Time: ${dayend} ",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.greencolor,
                                ),
                              ),

                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }

Future<void> search( String code) async  {
  erpemployee = await erp.getErpEmployees(code);
  notifyListeners();

}
  void showConfirmationDialog(BuildContext context, String name, String code, String requested_under_name, String requested_under_code) {
    showDialog(
      context: context,
      barrierDismissible: false, // Tap outside to dismiss disabled
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 16,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded, size: 60,
                    color: Colors.orange),
                SizedBox(height: 16),
                Text(
                  "Are you sure?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Do you really want to add ${name} in heirarcy?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: AppColors.primary),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Cancel
                      },
                      icon: Icon(Icons.cancel),
                      label: Text("Cancel"),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        erp.Send_request(code, name, requested_under_code, requested_under_name);
                        Navigator.of(context).pop(); // Confirm
                        // Add your confirm logic here
                        print("Action confirmed");
                      },
                      icon: Icon(Icons.check_circle_outline),
                      label: Text("Yes, Confirm"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
void get_erp_employees(BuildContext context, String requested_under_name, String requested_under_code)
{
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.white,

      isScrollControlled: true, // agar content zyada ho to scroll ho sake
      builder: (BuildContext context) {
        return
          StatefulBuilder(
            builder: (BuildContext context, setState) {
              return
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child:
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Text("Search something", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                              // boxShadow: [
                              // BoxShadow(
                              // color: AppColors.primary.withOpacity(0.1),
                              // spreadRadius: 1,
                              // blurRadius: 6,
                              // offset: Offset(0, 3),
                              // ),
                              // ],
                            ),
                            child: TextField(
                              controller: erp_Employee_controller,
                              decoration: InputDecoration(
                                hintText: "Type here...",
                                prefixIcon: Icon(Icons.search, size: 20,),
                                isDense: true, // Yeh line text ko vertically center karta hai
                                contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0), // Thoda zyada vertical padding
                                border: InputBorder.none,
                              ),
                              onChanged: (value){
                                setState(() {
                                  if(value.isNotEmpty) {
                                    search(value);
                                  }
                                  else {
                                    erpemployee.clear();
                                  }
                                });
                              },
                            ),


                          ),


                          SizedBox(height: 20),
                          erpemployee.isNotEmpty ?
                          Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: erpemployee.length,
                              padding: EdgeInsets.all(12),
                              itemBuilder: (context, index) {
                                var data = erpemployee[index];

                                return
                                  InkWell(
                                    onTap: (){
                                      setState(() {

                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 12),
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade50.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(16),

                                      ),
                                      child: Row(
                                        children: [

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${data.name} (${data.oldCode})",
                                                  style:TextStyle(
                                                    color:
                                                    AppColors.primary,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),

                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),



                                                Text(data.designation)
                                              ],
                                            ),
                                          ),
                                          //if(data.isCheck == false)

                                          InkWell(
                                              onTap: (){
                                                showConfirmationDialog(context,data.name,data.oldCode, requested_under_name, requested_under_code);
                                              },
                                              child: Image.asset("assets/r.png", height: 50, width: 50, color: AppColors.primary,)),

                                        ],
                                      ),
                                    ),
                                  );
                              },
                            ),
                          ):
                              Text("No data")


                        ],
                      ),
                    ));
            },
          );
      } );



}











  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.ligthgreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: AppColors.ligthgreen),
          ),
          elevation: 5,
          title: Center(
            child: Text(
              "Loading",
              style: TextStyle(color: Colors.white),
            ),
          ),
          content: Container(
            height: 40,
            width: 0,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.ligthgreen,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
  void showCustomerWiseDialog(BuildContext context, String emp_code, String startdate, String enddate, String name, List<int> company, List<int> branch, List<String> measure) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.greencolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            
          ),
          elevation: 5,
          title: Center(
            child: Text(
              "Select any one",
              style: TextStyle(color: Colors.white),
            ),
          ),
          content: Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.8, // Adjust the width as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop(); // Close the dialog
                      // Open your Customer Wise page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              customer_wise(
                                emp_code,
                                startdate,
                                enddate,
                                empCode: emp_code,
                                startDate: startdate,
                                endDate: enddate,
                                name: name,
                                companylist: company,
                                branchlist: branch, selectedmeasures: measure,
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primary, // Button background color
                      onPrimary: Colors.white, // Text color
                    ),
                    child: Text(
                      "Customer Wise",
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.02,
                ), // Add some space between buttons
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      // Open your Company Wise page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              company_wise(

                                empCode: emp_code,
                                startDate: startdate,
                                endDate: enddate,
                                name: name,
                                companylist: company,
                                branchlist: branch, selectedmeasures: measure,
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary:  AppColors.primary, // Button background color
                      onPrimary: Colors.white, // Text color
                    ),
                    child: Text(
                      "Company Wise",
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void refreshSelectedToAddbranch() {
    selectedToAdd = [];
    selectedbranch = [];
  }
  void showDropdownCheckbox(BuildContext context, List<String> items, List<String> item, List<String> initialSelectedValues, String title, List<bool> check, void Function(List<String> selectedValuese) onDone, void Function() onTapDone,) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    filteredItembranch = List.from(items);

    selectedItems = List.generate(items.length, (index) => initialSelectedValues.contains(items[index]),);

    TextEditingController textEditing = TextEditingController();


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Center(
                child: Text(
                  title,
                  style: TextStyle(color: AppColors.greencolor),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.white,
              content:
              Container(
                height: screenHeight * 0.8,
                width: screenWidth * 1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                //padding: EdgeInsets.all(4),
                child: Column(
                  children: [
                     selectedTabIndex ==0 ?
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color:AppColors.greencolor,
                        borderRadius: BorderRadius.circular(17),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Center(
                        child: TextField(
                          textAlign: TextAlign.start,
                          onChanged: (value) async {
                            setState(() {
                              if(_textEditing==''){
                                filteredItembranch = List.from(items);
                              }
                              LocalDatabase.searchbranch(_textEditing).then((searchResult) {
                                filteredItembranch = searchResult.map((map) => '${map['Branch_Branch_Report_Name']} - ${map['Branch_Branch_Code']}').toList();
                                check = searchResult.map((map) => map['is_check'] == 1).toList();
                              });

                            });
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    )
:
                  Container(
                  height: 35,
                  decoration: BoxDecoration(
                  color: AppColors.greencolor,
                  borderRadius: BorderRadius.circular(17),
            ),
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Center(
            child: TextField(
            textAlign: TextAlign.start,
            onChanged: (value) async {
            setState(() {
            if(_textEditing==''){
            filteredItembranch = List.from(items);
            }
            LocalDatabase.searchbranch(_textEditing).then((searchResult) {
            filteredItembranch = searchResult.map((map) => '${map['Branch_Branch_Report_Name']} - ${map['Branch_Branch_Code']}').toList();
            check = searchResult.map((map) => map['is_check'] == 1).toList();
            });

            });
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search Branch',
            hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 15,
            ),
            ),
            ),
            ),
            ),
                    // if (title=="Select Branches")
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: [
                            Container(
                              child: SizedBox(
                                height: 30,
                                child:

                                ListView.builder(
                                  itemCount: selectedToAdd.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final item = selectedToAdd[index];
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Chip(
                                        backgroundColor: AppColors.ligthgreenshade,
                                        label: Text(
                                          item,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                              ),
                            ),

                          ]),


                    ),
                    Row(
                      children: [
                        Text(""),
                        Spacer(),
                        Checkbox(
                          value: selectal,
                          activeColor: AppColors.greencolor,
                          // Set the active color to green
                          onChanged: (value) {
                            setState(() {
                              selectal = value ?? false;
                              if (selectal) {
                                for (int i = 0; i < check.length; i++) {
                                  check[i] = true;

                                  selectedToAdd.add(items[i]);
                                }
                              } else {
                                for (int i = 0; i < check.length; i++) {
                                  check[i] = false;
                                  selectedToAdd.remove(items[i]);
                                }
                              }
                            });
                          },
                        ),

                        Text('Select All', style: TextStyle(
                            color: AppColors.greencolor, fontSize: 12),),
                        SizedBox(width: 10,),
                        Container(
                          height: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectal = false;
                                if (selectal) {
                                  for (int i = 0; i < check.length; i++) {
                                    check[i] = true;

                                    selectedToAdd.add(items[i]);
                                  }
                                } else {
                                  for (int i = 0; i < check.length; i++) {
                                    check[i] = false;
                                    selectedToAdd.remove(items[i]);
                                  }
                                }
                                selectedToAdd.clear();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              // Set the background color to red
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('Clear', style: TextStyle(
                                color: Colors.white, fontSize: 10)),
                          ),
                        ),
                      ],),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child:
                            ListView.builder(
                              itemCount: filteredItembranch.length,
                              itemBuilder: (context, index) {
                                return
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [

                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child:

                                            Text(
                                              filteredItembranch[index].toString(),
                                              style: TextStyle(
                                                  color: Colors.green[800]),
                                            ),
                                          ),
                                        ),
                                        Checkbox(
                                          value: check[index],
                                          // Use the value at the index
                                          activeColor: Colors.green,
                                          // Set the active color to green
                                          onChanged: (value) {
                                            setState(() {
                                              check[index] = value ??
                                                  false; // Update the value at the index
                                              if (value ?? false) {
                                                //.print(filteredItem[index].split(' - ')[1]);
                                                selectedToAdd.add(filteredItembranch[index]);
                                                LocalDatabase.updateIsCheckValuebranch(filteredItembranch[index].split(' - ')[1], true);
                                              } else {
                                                selectedToAdd.remove(filteredItembranch[index]);
                                                LocalDatabase.updateIsCheckValuebranch(filteredItembranch[index].split(' - ')[1], false);
                                              }
                                            });
                                          },
                                        )


                                      ]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          // await saveSelectedItems(selectedToAdd);
                          List<String> selectedItemsList = [];
                          for (int i = 0; i < items.length; i++) {
                            if (selectedItems[i]) {
                              selectedItemsList.add(items[i]);
                            }
                          }
                          List<String> codes = selectedToAdd.map((item) {
                            // Split each item by ' - ' and get the last part (which should be the code)
                            List<String> parts = item.split(' - ');
                            return parts.isNotEmpty
                                ? parts[1]
                                : ''; // Return the code part or an empty string if parts is empty
                          }).toList();
                          if (title == "Select Companies") {
                            ///updateIsCheckValue(check);
                            //fetchData();
                          }
                          onDone(codes);

                          print("selectedtoadd: $selectedToAdd");
                          onTapDone();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.greencolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child:
                        Text('Done', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  Future<void> showDropdownCheckboxs(BuildContext context, List<String> branch, List<String> items, List<String> initialSelectedValues, String title, List<bool> check, List<bool> checkbranch, void Function(List<String> selectedValuese) onDone, void Function(List<String> branch) branchvalues, void Function() onTapDone,) async {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    List<String> selectedToAdSearch = List.from(initialSelectedValues);
    filteredItem = List.from(items);
filteredItems=List.from(branch);
    selectedItems = List.generate(
      items.length, (index) => initialSelectedValues.contains(items[index]),
    );
    filteredItembranch = List.from(items);
    selectedItems = List.generate(
      items.length, (index) => initialSelectedValues.contains(items[index]),
    );
    List<Team_compnay> teams = [];

    // Use the names list here
    TextEditingController _textEditingController = TextEditingController();



    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DefaultTabController(
              length: 2, // Number of tabs
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AlertDialog(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                  content: Container(
                   height: screenHeight * 0.8,
                    width: screenWidth * 1.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(4),
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: AppColors.greencolor,
                          unselectedLabelColor: Colors.black,
                          onTap: (index) {
                            setState(() {
                              selectedTabIndex = index;
                              print(check);
                            });
                          },
                          tabs: [
                            Tab(text: 'Company'),
                            Tab(text: 'Branches'), // Change tab name to 'Company'
                          ],
                        ),

                        Expanded(
                          child:
                          TabBarView(
                            children: [

                              Container(

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Container(
                                          height: 30,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: AppColors.greencolor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          margin: EdgeInsets.symmetric(vertical: 8),
                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                          child: Center(
                                            child:
                                            TextField(
                                              controller: _textEditingController,
                                              textAlign: TextAlign.start,
                                              onChanged: (value) async {
                                                setState(   ()
                                                    {
                                                  if(_textEditingController==''){
                                                    filteredItems = List.from(items);
                                                  }
                                                  LocalDatabase.searchItems(_textEditingController).then((searchResult) {
                                                    filteredItem = searchResult.map((map) => '${map['Product_Company_Name']} - ${map['Product_Company_ID']}').toList();
                                                    check = searchResult.map((map) => map['is_check'] == 1).toList();
                                                  });

                                                }
                                                );
                                              },
                                              style: TextStyle( color: Colors.white ),
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(14), // Adjust vertical padding here
                                                border: InputBorder.none,
                                                hintText: 'Search',
                                                hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),


                                              ),
                                            ),

                                          ),
                                        ),
                                       InkWell(
                                         onTap: (){
                                           setState(() {
                                             selectall = false;
                                             if (selectall) {
                                               for (int i = 0; i < check.length; i++) {
                                                 check[i] = true;

                                                 selectedToAd.add(items[i]);
                                               }
                                             } else {
                                               for (int i = 0; i < check.length; i++) {
                                                 check[i] = false;
                                                 selectedToAd.remove(items[i]);
                                               }
                                             }
                                             selectedToAd.clear();
                                           });
                                         },
                                         child:
                                         Container(
                                        padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.red),
                                            child: Text('Clear', style: TextStyle(
                                                color: Colors.white, fontSize: 10)),
                                          ),)

                                      ],
                                    ),

                                    Row(
                                      children: [

                                        Spacer( ),


                                        Text('Select All', style: TextStyle(
                                            color: AppColors.greencolor, fontSize: 12),),

                                        Checkbox(
                                          value: selectall,
                                          activeColor: AppColors.ligthgreen,
                                          // Set the active color to green
                                          onChanged: (value) {
                                            setState(() {
                                              selectall = value ?? false;
                                              if (selectall) {
                                                for (int i = 0; i < check.length; i++) {
                                                  check[i] = true;
                                                  if (title == "Select Companies") {
                                                    selectedToAd.add(items[i]);
                                                    LocalDatabase.updateCheck(true);
                                                  }
                                                }
                                              } else {
                                                for (int i = 0; i < check.length; i++) {
                                                  check[i] = false;
                                                  selectedToAd.remove(items[i]);
                                                  LocalDatabase.updateCheck(false);
                                                  selectedToAd=[];
                                                }
                                              }
                                            });
                                          },
                                        ),
                                        SizedBox(width: 10,),


                                      ],
                                    ),


                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child:
                                            ListView.builder(
                                              itemCount: filteredItem.length,
                                              itemBuilder: (context, index) {
                                                return

                                                  Column(
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [

                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(
                                                                    2.0),
                                                                child:

                                                                Text(
                                                                  filteredItem[index].toString(),
                                                                  style: TextStyle(
                                                                    fontSize: 14,
                                                                      color: AppColors.greencolor,


                                                                  ),

                                                                ),
                                                              ),
                                                            ),
                                                            Checkbox(
                                                              value: check[index],
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  check[index] = value ?? false; // Update the value at the index
                                                                  if (value ?? false)  {
                                                                    selectedToAd.add(filteredItem[index]);
                                                                    LocalDatabase.updateIsCheckValue(filteredItem[index].split(' - ')[1], true);
                                                                    LocalDatabase.name();
                                                                  } else {
                                                                    selectedToAd.remove(filteredItem[index]);
                                                                    LocalDatabase.updateIsCheckValue(filteredItem[index].split(' - ')[1], false);
                                                                    LocalDatabase.name();
                                                                    // Data();
                                                                    // Pass the actual ID here
                                                                  }
                                                                });
                                                              },
                                                              activeColor: AppColors.greencolor,
                                                            )


                                                          ]),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                        child: Divider(color: AppColors.greencolor, height: 1),
                                                      ),
                                                    ],
                                                  );

                                              },

                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          // await saveSelectedItems(selectedToAdd);
                                          List<String> selectedItemsList = [];
                                          for (int i = 0; i < items.length; i++) {
                                            if (selectedItems[i]) {
                                              selectedItemsList.add(items[i]);
                                            }
                                          }
                                          List<String> codes = selectedToAd.map((item) {
                                            // Split each item by ' - ' and get the last part (which should be the code)
                                            List<String> parts = item.split(' - ');
                                            return parts.isNotEmpty
                                                ? parts[1]
                                                : '';
                                          }).toList();
                                          if (title == "Select Companies") {
                                          }
                                          onDone(codes);
                                          print(codes);

                                          print("selectedtoadd: $selectedToAd");
                                          onTapDone();
                                          LocalDatabase.name();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.greencolor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child:
                                        Text('Done', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////branch
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                child: Column(
                                  children: [

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Container(
                                          height: 30,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: AppColors.greencolor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          margin: EdgeInsets.symmetric(vertical: 13),
                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextField(
controller: _textEditingbranch,
                                                onChanged: (value) async {
                                                  setState(() {
                                                    if(_textEditingbranch==''){
                                                      filteredItem = List.from(branch);
                                                    }
                                                    LocalDatabase.searchbranch(_textEditingbranch).then((searchResult) {
                                                      filteredItems = searchResult.map((map) => '${map['Branch_Branch_Report_Name']} - ${map['Branch_Branch_Code']}').toList();
                                                      checkbranch = searchResult.map((map) => map['is_check'] == 1).toList();
                                                    });

                                                  });
                                                },
                                                style: TextStyle(color: Colors.white),
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.all(10), // Adjust vertical padding here
                                                  border: InputBorder.none,
                                                  hintText: 'Search',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                  ),
                                                ),

                                              ),
                                            ),

                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              selectal = false;
                                              if (selectal) {
                                                for (int i = 0; i < checkbranch.length; i++) {
                                                  checkbranch[i] = true;

                                                  selectedToAdd.add(branch[i]);
                                                }
                                              } else {
                                                for (int i = 0; i < checkbranch.length; i++) {
                                                  checkbranch[i] = false;
                                                  selectedToAdd.remove(branch[i]);
                                                }
                                              }
                                              selectedToAdd.clear();

                                            });
                                          },
                                          child:
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: Colors.red),
                                            child: Text('Clear', style: TextStyle(
                                                color: Colors.white, fontSize: 10)),
                                          ),)

                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(""),
                                        Spacer(),


                                        Text('Select All', style: TextStyle(
                                            color: AppColors.greencolor, fontSize: 12),),
                                        Checkbox(
                                          value: selectal,
                                          activeColor: AppColors.greencolor,
                                          // Set the active color to green
                                          onChanged: (value) {
                                            setState(() {
                                              selectal = value ?? false;
                                              if (selectal) {
                                                for (int i = 0; i < checkbranch.length; i++) {
                                                  checkbranch[i] = true;

                                                  selectedToAdd.add(branch[i]);
                                                }
                                              } else {
                                                for (int i = 0; i < checkbranch.length; i++) {
                                                  checkbranch[i] = false;
                                                  selectedToAdd.remove(branch[i]);
                                                }
                                              }
                                            });
                                          },
                                        ),
                                        SizedBox(width: 10,),

                                      ],),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child:
                                            ListView.builder(
                                              itemCount: filteredItems.length,
                                              itemBuilder: (context, index) {
                                                return
                                                  Column(
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [

                                                            Expanded(
                                                             child:

                                                                Text(
                                                                  filteredItems[index].toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 14,
                                                                      color: AppColors.greencolor),
                                                                ),
                                                              ),

                                                              Checkbox(
                                                                value: checkbranch[index],
                                                                // Use the value at the index
                                                                activeColor: AppColors.greencolor,
                                                                // Set the active color to green
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    print('check: $check');
                                                                    print('checkbranch: $checkbranch');
                                                                    checkbranch[index] = value ??
                                                                        false; // Update the value at the index
                                                                    if (value ?? false) {
                                                                      //.print(filteredItem[index].split(' - ')[1]);
                                                                      selectedToAdd.add(branch[index]);
                                                                      LocalDatabase.updateIsCheckValuebranch(branch[index].split(' - ')[1], true);
                                                                    } else {
                                                                      selectedToAdd.remove(branch[index]);
                                                                     LocalDatabase.updateIsCheckValuebranch(branch[index].split(' - ')[1], false);
                                                                    }
                                                                  });
                                                                },
                                                              ),


                                                          ]
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                        child: Divider(color: AppColors.greencolor, height: 1),
                                                      ),
                                                    ],
                                                  );

                                              },
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),

                                      Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.symmetric(vertical: 8),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            List<String> selectedItemsList = [];
                                            for (int i = 0; i < branch.length; i++) {
                                              if (selectedItems[i])
                                              {
                                                selectedItemsList.add(branch[i]);
                                              }
                                            }
                                            List<String> codes = selectedToAdd.map((item) {
                                              List<String> parts = item.split(' - ');
                                              return parts.isNotEmpty
                                                  ? parts[1]
                                                  : '';
                                            }).toList();
                                            if (title == "Select Companies") {

                                            }
                                            branchvalues(codes);

                                            print("selectedtoadd: $selectedToAdd");
                                            onTapDone();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: AppColors.greencolor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          child:
                                          Text('Done', style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}







