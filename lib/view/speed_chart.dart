import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedChart extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return
      Scaffold(
      body:
      Row(
        children: [
          Container(
            height: 200,
            width: 300,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 20,
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
                      value: 13.25,
                      width: 0.2,
                      sizeUnit: GaugeSizeUnit.factor,
                      color: Colors.blue,
                      cornerStyle: CornerStyle.bothCurve,
                    ),
                    MarkerPointer(
                      value: 17.61,
                      markerHeight: 10,
                      markerWidth: 10,
                      color: Colors.blue,
                     // markerType: const MarkerType.line,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        '13.25bn',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      positionFactor: 0.1,
                      angle: 90,
                    ),
                    GaugeAnnotation(
                      widget: Text(
                        '17.61bn',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      positionFactor: 0.75,
                      angle: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
