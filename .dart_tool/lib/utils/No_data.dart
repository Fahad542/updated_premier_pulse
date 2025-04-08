import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';

class nodata extends StatefulWidget {
  const nodata({super.key});

  @override
  State<nodata> createState() => _nodataState();
}

class _nodataState extends State<nodata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.greencolor,),),);
  }
}
