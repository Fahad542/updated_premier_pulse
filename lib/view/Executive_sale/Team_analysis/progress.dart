import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../res/color.dart';



class MyProgressBar extends StatefulWidget {
  double? animation;
  MyProgressBar({ this.animation});
  @override
  _AnimatedProgressBarState createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<MyProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
   late Animation<double> _animation;
  double? remaining;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

   _animation = Tween<double>(begin: 0, end: widget.animation).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
   setState(() {
     remaining = 100 - widget.animation!.toDouble();
   });

    _controller.forward(); // Start animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                                  Stack(
                                  children: [

                                  Container(
                                  width: 100*2.8,  // Set width as per your requirement
                                    height: 13,  // Set height for the progress bar
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),  // Optional: For rounded corners
                                      color: Colors.grey.withOpacity(0.4),  // Light background color
                                    ),
                                  ),
                                    Text(_animation.value.toStringAsFixed(0), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                          Container(
                          width: _animation.value * 2.8,
                          height: 13,
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.greencolor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,),)
                          )
                                ],
                              ),

                          SizedBox(height: 10),
                          Text("${(widget.animation)?.toStringAsFixed(1)}% Time Gone", style: TextStyle(fontSize: 13, color: AppColors.greencolor, fontWeight: FontWeight.w400),),

                        ],
                      );
                    },
                  ),
                ],
              ),
            ));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}





class speedcaart extends StatefulWidget {
  double? target;
  double? targetValue;
  bool dsf_target;
  double achievement;
  Color color;

  speedcaart({required this.achievement,this.target, required this.color, required this.dsf_target,  this.targetValue});
  @override
  _AnimatedProgressBarStat createState() => _AnimatedProgressBarStat();
}

class _AnimatedProgressBarStat extends State<speedcaart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _procontroller;
  late Animation<double> _animation;
  late Animation<double> _animationpro;
  String formatNumber(String? number) {
    if (number == null || number.isEmpty) {
      return 'N/A';
    }

    double? parsedNumber = double.tryParse(number);

    if (parsedNumber == null) {
      return 'Invalid number';
    }


    parsedNumber = double.parse(parsedNumber.toStringAsFixed(0));

    final numberFormat = NumberFormat('#,##');
    return numberFormat.format(parsedNumber);
  }
  double? remaining;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    // _procontroller = AnimationController(
    //   duration: Duration(seconds: 4),
    //   vsync: this,
    // );
    _animation = Tween<double>(begin: 0, end:  widget.targetValue ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    // _animationpro = Tween<double>(begin: 0, end:  widget.targetValue ).animate(
    //   CurvedAnimation(parent: _procontroller, curve: Curves.easeInOut),
    // );

    setState(() {
     // remaining = 100 - widget.animation!.toDouble();
    });

    _controller.forward(); // Start animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:

              // AnimatedBuilder(
              //   animation: widget.dsf_target ? _controller : _procontroller,
              //   builder: (context, child) {
              //     return
              ClipRect( // Add ClipRect to ensure no borders are visible outside the widget
              child:
        Container(


                      child:
                      SfRadialGauge(
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
                              color: Colors.grey.withOpacity(0.3),
                              thicknessUnit: GaugeSizeUnit.factor,
                            ),
                            pointers: <GaugePointer>[
                              RangePointer(
                                value: widget.targetValue!,
                                width: 0.2,
                                sizeUnit: GaugeSizeUnit.factor,
                                color: widget.color,
                                cornerStyle: CornerStyle.bothCurve,
                              ),
                              // MarkerPointer(
                              //   value: targetValue,
                              //   markerHeight: 10,
                              //   markerWidth: 10,
                              //   color: Colors.red,
                              //   text: targetValue.toString(),
                              // ),
                            ],
                            annotations: <GaugeAnnotation>[

                              GaugeAnnotation(
                                widget: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Achievement \n",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal, // Normal weight for "Achievement"
                                          color: Colors.black,
                                        ),
                                      ),
widget.dsf_target ?
TextSpan(
    text: "${NumberFormat('#,##0').format(widget.achievement)} RS", // Formatting number with commas
    style: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold, // Bold for the amount
      color: widget.color, // Text color
    )
)
    :  TextSpan(
  text: "   ${widget.achievement.toStringAsFixed(0)}%",
  style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold, // Bold for the amount
    color: widget.color,
  ),
)
                                    ],
                                  ),
                                ),
                                positionFactor: 0.001,
                                angle: 90,
                              ),
                              if(widget.dsf_target ==true)
                              GaugeAnnotation(
                                widget:

                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Target \n",
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.normal, // Normal weight for "Achievement"
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "${formatNumber(widget.target.toString())} RS",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold, // Bold for the amount
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),




                                positionFactor: 0.75,
                                angle: 30,
                              ),
                            ],
                          ),

                        ],
                      ),
                    )



            //  ),

        ));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}







class speedcaart3 extends StatefulWidget {
  double? target;
  double? targetValue;
  bool dsf_target;
  String achievement;
  Color color;

  speedcaart3({required this.achievement,this.target, required this.color, required this.dsf_target,  this.targetValue});
  @override
  _AnimatedProgressBarSt createState() => _AnimatedProgressBarSt();
}

class _AnimatedProgressBarSt extends State<speedcaart3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _procontroller;
  late Animation<double> _animation;
  late Animation<double> _animationpro;
  String formatNumber(String? number) {
    if (number == null || number.isEmpty) {
      return 'N/A';
    }

    double? parsedNumber = double.tryParse(number);

    if (parsedNumber == null) {
      return 'Invalid number';
    }


    parsedNumber = double.parse(parsedNumber.toStringAsFixed(0));

    final numberFormat = NumberFormat('#,##');
    return numberFormat.format(parsedNumber);
  }
  double? remaining;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end:  widget.targetValue ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );


    setState(() {
      // remaining = 100 - widget.animation!.toDouble();
    } );

    _controller.forward(); // Start animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:

        // AnimatedBuilder(
        //   animation: widget.dsf_target ? _controller : _procontroller,
        //   builder: (context, child) {
        //     return

              SfRadialGauge(
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
                      color: Colors.grey.withOpacity(0.3),
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: widget.targetValue!,
                        width: 0.2,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: widget.color,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                      // MarkerPointer(
                      //   value: targetValue,
                      //   markerHeight: 10,
                      //   markerWidth: 10,
                      //   color: Colors.red,
                      //   text: targetValue.toString(),
                      // ),
                    ],
                    annotations: <GaugeAnnotation>[

                      GaugeAnnotation(
                        widget: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Achievement \n",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal, // Normal weight for "Achievement"
                                  color: Colors.white,
                                ),
                              ),
                              widget.dsf_target ?
                              TextSpan(
                                  text: "${widget.achievement} RS", // Formatting number with commas
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold, // Bold for the amount
                                    color: widget.color, // Text color
                                  )
                              )
                                  :  TextSpan(
                                text: "   ${widget.achievement}RS",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold, // Bold for the amount
                                  color: widget.color,
                                ),
                              )
                            ],
                          ),
                        ),
                        positionFactor: 0.001,
                        angle: 90,
                      ),
                      if(widget.dsf_target ==true)
                        GaugeAnnotation(
                          widget:

                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Target \n",
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.normal, // Normal weight for "Achievement"
                                    color: Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text: "${formatNumber(widget.target.toString())} RS",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold, // Bold for the amount
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),




                          positionFactor: 0.75,
                          angle: 30,
                        ),
                    ],
                  ),

                ],
              ),




        );

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}







class speedcaart2 extends StatefulWidget {
  double? target;
  double? targetValue;
  bool dsf_target;
  double achievement;
  Color color;

  speedcaart2({required this.achievement,this.target, required this.color, required this.dsf_target,  this.targetValue});
  @override
  _AnimatedProgressBarSta createState() => _AnimatedProgressBarSta();
}

class _AnimatedProgressBarSta extends State<speedcaart2> with SingleTickerProviderStateMixin {

  late AnimationController _procontroller;

  late Animation<double> _animationpro;
  String formatNumber(String? number) {
    if (number == null || number.isEmpty) {
      return 'N/A';
    }

    double? parsedNumber = double.tryParse(number);

    if (parsedNumber == null) {
      return 'Invalid number';
    }


    parsedNumber = double.parse(parsedNumber.toStringAsFixed(0));

    final numberFormat = NumberFormat('#,##');
    return numberFormat.format(parsedNumber);
  }
  double? remaining;
  @override
  void initState() {
    super.initState();

    _procontroller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );

    _animationpro = Tween<double>(begin: 0, end:  widget.achievement ).animate(
      CurvedAnimation(parent: _procontroller, curve: Curves.easeInOut),
    );

    setState(() {
      // remaining = 100 - widget.animation!.toDouble();
    });

    _procontroller.forward(); // Start animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:

      // AnimatedBuilder(
      //   animation:  _procontroller,
      //   builder: (context, child) {
      //     return

            SfRadialGauge(
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
                    color: Colors.grey.withOpacity(0.3),
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value:  widget.achievement,
                      width: 0.2,
                      sizeUnit: GaugeSizeUnit.factor,
                      color: widget.color,
                      cornerStyle: CornerStyle.bothCurve,
                    ),
                    // MarkerPointer(
                    //   value: targetValue,
                    //   markerHeight: 10,
                    //   markerWidth: 10,
                    //   color: Colors.red,
                    //   text: targetValue.toString(),
                    // ),
                  ],
                  annotations: <GaugeAnnotation>[

                    GaugeAnnotation(
                      widget: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Achievement \n",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal, // Normal weight for "Achievement"
                                color: Colors.black,
                              ),
                            ),


                                  TextSpan(
                              text: "   ${widget.achievement.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold, // Bold for the amount
                                color: widget.color,
                              ),
                            )
                          ],
                        ),
                      ),
                      positionFactor: 0.001,
                      angle: 90,
                    ),
                    if(widget.dsf_target ==true)
                      GaugeAnnotation(
                        widget:

                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Target \n",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.normal, // Normal weight for "Achievement"
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: "${formatNumber(widget.target.toString())} RS",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold, // Bold for the amount
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),




                        positionFactor: 0.75,
                        angle: 30,
                      ),
                  ],
                ),

              ],
            )


    ,
     // ),

    );

  }

  @override
  void dispose() {
    _procontroller.dispose();
    super.dispose();
  }
}