import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/non_productive customer.dart';
import '../../../res/color.dart';
import '../../../respository/location_repository.dart';
import '../../../utils/utils.dart';
import 'Dsf_route.dart';
import 'non_prodcutive_location.dart';

class NonproductiveCustomer extends StatefulWidget {
String? code;
String? startdate;
String? enddtae;
NonproductiveCustomer({ required this.code, required this.startdate,required this.enddtae});
  @override
  State<NonproductiveCustomer> createState() => _NonproductiveCustomerState();
}

class _NonproductiveCustomerState extends State<NonproductiveCustomer> {
  final repo = LoactionRepo();
  List<NonproCustomer> data = [];
  bool isloading=false;

  Future<void> fetch() async {
    setState(() {
      isloading = true;
    });

    try {

      var fetchedData = await repo.nonproductivecust(
        widget.code.toString(),
        widget.startdate.toString(),
        widget.enddtae.toString(),
      );

      print("Fetched Data: ${fetchedData}");

      var filteredData = fetchedData.where((item) => item.nonProductiveCust != 0).toList();

      print("Filtered Data: $filteredData");

      setState(()
      {
        data = filteredData;  // Set the filtered data here
        isloading = false;
      });
      if(data.isEmpty)
        {
          Navigator.pop(context);
          Utils.flushBarErrorMessage("Not Found", context);
        }
    } catch (e, stack) {
      print("stack: $stack");
      print("Error: $e");

      setState(()
      {
        isloading = false;
      }
      );
    }
  }

  void makePhoneCall(String phoneNumber) async {
    final Uri _phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(_phoneUri.toString())) {
      await launch(_phoneUri.toString());
    }
    else {
      print('Could not launch phone call');
    }
  }
  @override
  void initState() {
    fetch();
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {
      return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greencolor,
        title: Text('Non Productive Customers'),
      ),
      body:
      isloading
          ? Center(child: CircularProgressIndicator(color: AppColors.primary,))
          :
      ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          NonproCustomer customer = data[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(customer.customerCustName),
              subtitle: Text('Code: ${customer.customerCustCode}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min, // To keep the row compact
                children: [
                  // Map Icon
                  if (customer.long!=0.0 && customer.lat!=0.0 ) // Check if address is available
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>nonpro_location(lat: customer.lat, long: customer.long, name: customer.customerCustName,)));
                       // openMap(customer.customerCustAddress); // Function to open map
                      },
                      child: Icon(Icons.location_on, color: Colors.red),
                    ),
                  SizedBox(width: 16), // Spacing between icons
                  // Phone Icon
                  if (customer.customerCustPhone.isNotEmpty) // Check if phone is available
                    InkWell(
                      onTap: () {
                        makePhoneCall(customer.customerCustPhone); // Function to make a call
                      },
                      child: Icon(Icons.phone, color: Colors.green),
                    )

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
