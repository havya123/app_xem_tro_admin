// ignore_for_file: constant_identifier_names, unnecessary_nullable_for_final_variable_declarations, unrelated_type_equality_checks

import 'dart:async';

import 'package:admin_app_xem_tro/config/size_config.dart';
import 'package:admin_app_xem_tro/models/users.dart';
import 'package:admin_app_xem_tro/provider/bar_provider.dart';
import 'package:admin_app_xem_tro/models/bar.dart';
import 'package:admin_app_xem_tro/screen/admin_screen/Manage_acc_regi/graph/bar_data_process.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBarGraph extends StatefulWidget {
  const MyBarGraph({
    Key? key,
    this.timeRange = "Week",
    this.weeklySummary,
    this.monthlySummary,
    this.role,
  }) : super(key: key);

  final String timeRange;
  final List? weeklySummary;
  final List? monthlySummary;
  final int? role;

  @override
  State<MyBarGraph> createState() => MyBarGraphState();
}

class MyBarGraphState extends State<MyBarGraph> {
  late BarDataWeek myBarDataWeek;
  late BarDataMonth myBarDataMonth;
  bool dataLoaded = false;
  bool _isMounted = false;

  Timer? updateTimer;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    myBarDataWeek = BarDataWeek.empty();
    myBarDataMonth = BarDataMonth.empty();
    fetchDataAndUpdateGraph();
    Provider.of<BarDataProvider>(context, listen: false).onDataChanged =
        () => updateGraph();
    updateTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      if (_isMounted) {
        fetchDataAndUpdateGraph();
      }
    });
  }

  @override
  void dispose() {
    _isMounted = false;
    updateTimer?.cancel();
    super.dispose();
  }

  fetchDataAndUpdateGraph() async {
    final firebaseProvider =
        Provider.of<BarDataProvider>(context, listen: false);
    try {
      if (_isMounted) {
        await firebaseProvider.fetchUserRegistrations();
        if (_isMounted) {
          updateGraphData();
          setState(() {
            dataLoaded = true;
          });
        }
      }
    } catch (e) {
      // Handle exceptions, and check for null values
      if (kDebugMode) {
        print('Error fetching user registrations: $e');
      }
    }
  }

  void updateGraphData() {
    final firebaseProvider =
        Provider.of<BarDataProvider>(context, listen: false);
    final List<User>? weeklyUserRegistrations =
        firebaseProvider.weeklyUserRegistrations;
    final List<User>? monthlyUserRegistrations =
        firebaseProvider.monthlyUserRegistrations;

    if (widget.timeRange == "Week" && weeklyUserRegistrations != null) {
      myBarDataWeek = BarChartDataProcessor.calculateBarDataWeek(
          weeklyUserRegistrations, widget.role!);
      myBarDataWeek.initializeBarDataWeek();
    } else if (widget.timeRange == "Month" &&
        monthlyUserRegistrations != null) {
      myBarDataMonth = BarChartDataProcessor.calculateBarDataMonth(
          monthlyUserRegistrations, widget.role!);
      myBarDataMonth.initializeBarDataMonth();
    }

    // if (kDebugMode) {
    //   print('Weekly Registrations: $weeklyUserRegistrations');
    //   print('Monthly Registrations: $monthlyUserRegistrations');
    // }
  }

  void updateGraph() {
    if (_isMounted) {
      setState(() {
        dataLoaded = false; // Reset the flag before updating the graph data
      });
      fetchDataAndUpdateGraph(); // Reload data
      if (_isMounted) {
        setState(() {
          dataLoaded = true; // Set the flag after updating the graph data
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Time Range: ${widget.timeRange}');
    }
    return dataLoaded
        ? BarChart(
            BarChartData(
              maxY: 100,
              minY: 0,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  top: BorderSide.none,
                  bottom: BorderSide(color: Colors.black),
                  left: BorderSide(color: Colors.black),
                  right: BorderSide.none,
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 50,
                    reservedSize: getWidth(context, width: 0.085),
                  ),
                ),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: widget.timeRange == "Week"
                    ? const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: getBottomWeekTiles,
                        ),
                      )
                    : const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: getBottomMonthlyTiles,
                        ),
                      ),
              ),
              barGroups: (widget.timeRange == "Week"
                      ? myBarDataWeek.barData
                      : myBarDataMonth.barData)
                  .map(
                    (data) => BarChartGroupData(
                      x: data.x,
                      barRods: [
                        BarChartRodData(
                          toY: data.y,
                          color: Colors.blue,
                          borderRadius: BorderRadius.zero,
                          width: getWidth(context),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
        : const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Loading"),
              ],
            ),
          );
  }
}

Widget getBottomWeekTiles(double value, TitleMeta meta) {
  final int weekIndex = value.toInt();
  final DayOfWeek week = DayOfWeek.values[weekIndex];
  final String weekName = week.toString().split('.').last.substring(0, 3);

  return SideTitleWidget(axisSide: meta.axisSide, child: Text(weekName));
}

Widget getBottomMonthlyTiles(double value, TitleMeta meta) {
  final int monthIndex = value.toInt() + 1;
  final String monthNumber = monthIndex.toString();

  return SideTitleWidget(axisSide: meta.axisSide, child: Text(monthNumber));
}
