// ignore_for_file: use_key_in_widget_constructors

import 'package:admin_app_xem_tro/config/size_config.dart';
import 'package:admin_app_xem_tro/config/widget/button_list_tile.dart';
import 'package:admin_app_xem_tro/config/widget/app_bar_draw.dart';
import 'package:admin_app_xem_tro/screen/admin_screen/Manage_acc_regi/graph/bart_grap.dart';
import 'package:admin_app_xem_tro/config/widget/navigation_draw.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String selectedUserTimeRange = "Week";
  String selectedLandlordTimeRange = "Week";
  late DateTime selectedDate;

  GlobalKey<MyBarGraphState> userBarGraphKey = GlobalKey();
  GlobalKey<MyBarGraphState> landlordBarGraphKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      drawer: const NavigationDraw(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(padding(context)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(padding(context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius(context)),
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  children: [
                    ComboBox(
                      title: "User",
                      onValueChanged: (value) {
                        setState(() {
                          selectedUserTimeRange = value;
                          updateGraphs();
                        });
                      },
                    ),
                    Center(
                      child: SizedBox(
                        height: getHeight(context, height: 0.35),
                        child: MyBarGraph(
                          role: 1,
                          key: userBarGraphKey,
                          timeRange: selectedUserTimeRange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              spaceHeight(context),
              Container(
                padding: EdgeInsets.all(padding(context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius(context)),
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  children: [
                    ComboBox(
                      title: "LandLord",
                      onValueChanged: (value) {
                        setState(() {
                          selectedLandlordTimeRange = value;
                          updateGraphs();
                        });
                      },
                    ),
                    Center(
                      child: SizedBox(
                        height: getHeight(context, height: 0.35),
                        child: MyBarGraph(
                          role: 2,
                          key: landlordBarGraphKey,
                          timeRange: selectedLandlordTimeRange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateGraphs() {
    userBarGraphKey.currentState?.updateGraph();
    landlordBarGraphKey.currentState?.updateGraph();
  }
}