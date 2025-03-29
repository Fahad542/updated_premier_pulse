import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnimatedPieChart extends StatefulWidget {
  final double productiveCustomer;
  final double nonProductiveCustomer;

  AnimatedPieChart({
    required this.productiveCustomer,
    required this.nonProductiveCustomer,
  });

  @override
  _AnimatedPieChartState createState() => _AnimatedPieChartState();
}

class _AnimatedPieChartState extends State<AnimatedPieChart> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    // Define an animation for smooth transitions
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Function to get the sections for the PieChart
  List<PieChartSectionData> _getSections(double productiveCustomer, double nonProductiveCustomer) {
    double total = productiveCustomer + nonProductiveCustomer;
    double productivePercentage = total == 0 ? 0 : (productiveCustomer / total);
    double nonProductivePercentage = total == 0 ? 0 : (nonProductiveCustomer / total);

    return [
      PieChartSectionData(
        value: productivePercentage * 100,
        color: Colors.green,
        title: '${productivePercentage * 100}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, color: Colors.white),
        showTitle: true,
      ),
      PieChartSectionData(
        value: nonProductivePercentage * 100,
        color: Colors.red,
        title: '${nonProductivePercentage * 100}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, color: Colors.white),
        showTitle: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return PieChart(
            PieChartData(
              sections: _getSections(widget.productiveCustomer, widget.nonProductiveCustomer).map((section) {
                return PieChartSectionData(
                  value: section.value * _animation.value, // Animate the section value
                  color: section.color,
                  title: section.title,
                  radius: section.radius,
                  titleStyle: section.titleStyle,
                  showTitle: section.showTitle,
                );
              }).toList(),
              centerSpaceRadius: 30,
              sectionsSpace: 6,
            ),
          );
        },
      ),
    );
  }
}
