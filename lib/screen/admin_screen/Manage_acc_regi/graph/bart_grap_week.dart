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

class MyBarGraphWeek extends StatefulWidget {
  const MyBarGraphWeek({
    Key? key,
    this.weeklySummary,
    this.user,
    this.landlord,
    required this.selectedWeekStart,
    required this.selectedWeekEnd,
  }) : super(key: key);

  final List? weeklySummary;
  final int? user, landlord;
  final DateTime selectedWeekStart;
  final DateTime selectedWeekEnd;

  @override
  State<MyBarGraphWeek> createState() => MyBarGraphWeekState();
}

class MyBarGraphWeekState extends State<MyBarGraphWeek> {
  late BarDataWeek myBarDataWeek;
  bool dataLoaded = false;
  bool _isMounted = false;

  Timer? updateTimer;
  Completer<void>? _dataFetchingCompleter;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    myBarDataWeek = BarDataWeek.empty();
    _dataFetchingCompleter = Completer<void>();
    fetchDataAndUpdateGraph();
  }

  @override
  void dispose() {
    _isMounted = false;
    updateTimer?.cancel();

    if (!_dataFetchingCompleter!.isCompleted) {
      _dataFetchingCompleter?.complete();
    }

    super.dispose();
  }

  void fetchDataAndUpdateGraph() async {
    final barProvider = Provider.of<BarDataProvider>(context, listen: false);
    try {
      if (_isMounted) {
        await barProvider.fetchUserRegistrations(widget.selectedWeekStart, widget.selectedWeekEnd);
        if (_isMounted) {
          updateGraphData();
          setState(() {
            dataLoaded = true;
          });
          if (!_dataFetchingCompleter!.isCompleted) {
            _dataFetchingCompleter?.complete();
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user registrations: $e');
      }
      if (!_dataFetchingCompleter!.isCompleted) {
        _dataFetchingCompleter?.completeError(e);
      }
    }
  }

  void updateGraphData() {
    final barProvider = Provider.of<BarDataProvider>(context, listen: false);
    final List<User>? weeklyUserRegistrations = barProvider.weeklyUserRegistrations;

    if (weeklyUserRegistrations != null) {
      setState(() {
        myBarDataWeek = BarChartDataProcessor.calculateBarDataWeek(
          weeklyUserRegistrations,
          widget.user!,
          widget.landlord!,
        );
        myBarDataWeek.initializeBarDataWeek();
        dataLoaded = true;
      });
    }
  }

  void updateGraph() {
    if (_isMounted) {
      setState(() {
        dataLoaded = false;
        myBarDataWeek = BarDataWeek.empty();
      });

      fetchDataAndUpdateGraph();

      if (_isMounted) {
        setState(() {
          dataLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 20,
                    reservedSize: getWidth(context, width: 0.085),
                  ),
                ),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: getBottomWeekTiles,
                  ),
                ),
              ),
              barGroups: myBarDataWeek.barData
                  .map(
                    (data) => BarChartGroupData(
                      x: data.x.toInt(),
                      barRods: [
                        BarChartRodData(
                          toY: data.yUsers,
                          color: Colors.blue,
                          borderRadius: BorderRadius.zero,
                          width: getWidth(context,width: 0.035),
                        ),
                        BarChartRodData(
                          toY: data.yLandlords,
                          color: Colors.green,
                          borderRadius: BorderRadius.zero,
                          width: getWidth(context,width: 0.035),
                        ),
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


