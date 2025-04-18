import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchableBottomSheet extends StatefulWidget {
  @override
  _SearchableBottomSheetState createState() => _SearchableBottomSheetState();
}

class _SearchableBottomSheetState extends State<SearchableBottomSheet> {
  // Sample list
  final List<String> items = [
    'AI Learning',
    'Machine Learning',
    'Deep Learning',
    'Data Science',
    'Flutter Development',
    'JavaScript',
    'Python Programming',
  ];

  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = items; // Initially show all items
  }

  void _filterList(String query) {
    final filtered = items.where((item) {
      return item.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredItems = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Search something", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          TextField(
            onChanged: _filterList, // Update list based on search query
            decoration: InputDecoration(
              hintText: "Type here...",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 20),
          // ListView to display filtered items
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredItems[index]),
                  onTap: () {
                    // Do something when item is tapped
                    Navigator.pop(context); // Example: Close bottom sheet on tap
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close bottom sheet
            },
            child: Text("Close"),
          )
        ],
      ),
    );
  }
}
