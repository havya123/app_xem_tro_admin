import 'package:admin_app_xem_tro/config/size_config.dart';
import 'package:admin_app_xem_tro/provider/booking_data_provider.dart';
import 'package:admin_app_xem_tro/models/pie_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyPieGraph extends StatefulWidget {
  final BookingDataProvider dataProvider;

  const MyPieGraph({Key? key, required this.dataProvider}) : super(key: key);

  @override
  State<MyPieGraph> createState() => _MyPieGraphState();
}

class _MyPieGraphState extends State<MyPieGraph> {
  @override
  void initState() {
    super.initState();
    // Listen for data changes
    widget.dataProvider.onDataChanged = () {
      // Update the graph when data changes
      if (mounted) {
        if (kDebugMode) {
          print("Data changed. Updating graph.");
        }
        setState(() {});
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius(context)),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          FutureBuilder(
            future: widget.dataProvider.loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                if (kDebugMode) {
                  print("Loading data...");
                }
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text("Loading"),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                if (kDebugMode) {
                  print("Error loading data: ${snapshot.error}");
                }
                return Text("Error: ${snapshot.error}");
              } else {
                return SfCircularChart(
                  title: ChartTitle(
                      text: "BOOKING",
                      textStyle: const TextStyle(fontSize: 30)),
                  legend: const Legend(
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap,
                    position: LegendPosition.right,
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  series: <CircularSeries>[
                    RadialBarSeries<BookingData, String>(
                      dataSource: [
                        BookingData(
                            'Waiting', widget.dataProvider.totalWaitingCount),
                        BookingData(
                            'Accept', widget.dataProvider.totalAcceptCount),
                        BookingData(
                            'Decline', widget.dataProvider.totalDeclineCount),
                      ],
                      yValueMapper: (BookingData data, _) => data.count,
                      xValueMapper: (BookingData data, _) => data.status,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
