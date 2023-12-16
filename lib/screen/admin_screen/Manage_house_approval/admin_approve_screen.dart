// ignore_for_file: constant_identifier_names

import 'package:admin_app_xem_tro/config/widget/item.dart';
import 'package:admin_app_xem_tro/models/house.dart';
import 'package:admin_app_xem_tro/provider/house_provider.dart';
import 'package:admin_app_xem_tro/config/widget/navigation_draw.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminApproveScreen extends StatefulWidget {
  const AdminApproveScreen({Key? key}) : super(key: key);

  @override
  State<AdminApproveScreen> createState() => _AdminApproveScreenState();
}

class _AdminApproveScreenState extends State<AdminApproveScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('Initializing AdminApproveScreen...');
    }
  }

  Future<void> _refreshData() async {
    final houseProvider = Provider.of<HouseProvider>(context, listen: false);
    await houseProvider
        .refreshData();
  }

  @override
  Widget build(BuildContext context) {
    final houseProvider = Provider.of<HouseProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Welcome Back"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Chờ duyệt"),
              Tab(text: "Đã duyệt"),
              Tab(text: "Không duyệt"),
            ],
          ),
        ),
        drawer: const NavigationDraw(),
        body: SafeArea(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refreshData,
            child: TabBarView(
              children: [
                _buildTab(houseProvider.housesWaiting),
                _buildTab(houseProvider.housesAccept),
                _buildTab(houseProvider.housesDeclines),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(List<House> houses) {
    if (houses.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    return ListView.builder(
      itemCount: houses.length,
      itemBuilder: (context, index) {
        return HouseItem(house: houses[index]);
      },
    );
  }
}
