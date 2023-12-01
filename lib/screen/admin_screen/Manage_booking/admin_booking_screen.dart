// ignore_for_file: unused_import

import 'package:admin_app_xem_tro/config/size_config.dart';
import 'package:admin_app_xem_tro/config/widget/button_list_tile.dart';
import 'package:admin_app_xem_tro/provider/booking_data_provider.dart';
import 'package:admin_app_xem_tro/config/widget/app_bar_draw.dart';
import 'package:admin_app_xem_tro/config/widget/navigation_draw.dart';
import 'package:admin_app_xem_tro/models/pie_data.dart';
import 'package:admin_app_xem_tro/screen/admin_screen/Manage_booking/pie_graph/pie_graph.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AdminBookingScreen extends StatefulWidget {
  const AdminBookingScreen({super.key});

  @override
  State<AdminBookingScreen> createState() => _AdminBookingScreenState();
}

class _AdminBookingScreenState extends State<AdminBookingScreen> {
  late BookingDataProvider _dataProvider;

  @override
  void initState() {
    _dataProvider = BookingDataProvider();
    _dataProvider.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarCustom(),
        drawer: const NavigationDraw(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(padding(context)),
            child: Center(
              heightFactor: getHeight(context, height: 0.00225),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyPieGraph(dataProvider: _dataProvider),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
