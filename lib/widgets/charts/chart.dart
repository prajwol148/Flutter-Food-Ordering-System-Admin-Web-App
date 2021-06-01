import 'package:ecommerce_admin_tut/provider/app_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesChartTwo extends StatefulWidget {
  @override
  _SalesChartTwoState createState() => _SalesChartTwoState();
}

class _SalesChartTwoState extends State<SalesChartTwo> {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    const cutOffYValue = 5.0;
    const dateTextStyle = TextStyle(
        fontSize: 10, color: Colors.purple, fontWeight: FontWeight.bold);

    return SizedBox(
      width: 300,
      height: 140,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, appProvider.januaryRevenue),
                FlSpot(1, appProvider.februaryRevenue),
                FlSpot(2, appProvider.marchRevenue),
                FlSpot(3, appProvider.aprilRevenue),
                FlSpot(4, appProvider.mayRevenue),
                FlSpot(5, appProvider.juneRevenue),
                FlSpot(6, appProvider.julyRevenue),
                FlSpot(7, appProvider.augustRevenue),
                FlSpot(8, appProvider.septemberRevenue),
                FlSpot(9, appProvider.octoberRevenue),
                FlSpot(10, appProvider.novemberRevenue),
                FlSpot(11, appProvider.decemberRevenue),
              ],
              isCurved: true,
              barWidth: 8,
              colors: [
                Colors.purpleAccent,
              ],
              belowBarData: BarAreaData(
                show: true,
                colors: [Colors.deepPurple.withOpacity(0.4)],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              aboveBarData: BarAreaData(
                show: true,
                colors: [Colors.orange.withOpacity(0.6)],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          minY: 0,
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 14,
                getTextStyles: (value) => dateTextStyle,
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Jan';
                    case 1:
                      return 'Feb';
                    case 2:
                      return 'Mar';
                    case 3:
                      return 'Apr';
                    case 4:
                      return 'May';
                    case 5:
                      return 'Jun';
                    case 6:
                      return 'Jul';
                    case 7:
                      return 'Aug';
                    case 8:
                      return 'Sep';
                    case 9:
                      return 'Oct';
                    case 10:
                      return 'Nov';
                    case 11:
                      return 'Dec';
                    default:
                      return '';
                  }
                }),
            leftTitles: SideTitles(
              interval: (appProvider.revenue / 10).roundToDouble(),
              showTitles: true,
              getTitles: (value) {
                return "Npr." + '\ ${value + 10}';
              },
            ),
          ),
          axisTitleData: FlAxisTitleData(
              leftTitle: AxisTitle(
                  showTitle: true,
                  titleText: 'Revenue',
                  margin: 20,
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              bottomTitle: AxisTitle(
                  showTitle: true,
                  margin: 0,
                  titleText: DateTime.now().year.toString(),
                  textStyle: dateTextStyle,
                  textAlign: TextAlign.right)),
          gridData: FlGridData(
            show: true,
            checkToShowHorizontalLine: (double value) {
              return value == 1 || value == 6 || value == 4 || value == 5;
            },
          ),
        ),
      ),
    );
  }
}
